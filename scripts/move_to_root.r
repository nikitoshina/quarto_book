file.copy(
    list.files("_output/book-latex", 
               full.names = TRUE, 
               recursive = FALSE),
    recursive = TRUE, 
    to = "./latex_output")
