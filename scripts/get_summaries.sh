#!/bin/bash

# Define the list of files
files=(
    "chapters/intro.qmd"
    "chapters/acknowledgements.qmd"
    "chapters/summary.qmd"
    "chapters/setup.qmd"
    "chapters/data_manipulation.qmd"
    "chapters/tidy_data.qmd"
    "chapters/data_bases.qmd"
    "chapters/data_validation.qmd"
    "chapters/imputation.qmd"
    "chapters/repres.qmd"
    "chapters/renv.qmd"
    "chapters/command_line.qmd"
    "chapters/version_control.qmd"
    "chapters/linter_styler.qmd"
    "chapters/modular_code.qmd"
    "chapters/litreview.qmd"
    "chapters/write.qmd"
    "chapters/layout_refs.qmd"
    "chapters/collaboration.qmd"
    "chapters/template.qmd"
    "chapters/survey_se.qmd"
    "chapters/good_questions.qmd"
    "chapters/survey_tools.qmd"
    "chapters/documentation.qmd"
    "chapters/api.qmd"
    "chapters/APIs_in_r.qmd"
    "chapters/google.qmd" 
    "chapters/qualtrics_api.qmd" 
    "chapters/visualization_theory.qmd"
    "chapters/data_viz.qmd"
    "chapters/which_graph.qmd"
    "chapters/color.qmd"
    "chapters/color_scheme.qmd"
    "chapters/tables.qmd"
    "chapters/epilogue.qmd"
    "chapters/references.qmd"
)

# Create or empty the summary file at the start
summary_file="all_summaries.md"
> "$summary_file"

# Loop through each file
for file in "${files[@]}"; do
    # Check if the file contains "## Summary"
    if grep -q "## Summary" "$file"; then
        # Extract everything after "## Summary" and append to the summary file
        awk '/## Summary/ {flag=1; next} flag' "$file" >> "$summary_file"
        
        # Optionally, add a separator or the file name for clarity
        echo -e "$file" "\n---\n" >> "$summary_file"
    fi
done

echo "Summaries have been collected in $summary_file"

