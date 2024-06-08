file_paths <- tribble(
  ~Description,                       ~Path,
  "05. Data Manipulation",            "chapters/data_manipulation.qmd",
  "06. Tidy Data",                    "chapters/tidy_data.qmd",
  "07. Relational Data",              "chapters/data_bases.qmd",
  "08. Data Validation",              "chapters/data_validation.qmd",
  "09. Imputation",                   "chapters/imputation.qmd",
  "10. Reproducible Research",        "chapters/repres.qmd",
  "11. Reproducible Environment",     "chapters/renv.qmd",
  "12. Command Line",                 "chapters/command_line.qmd",
  "13. Version Control",              "chapters/version_control.qmd",
  "14. Style and Lint",               "chapters/linter_styler.qmd",
  "15. Modular Code",                 "chapters/modular_code.qmd",
  "16. Literature Research",          "chapters/litreview.qmd",
  "17. Write",                        "chapters/write.qmd",
  "18. Layout and References",        "chapters/layout_refs.qmd",
  "21. Survey Error 1",               "chapters/survey_se.qmd",
  "22. Design Questions",             "chapters/good_questions.qmd",
  "23. Survey Tools 1",               "chapters/survey_tools.qmd",
  "24. Document",                     "chapters/documentation.qmd",
  "25. APIs",                         "chapters/api.qmd",
  "26. APIs in R",                    "chapters/APIs_in_r.qmd",
  "27. Data Visualization Fundamentals", "chapters/visualization_theory.qmd",
  "28. Data Visualization",           "chapters/data_viz.qmd",
  "29. A Graph for The Job",          "chapters/which_graph.qmd",
  "30. Color Data",                   "chapters/color.qmd",
  "31. Color Systems",                "chapters/color_scheme.qmd",
  "32. Make Tables",                  "chapters/tables.qmd"
)

new_file_dir <- "Tkachenko_Nikita_Data_Insight_Foundations (1)/05_Ready for Editorial Approval"

map2(file_paths$Path, file_paths$Description, 
    \(file, name)
       upload(file, name, new_file_dir, force = T, open = F))


file_paths <- tribble(
  ~Description,  ~Path,
  # "01. Introduction", "chapters/intro.qmd",
  # "03. Summary", "chapters/summary.qmd",
  # "04. Set Up", "chapters/setup.qmd",
  # "19. Collaboration", "chapters/collaboration.qmd",
  # "20. Templating", "chapters/template.qmd"
  "02. Acknowledgements", "chapters/acknowledgements.qmd",
  "33. Epilogue", "chapters/epilogue.qmd",
  "34. References", "chapters/references.qmd"
)

new_file_dir <- "Tkachenko_Nikita_Data_Insight_Foundations (1)/02_Ready for Tech Review"

map2(file_paths$Path, file_paths$Description, 
    \(file, name)
       upload(file, name, new_file_dir, force = T, open = F))

update("chapters/acknowledgements.qmd")

###################

file_paths <- tribble(
  ~Description,  ~Path,
  "01. Introduction", "chapters/intro.qmd",
  "03. Summary", "chapters/summary.qmd",
  "04. Set Up", "chapters/setup.qmd",
  "19. Collaboration", "chapters/collaboration.qmd",
  "20. Templating", "chapters/template.qmd"
)

new_file_dir <- "Tkachenko_Nikita_Data_Insight_Foundations (1)/05_Ready for Editorial Approval"

map2(file_paths$Path, file_paths$Description, 
     \(file, name)
     upload(file, name, new_file_dir, force = T, open = F))
