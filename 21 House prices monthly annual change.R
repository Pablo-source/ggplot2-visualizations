# R Script: 21 House prices monthly annual change.R
# Data: ONS UK House Price Index: March 2023 

# Date: 13/06/2023
# Excel file: "Figure_2__The_average_UK_house_price_was_£285,000_in_March_2023.xls"
library(readxl)
library(here)
library(janitor)
library(dplyr)
library(ggplot2)

Excel_file <-list.files (path = "./data" ,pattern = "xlsx$")
Excel_file

Path <- here()
Path

# Section 01: Download and import House prices from ONSe website
# Data ONS can be dowloaded as .xls file

# Step 1.1 List files
# List excel files on Data sub-directory
list.files (path = "./data/03 ONS_House_prices/Ownership" ,pattern = "xls$")

# Step 1.2 List tabs Excel file to know which tab to import into R
excel_sheets("./data/03 ONS_House_prices/Ownership/Figure_2__The_average_UK_house_price_was_£285,000_in_March_2023.xls")

# There is only one tab containing all data
# [1] "amCharts"

# Step 1.3 Load Excel file with ONS Average UK house price data
# File: Figure_2__The_average_UK_house_price_was_£285,000_in_March_2023.xls

# Step 04: Import data using read_excel() file, skip rows with text information from Excel file 
# Skip first 6 lines of data from sheet 1 Excel file
House_price <- read_excel(here("data","03 ONS_House_prices","Ownership","Figure_2__The_average_UK_house_price_was_£285,000_in_March_2023.xls"), 
                          sheet = 1, skip = 6) %>% 
               clean_names()
House_price

names(House_price)


# Section 02:  Rename and re code initial variables

# Step 2.1 Rename original variables, change column names
House_priceavg <- House_price %>% 
                  select ( Date = x1, avg_house_price = uk_average_house_price)
House_priceavg 

# Step 2.2 We must change house price to be numeric !!!
House_priceavg_num <- House_priceavg %>% 
                      mutate(house_price = as.numeric(avg_house_price))
House_priceavg_num

# Step 2.3 Transform (date as <dttm> into Date as <date>format)
library(lubridate)

Hpriceavg <- House_priceavg_num  %>% 
                mutate(
                  Year = substring(Date,1,4),
                  Month = substring(Date,6,8),
                  Day = 01,
                  date = paste0(Year,"/",Month,"/",Day)) %>% 
                mutate(datef = as.Date(date, format = "%Y/%b/%d"))

Housep <- Hpriceavg %>% select(datef,house_price,Year)
Housep



# Section 03: Include calculation for yearly and monthly house price change  N and % 
# Month on month absolute change
# mutate (  mom = house_price - lag(house_price, n=1))
# Year on Year absolute change
# mutate (  yoy = house_price - lag(house_price, n=12))

Housepmom <- Housep %>%  mutate (mom = house_price - lag(house_price, n=1))
Housepmom

Housepch <- Housep %>%  mutate (
  mom = house_price - lag(house_price, n=1),
  yoy = house_price - lag(house_price, n=12)
  )
Housepch

# Year on Year and Month on month percentage change  
# c = (X2 - X1)/X1

Housepch <- Housep %>%  mutate (
  mom = house_price - lag(house_price, n=1),
  yoy = house_price - lag(house_price, n=12),
  mom_perc =( (house_price -lag(house_price, n=1))/lag(house_price, n=1)  * 100),
  yoy_perc =( (house_price -lag(house_price, n=12))/lag(house_price, n=12)  * 100),
  mon_percr = round(mom_perc, digits =1),
  yoy_percr = round(yoy_perc, digits =1)
    )
Housepch 

# Subset variable to plot monthly and yearly variation in a chart
House_plot <- Housepch %>% select(datef,house_price,Year,mom,yoy,mon_percr,yoy_percr)
House_plot