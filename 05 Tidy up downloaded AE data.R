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