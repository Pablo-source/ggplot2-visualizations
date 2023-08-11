# R Script: 16 BoE Interest rates from chart.R   
# Date: 01/05/2023
# Excel file: "BoE-Database_export.xlsx"
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
Data <- list.files (path = "./data/03 ONS_House_prices/Ownership" ,pattern = ("xls$"),
            ignore.case = TRUE)
Average_house_price <- Data[1]



# Step 1.2 List tabs Excel file to know which tab to import into R
excel_sheets("./data/03 ONS_House_prices/Ownership/Figure_2__The_average_UK_house_price_was_£286,000_in_May_2023_(provisional_estimate).xls")

# There is only one tab containing all data
# [1] "amCharts"

# Step 1.3 Load Excel file with ONS Average UK house price data
# File: Figure_2__The_average_UK_house_price_was_£285,000_in_March_2023.xls

# Step 04: Import data using read_excel() file, skip rows with text information from Excel file 
# Skip first 6 lines of data from sheet 1 Excel file
House_price <- read_excel(here("data","03 ONS_House_prices","Ownership",
                               "Figure_2__The_average_UK_house_price_was_£286,000_in_May_2023_(provisional_estimate).xls"), 
                          sheet = 1, skip = 6) %>% 
               clean_names()
House_price

names(House_price)

# Section 02:  Rename and re code initial variables
# Step 2.1 Rename original variables, change column names
# Step 2.2 We must change house price to be numeric !!!
House_priceavg <- House_price %>% 
                  select ( Date = x1, avg_house_price = uk_average_house_price) %>% 
                  mutate(house_price = as.numeric(avg_house_price))
House_priceavg

# Step 2.3 Transform (date as <dttm> into Date as <date>format)
library(lubridate)

Hpriceavg <- House_priceavg  %>% 
                mutate(
                  Year = substring(Date,1,4),
                  Month = substring(Date,6,8),
                  Day = 01,
                  date = paste0(Year,"/",Month,"/",Day)) %>% 
                mutate(datef = as.Date(date, format = "%Y/%b/%d")) %>% 
                select(datef,house_price,Year)
Hpriceavg

# Section 03: Create plot for Monthly average house prices in England. Source ONS

# Annotates UK house prices chart 
# 5. Provide label to latest data point 
# Format house price values
House_prices_chart <- Hpriceavg

endv <- House_prices_chart %>% select(house_price,datef,Year) %>% filter(datef == max(datef))
minv <- House_prices_chart %>% select(house_price,datef,Year) %>% filter(house_price == min(house_price))
maxv <- House_prices_chart %>% select(house_price,datef,Year) %>% filter(house_price == max(house_price))


Housep_chart <- House_prices_chart %>% 
  select(datef,house_price,Year) %>% 
  ggplot(aes(x = datef, y = house_price)) +
  geom_line(color="#B94A81",size =1, linetype = 1) + 
  
  scale_y_continuous(breaks = seq(0, 300000, by = 8000)) +
  theme_bw() +
  
  labs(title = "ONS Average UK House prices",     # Include titles and subtitles and also X and Y Axis titles
       subtitle ="From January 2005 to May 2023",
       # Change X and Y axis labels
       x = "Average House price", y = "Period") +
  # End value label (date and value)
  geom_text(data = endv, aes(label = datef), hjust =2.8, vjust = 2.5) +
  geom_text(data = endv, aes(label = paste0("Latest value: ",house_price), hjust = 0.95, vjust = 2.4)) +
  # Lowest value
  geom_text(data = minv, aes(label = datef), hjust = 0.6, vjust = 1.5) +
  geom_text(data = minv, aes(label = paste0("Min value: ",house_price), hjust = -0.3, vjust = 1.5)) +
  # Highest value 
  geom_text(data = maxv, aes(label = datef), hjust = 2.4, vjust = -0.5) +
  geom_text(data = maxv, aes(label = paste0("Max value: ",house_price), hjust = 0.7, vjust = -0.5)) 
  
Housep_chart


ggsave("plots/03_ONS_Average_UK_House_prices_Jan2005_May2023_Annotated.png", width = 10, height = 6) 

