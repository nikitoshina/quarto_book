# Somehow i keep ending up in a wrong directory
setwd("/Users/nikitoshina/personal/quarto_book/")

if (Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR") != "") {
    output_path <- paste0(Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR"), "/book-latex/individual_tex_files_all/")
    file_name <- Sys.getenv("QUARTO_PROJECT_OUTPUT_FILES")
} else {
    setwd("/Users/nikitoshina/personal/quarto_book/")
    output_path <- "_output/book-latex/individual_tex_files_all/"
    file_name <- "./_output/book-latex/Practical-tools-for-modern-research.tex"
}


library(tidyverse)


# Define a function to split the LaTeX document
contents <- read_file(file_name)

# file_location = paste0(part_name, "/", chapter_n, "_", chapter_label, ".tex"),
# Use the function
split_text <- enframe(str_split(contents, "\n")[[1]], name = "line", value = "text")
lines <- split_text %>%
    # Find Chapter (parts don't have labels)
    mutate(
        chapter = str_detect(text, pattern = r"{\\chapter\{}"),
        no_label = str_detect(text, pattern = r"{\\label\{(.*)\}}", negate = TRUE),
    ) %>%
    filter(no_label & chapter) %>%
    pull(line)
# Some Chapters are split across two lines, (None are 3 lines long, it can be fixed by running the flow above once more)
split_text[lines, "text"] <- paste0(split_text[lines, "text", drop = TRUE], split_text[lines + 1, "text", drop = TRUE])

ready <- split_text %>%
    slice(-(lines + 1)) %>%
    mutate(
        # document_start = str_detect(text, pattern = r"{\\begin\{document\}}"),
        # document_end = str_detect(text, pattern = r"{\\end\{document\}}"),
        # document = cumsum(document_start) + cumsum(document_end),
        # preamble = document == 0,
        part = str_detect(text, pattern = r"{\\part\{}"),
        part_n = cumsum(part),
        chapter = str_detect(text, pattern = 
            # Because I use chapter* in an example, it splits incorrectly that particular chapter
            if_else(
                part_n > 5,
            r"{\\chapter\*?\{}",
            r"{\\chapter\{}"
                )

        ),
        part_name_raw = if_else(part,
            str_extract(text, pattern = r"{\\part\{(.*)\}}", group = 1),
            NA
        ),
        part_name = if_else(part,
            part_name_raw |>
                str_replace_all(pattern = " ", "_") %>%
                paste0(part_n, "_", .),
            NA
        )
    ) %>%
    mutate(
        chapter_n = cumsum(chapter),
        chapter_label = if_else(chapter,
            str_extract(text, pattern = r"{\\label\{(.*)\}}", group = 1) %>%
                paste0(chapter_n, "_", .),
            NA
        ),
        .by = part_n
    ) %>%
    fill(part_name) %>%
    fill(chapter_label) %>%
    mutate(
        # file_location = paste0(part_name, "/", chapter_label, ".tex"),
        #         file_location = if_else(file_location == "NA/NA.tex", "preamble.tex", file_location)
        file_location = case_when(
            is.na(part_name) & is.na(chapter_label) ~ "preamble.tex",
            is.na(part_name) & !is.na(chapter_label) ~ paste0("0_frontmatter/", chapter_label, ".tex"),
            .default = paste0(part_name, "/", chapter_label, ".tex")
        )
    )

# We need to remove part with Part because it drops into a separe chapter in a wrong part,
# We will just create separate part file later.
# It might be an issue if you have text for the part,
# I don't and will add it in LaTeX later
chapter_ready <- ready %>%
    filter(!part) %>%
    select(file_location, line, text, chapter, part_name) %>%
    arrange(line) %>%
    summarize(
        text = str_flatten(text, collapse = "\n"),
        .by = c(file_location, part_name)
    ) %>%
    # for some reason I get random empty chapters
    filter(text != "")

# It won't create the directory if it already exists
dir.create(output_path, showWarnings = FALSE)
walk(c(unique(chapter_ready$part_name), "0_frontmatter") |> na.omit(), \(directory) dir.create(paste0(output_path, directory), showWarnings = FALSE))
# Part files
part_files <- ready %>%
    select(part_name, part_name_raw, part) %>%
    filter(part) %>%
    mutate(
        location = paste0(output_path, part_name, "/0_", str_replace_all(tolower(part_name_raw), pattern = " ", replacement = "-"), ".tex"),
        text = paste0("\\part{", part_name_raw, "}\n"),
    ) %>%
    select(location, text)

# Write Parts and Chapter files
walk2(part_files$location, part_files$text, \(location, text) write_file(text, location))
walk2(chapter_ready$file_location, chapter_ready$text, \(location, text) write_file(text, paste0(output_path, location)))

# [-1] removes preample
files_paths <- c("preample.tex", c(chapter_ready$file_location, str_remove(part_files$location, output_path))[-1] %>% sort())
# Copy paths to all files
paste0("\\input{individual_tex_files_all/", files_paths, "}") %>%
    str_c(collapse = "\n") |>
    clipr::write_clip(
        allow_non_interactive = TRUE
    )


