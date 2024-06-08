setwd("/Users/nikitoshina/personal/quarto_book/")

if (Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR") != "") {
    output_path <- paste0(Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR"), "/book-latex/chapters")
} else {
    output_path <- "_output/book-latex/chapters"
}

purrr::keep(list.files(output_path, recursive = TRUE, full.names = TRUE), \(file) stringr::str_detect(file, "unnamed-chunk")) |>
    purrr::walk(\(file) file.remove(file))

print("unnamed-chunk files removed")

# list.files(paste0(output_path,"/images"), recursive = T, full.names = TRUE) |>
#     paste(collapse = "\\n") |> clipr::write_clip()
