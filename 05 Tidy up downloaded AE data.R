# 05 Tidy up downloaded AE data

# 1. Load required packages
pacman::p_load(readxl,here,dplyr,janitor)

# Check existing files on data folder 

Excel_files_xls <- list.files(path = "./data", pattern = "xls$")
Excel_files_xls

Excel_files_xlsx <- list.files(path = "./data", pattern = "xlsx$")
Excel_files_xlsx

# [1] "AE_England_data.xls" "RTT_TS_data.xls"  

# 2. Import AE Excel data into R
# From file  AE_England_data.xls

# This is an .xls file extension, Excel 97-Excel 2003 Workbook 

# 2.1 Check first how many sheets the AE data has
here()

AE_tabs <- excel_sheets(here("data","AE_England_data.xls"))
AE_tabs

[1] "Activity"    "Performance" "Chart Data"  "Charts"  

# We read in data from Excel using READXL package
# From "readxl" package we use the read_excel function to read in data from Excel file

# Parameters
# sheet = number [Number of sheet to be imported]
# skiep = number [Number of rows from the top of the file to be skipped when importing data into Excel]
# range = "C10:F18" [Range of rows from a specific sheet to be Imported into R]
# na = ""   [How missing values are defined in the input file "-", "#" ]

# To obtain cleansed data from the original file formatting setup, we must skip some rows from the top of the file

# Also we make use of the clean_names() from janitor package to obtain clear variable names

# Skip certain rows of data: 
AE_data<- read_excel(
                     here("data", "CCG_1.17_I01968_D.xlsx"), 
                     sheet = 3, skip =13) %>% 
                     clean_names()
# How to select rows of data 
Tab10202in <- read_excel(here("Input_files",DataA),sheet = 1,range = "C10:F18",skip = 1,na = "")

