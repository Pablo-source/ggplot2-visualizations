# 04 Import A&E Excel data into R from URL

#Searching for the href HTML tag we can find the corresponding .xls file to import it into R
#<p><a href="https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/11/Timeseries-monthly-Unadjusted-9kidr.xls">Unadjusted: Monthly A&amp;E Time series April 2019 (XLS, 364K)</a><br />
  
  

AE_data <- function() {
  
  if(!dir.exists("data")){dir.create("data")}
  
  # England-level time series
  # Download Excel file to a Project sub-folder called "data"
  # Created previously using an adhoc project structure function
  
  xlsFile = "RTT_TS_data.xlsx"
  
  download.file(
    url = 'https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2023/01/RTT-Overview-Timeseries-Including-Estimates-for-Missing-Trusts-Nov22-XLS-98K-63230.xlsx',
    destfile = here("data",xlsFile),
    mode ="wb"
  )
  
}
# Download RTT data function (no arguments)
RTT_TS_data()