1. Introduction
   1. About the book
   1. Who Should Read This Book
1. Summary
1. Set up
   1. R and RStudio Set Up
   1. Download R
      1. For macOS
      1. For Windows
   1. Download RStudio
   1. Configure RStudio
   1. Install Packages
1. Data Manipulation
   1. Basics
      1. Data Types
   1. Downloading Data
      1. Example Data
   1. Basic Data Management With `dplyr`
      1. `select()`
      1. `filter()`
      1. `arrange()`
      1. `mutate()`
      1. `recode()`
      1. `summarize()`
      1. `group_by()` and `ungroup()`
         1. `group_by()`
         1. `ungroup()`
         1. `.by`
      1. `rowwise()`
      1. `count()`
      1. `rename()`
      1. `row_number()`
      1. `skim()`
1. Tidy Data
   1. Example
   1. `pivot_longer()`
   1. `pivot_wider()`
   1. `separate()` and `unite()`
   1. `tibble()` and `tribble()`
   1. `janitor`: Clean Your Data
      1. `clean_names()`
      1. `remove_empty()`
      1. `remove_constant()`
      1. `convert_to_date()` and `convert_to_datetime()`
      1. `row_to_names()`
1. Relational Databases
   1. Relationship Types { sec-relationships}
      1. One to One (1:1)
      1. One Many (1:M)
      1. Many to Many (M:N)
   1. The Concept of Keys
   1. Types of Joins
      1. Outer Joins
         1. Left Join
         1. Right Join
         1. Full Join
         1. Inner Join
      1. Filtering Joins
         1. Anti Join
         1. Semi Join
   1. Visualizing Databases
1. Optimizing Data Validation
   1. Manual Inspection
   1. Handling Data Issues
      1. Base R
      1. Assert Your Conditions
      1. Precise Validation with Pointblank
         1. Step 1: Create a Validation Plan (an Agent)
         1. Step 2: Specify Checks
         1. Step 3: Execute Checks
1. Imputation
   1. Types of Missing Data
   1. Dealing with Missing Data
      1. Explicitly Handling Missing Data with `complete()`
      1. Simple Imputations
         1. Fixed Value Imputation
         1. Mean and Median Imputation
         1. Fill
         1. K-Nearest Neighbors (KNN)
         1. Maximum Likelihood
         1. Regression
         1. Forest
      1. Multiple Imputations
         1. MICE (Multivariate Imputation by Chained Equations)
         1. Table of Imputations
1. Reproducible Research
   1. Literate Programming
      1. Example: Customer Satisfaction Survey Analysis
1. Reproducible Environment
   1. `renv`
      1. Workflow
   1. Modular Code
      1. Reuse Functions
      1. Split It
      1. `box` It
1. Style and Lint your Code
   1. White Spaces and Indentation
   1. Naming Conventions
   1. Use of Braces
   1. Comments
   1. Long Functions
   1. Styler
   1. Linter
   1. Why do we care?
1. Introduction to Command Line
   1. Learning Basic Commands
      1. Navigation
      1. File Manipulation
      1. Directory Management
   1. Terminal
      1. Getting Started with Nano
         1. Starting Nano
      1. Basic Navigation
         1. Editing Text
         1. Saving and Exiting
         1. Getting Help
1. Version Control with Git and Github
   1. Git and Github
   1. Basics
   1. Contribute
   1. Guide to Using .gitignore
      1. Creating a .gitignore file
      1. Specifying Files to Ignore
      1. The Global .gitignore file
      1. .gitignore in Other Programs
   1. Other Resources
1. Literature Research
   1. Search
   1. Reference Management
   1. Reading
   1. Taking notes
1. Write 1. WYSIWYG 1. Markup Languages 1. HTML 1. LaTeX 1. Markdown 1. Yet Another Markup Language (YAML) 1. Pandoc 1. Quarto 1. Installing 1. RStudio 1. Visual Studio Code 1. Your First Document
   1.ayout and References 1. Knitr 1. Div Blocks 1. Diagrams 1. Citations
1. Thesis Template
   1. Getting Started
      1. RStudio
      1. Visual Studio Code
   1. Adding the Quarto Template
   1. Usage
1. Collaboration 1. `trackdown` and Google Docs
1. Survey Error
   1. Total Survey Error (TSE)
   1. Basic Theoretical Model of the Survey Process
      1. Establishing goals
      1. Target Population and Sampling Frame
      1. Representativeness
   1. Iterative Design
   1. The People You Ask and Those Who Respond
   1. What Responses Depend On
   1. How BAD Are U???
   1. Answering a Question
      1. Enhancing Question Quality
   1. Design Questions
      1. Guidelines for Effective Question Design
      1. The Impact of Question Order
      1. Survey Says: Bacon!
      1. Types of Question Formats
      1. Likert Scales
      1. I don't know and N/A Options
      1. Survey Length
      1. Survey Invitation
   1. Survey Tools
      1. Physical Survey Methods
      1. Digital Survey Tools
      1. Participant Recruitment Platforms
1. APIs
   1. Monsieur!
   1. Your First Order
   1. Utilizing APIs in R
      1. Incorporating Request Body and Headers
1. Google Services in R
   1. Constructing a Database in Google Sheets
      1. Comm Use Cases of `googlesheets4`
      1. Reading and Writing Data in Google Sheets with R
         1. Reading from Google Sheets
         1. Writing to Google Sheets
      1. Managing Secrets with `gargle`
      1. Google Drive and R
         1. Exploring Other Google Services
1. Qualtrics API 1. Core Functions 1. Connecting to the API 1. Example
1. Document
   1. Principles of Documentation
   1. Hierarchical Structure of Documentation
   1. Physical Documentation
   1. Field Journal
   1. Electronic Documentation
   1. Data Storage and Labeling
   1. Data Entry
   1. Sampling Strategy
   1. Marketing
   1. Administration
   1. Accounting
   1. Data Protection, Privacy, and Quality Control
   1. Data Analysis and Improvement
   1. Communication
1. Data Visualization
   1. Types of Data Visualisation
      1. Exploratory
      1. Explanatory
   1. Grammar of Graphics
   1. `ggplot()`
   1. Interactive Plots
      1. Building Plots with Plotly
      1. ECharts4r
   1. Tips
      1. `group`
1. Color Data
   1. Color and Categorical Data
      1. Emphasizing Significant Details
      1. Comparing Two ings
         1. Complementary Harmony with a Positive/Negative Connotation
         1. Near Complementary Harmony for Highlighting Two Series Where One Is the Primary Focus
      1. Color Palettes for Comparing Three Things
         1. Analogous/Triadic Harmony for Highlighting Three Series
         1. Highlighting One Series Against Two Related Series
      1. Color Palettes for Comparing Four Things
         1. Analogous Complementary for One Main Series and Its Three Secondary
         1. Double Complementary for Two Pairs Where One Pair Is Dominant
         1. Rectangular or Square Complementary for Four Series of Equal Emphasis
   1. Sequential and Divergent
      1. Sequential
      1. Divergent
      1. Prebuilt
1. Color Schemes
   1. Color Systems
      1. HSL
      1. HSV
      1. HCL
      1. LAB
      1. OKLAB
   1. Perceptual Uniformity
   1. Warning: Colormaps Might Increase Risk of Death!
   1. So, What Should You Use?
   1. Where Can I Find Color Waves?
1. A Graph for The Job
   1. Category Comparison
   1. Distribution
      1. Histogram
      1. Density Plot
      1. Frequency Polygon
      1. Box Plo 1. Violin Plot
      1. Bee Hive Plot
      1. Margins
      1. Rain Cloud Plot
   1. Proportions
      1. Stacked Bar Charts
      1. Pie Chart
      1. Waffle Chart
      1. Tree Maps
   1. Correlation
      1. Scatter Plot
      1. Correlograms
   1. Change over Time
      1. Line Chart
   1. Waterfall Graph
1. Make Tables
   1. `gt` Tables
      1. Installing and Loading the `gt` Package
      1. Prepare your data
   1. DT Tables
