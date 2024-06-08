# library(googledrive) # to update permissions / google identity
# trackdown documentation: https://claudiozandonella.github.io/trackdown/
library(here)
google_path <- "" # Point to a Google folder with a local parameter, specific to this project
trackdown::trackdown_auth_configure(path ="track_down_secret.json")     

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
    mutate(
      fname = str_extract(path, "[^//]*\\.Rmd"),
      fname = str_remove(fname, "\\.Rmd")
    ) %>%
    select(fname, modification_time, size)

  rmd_list
}

list_drive_files <- function() {
  # list all Google Drive files in a directory

  library(tidyverse)
  library(lubridate)
  library(googledrive)
  google_drive_files <- drive_ls(path = google_path) # path is defined globally
  dr <- google_drive_files$drive_resource
  google_drive_files <- tibble(
    g_name = map_chr(dr, ~ .x$name),
    file_id = map_chr(dr, ~ .x$id),
    last_g_editor_id = map_chr(dr, ~ .x$lastModifyingUser$emailAddress),
    g_created_time = ymd_hms(map_chr(dr, ~ .x$createdTime)),
    g_modified_time = ymd_hms(map_chr(dr, ~ .x$modifiedTime))
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
    by = c("fname" = "g_name")
  )

  update_files <- combined_project_files %>%
    filter(g_modified_time < modification_time) %>%
    mutate(message_text = glue("update('{fname}.Rmd', force = TRUE)"))

  update_files <- update_files %>%
    select(message_text) %>%
    unlist()
  cat('\n\n  update these ".Rmd" files:\n', update_files, sep = "\n")

  upload_files <- combined_project_files %>%
    filter(is.na(g_modified_time)) %>%
    mutate(
      message_text =
        glue::glue('upload("{fname}.Rmd")')
    ) %>%
    select(message_text) %>%
    unlist()
  cat('\n\n  upload these ".Rmd" files:\n', upload_files, sep = "\n")

  download_files <- combined_project_files %>%
    filter(last_g_editor_id != "jd8.smith@gmail.com" |
      (g_created_time > g_modified_time)) %>%
    mutate(
      message_text =
        glue("download('{fname}.Rmd', force = TRUE)")
    ) %>%
    arrange(desc(g_modified_time))
  cat('\n\n  DOWNLOAD these ".Rmd" files:\n',
    download_files$message_text,
    sep = "\n"
  )

  return(combined_project_files)
}

# Google Upload / download functions

upload <- function(file, gfile, gpath, hide_code = F, ...) {
  `if`(!file.exists(".trackdown_files.csv"), {
    myData <- data.frame(matrix(nrow = 0, ncol = 2))
    colnames(myData) <- c("files", "file_ids")
    write.csv(myData, ".trackdown_files.csv", row.names = FALSE, col.names = FALSE, sep = ",")
  })

  trackdown_files <- read.csv(".trackdown_files.csv")

  try(if (file %in% trackdown_files$files) stop("this file is already tracked"))
  
  upload_file(file = file, gfile = gfile, gpath = gpath, hide_code = hide_code, ...)
  drive_find(gfile, )
  file_id <- drive_ls(gpath) %>%
    filter(name == gfile) %>%
    pull(id)


  trackdown_files <- rbind(trackdown_files, tibble(files = file, file_ids = file_id))
  print(trackdown_files)
  write.csv(trackdown_files, file = ".trackdown_files.csv", row.names = FALSE, col.names = FALSE, sep = ",")
}

get_id_path <- function(file, recorded = T, file_name) {
  if (recorded) {
  trackdown_files <- read.csv(".trackdown_files.csv")
  file_id <- subset(trackdown_files, files == file)$file_ids
  file_path <- drive_get(id = file_id) |>
    drive_reveal("path") |>
    pull(path)
  } else {
    file_path <- drive_find(file_name)[1, ] |>
      drive_reveal("path") |>
      pull(path)
  }
  print(file_path)
  file_path_split <- strsplit(file_path, "/(?=[^/]+$)", perl = TRUE)[[1]]
  file_name <- file_path_split[2]
  file_dir <- file_path_split[1] |> str_remove("~/")
  return(c("file_name" = file_name, "file_dir" = file_dir))
}

update <- function(file, hide_code = F,...) {
  file_name_dir <- get_id_path(file)
  update_file(file = file, gfile = file_name_dir["file_name"], gpath = file_name_dir["file_dir"], hide_code = hide_code, ...)
}

download <- function(file, ...) {
  file_name_dir <- get_id_path(file)
  download_file(file = file, gfile = file_name_dir["file_name"], gpath = file_name_dir["file_dir"], ...)
}
# download_file(file = "chapters/data_manipulation.qmd", gfile = file_name, gpath = file_dir)
##

# all_files <- compare_drive()
# update("index.Rmd", force = TRUE)              # frequent
# upload("map-center-size.Rmd")    # first-time-only
# download("index.Rmd", force = TRUE)
#
# file_id <- subset(trackdown_files, files == file)$file_ids
# file_path <- drive_find("05. Data Manipulation") |>
#   drive_reveal("path") |>
#   pull(path)
# print(file_path)
# file_path_split <- strsplit(file_path[1], "/(?=[^/]+$)", perl = TRUE)[[1]]
# file_name <- file_path_split[2]
# file_dir <- file_path_split[1] |> str_remove("~/")
# return(c("file_name" = file_name, "file_dir" = file_dir))
#
# download_file(file = "chapters/data_manipulation.qmd", 
#               gfile = file_name, 
#               gpath = file_dir)
#
# temp <- get_id_path(file = NULL,
#             recorded = F,
#             file_name = "06. Tidy Data")
# download_file(file = "chapters/tidy_data.qmd",
#               gfile = temp["file_name"],
#               gpath = temp["file_dir"])
