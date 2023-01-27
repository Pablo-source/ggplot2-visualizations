# 04 Import A&E Excel data into R from URL 

#Searching for the href HTML tag we can find the corresponding .xls file to import it into R
#<p><a href="https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/11/Timeseries-monthly-Unadjusted-9kidr.xls">Unadjusted: Monthly A&amp;E Time series April 2019 (XLS, 364K)</a><br />

pacman::p_load(readxl,here,dplyr,janitor)
  
AE_data <- function() {
  
  if(!dir.exists("data")){dir.create("data")}
  
  # England-level time series
  # Download Excel file to a Project sub-folder called "data"
  # Created previously using an adhoc project structure function
  
  xlsFile = "AE_England_data.xlsx"
  
  download.file(
    url = 'https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/11/Timeseries-monthly-Unadjusted-9kidr.xls',
    destfile = here("data",xlsFile),
    mode ="wb"
  )
  
}
# Download A&E data function (no arguments)
AE_data()