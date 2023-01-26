# 03 Import Excel data into R

# Load required packages at once (readxl,here,dplyr,janitor)
pacman::p_load(readxl,here,dplyr,janitor)

Excel_file <-list.files (path = "./data" ,pattern = "xlsx$")
Excel_file

# [1] "RTT_TS_data.xlsx"
Excel_tabs <- excel_sheets("./data/RTT_TS_data.xlsx")
Excel_tabs

# [1] "Full Time Series"

# Import data using readxl and janitor
# read_excel() parameters
# sheet = n . Define on which sheet to start the reading of data
