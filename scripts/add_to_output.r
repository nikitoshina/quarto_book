file.copy(
    list.files("/Users/nikitoshina/personal/quarto_book/add_to_output", 
               full.names = TRUE, 
               recursive = FALSE),
    recursive = TRUE, 
    to = "_output/book-latex")


