# library(googledrive) # to update permissions / google identity
# trackdown documentation: https://claudiozandonella.github.io/trackdown/
library(here)

google_path <- "" # Point to a Google folder with a local parameter, specific to this project

list_rmd <- function() {
# list all local .Rmd files

  library(tidyverse)
  library(fs)
  library(here)

  rmd_list <- dir_info(here(), recurse = FALSE) %>%
  filter(type == "file") %>%
  arrange(desc(modification_time)) %>%
  filter(str_detect(path, "Rmd$")) %>%
  select(path, size, modification_time) %>%
  mutate(fname = str_extract(path,  '[^//]*\\.Rmd'),
         fname = str_remove(fname, "\\.Rmd")) %>%
  select(fname, modification_time, size)

  rmd_list
}

list_drive_files <- function() {
  # list all Google Drive files in a directory
  
  library(tidyverse)
  library(lubridate)
  library(googledrive)
  google_drive_files <- drive_ls(path = google_path)  # path is defined globally
  dr <- google_drive_files$drive_resource
  google_drive_files <- tibble(
    g_name = map_chr(dr, ~.x$name),
    file_id = map_chr(dr, ~.x$id),
    last_g_editor_id = map_chr(dr, ~.x$lastModifyingUser$emailAddress),
    g_created_time = ymd_hms(map_chr(dr, ~.x$createdTime)),
    g_modified_time = ymd_hms(map_chr(dr, ~.x$modifiedTime))
    ) %>% 
    mutate(file_id = paste0("https://docs.google.com/document/d/", file_id)) %>% 
    arrange(desc(g_modified_time)) %>% 
    filter(g_name != "Meta")
    
  google_drive_files
}

compare_drive <- function() {
  library(glue)
  library(tidyverse)
  local_files <- list_rmd()
  drive_files <- list_drive_files()
  combined_project_files <- full_join(local_files, drive_files, 
                                       by = c("fname" = "g_name"))
  
  update_files <- combined_project_files %>% 
    filter(g_modified_time < modification_time) %>% 
    mutate(message_text = glue("update('{fname}.Rmd', force = TRUE)")) 

  update_files <- update_files %>% 
    select(message_text) %>% unlist()
    cat('\n\n  update these ".Rmd" files:\n', update_files, sep = "\n")

  upload_files <- combined_project_files %>%
    filter(is.na(g_modified_time)) %>%
    mutate(message_text = 
             glue::glue('upload("{fname}.Rmd")')) %>% 
    select(message_text) %>% unlist()
    cat('\n\n  upload these ".Rmd" files:\n', upload_files, sep = "\n")
  
  download_files <- combined_project_files %>% 
    filter(last_g_editor_id != "jd8.smith@gmail.com" | 
      (g_created_time > g_modified_time)) %>% 
    mutate(message_text = 
             glue("download('{fname}.Rmd', force = TRUE)")) %>% 
    arrange(desc(g_modified_time))
    cat('\n\n  DOWNLOAD these ".Rmd" files:\n',
        download_files$message_text, sep = "\n")
  
  return(combined_project_files)
}

# Google Upload / download functions

upload <- function(file_name) {  
  library(googledrive)
  library(trackdown)
  # for first time use
  upload_file(file_name, 
    gpath = google_path, # a local parameter for each project
    hide_code = TRUE
  )
}

update <- function(file_name, ...) {
  library(googledrive)
  library(trackdown)
  update_file(file_name, 
              gpath = google_path,
              hide_code = TRUE, ...
  )
}

download <- function(file_name, ...) {
  library(googledrive)
  library(trackdown)
  download_file(file_name, gpath = google_path, ...)
}

## 

# all_files <- compare_drive()
# update("index.Rmd", force = TRUE)              # frequent
# upload("map-center-size.Rmd")    # first-time-only
# download("index.Rmd", force = TRUE)
