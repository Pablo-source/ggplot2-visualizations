# R Script: 20 House prices annotations ONS.R

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
Hpriceavg

head(boerates_y)
tail(boerates_y)

# Subset required variables for charts (Date,bank_rate_n,Year)
House_prices_chart <- Hpriceavg %>% select(datef,house_price,Year)
House_prices_chart


# Section 03: Create plot for Monthly average house prices in England. Source ONS

# Setup initial chart to start applying some theme
# Get  Specific HEX colours colour from images: 
#   https://pinetools.com/image-color-picker
#  1. Save plot as png: BoE-Database_export.jpg
# 2. Import image using above website:
# 3. Click on different plot areas to obtain Line and Background HEX colours

# Colour palette  
# Line chart:  #B94A81"
# background: white (theme_bw())

# Minimal House prices chart 
  Housep_chart <- House_prices_chart %>% 
                  select(datef,house_price,Year) %>% 
                  ggplot(aes(x = datef, y = house_price)) +
                  geom_line(color="#B94A81",size =2, linetype = 1) + 
                  theme_bw() 
  Housep_chart
  
# Add theme options
  Housep_chart <- House_prices_chart %>% 
                    select(datef,house_price,Year) %>% 
                    ggplot(aes(x = datef, y = house_price)) +
                    geom_line(color="#B94A81",size =2, linetype = 1) + 
                    scale_y_continuous(breaks = seq(0, 300000, by = 4000)) +
                    theme_bw() 
  Housep_chart

# Add title to plot
  
  Housep_chart <- House_prices_chart %>% 
    select(datef,house_price,Year) %>% 
    ggplot(aes(x = datef, y = house_price)) +
    geom_line(color="#B94A81",size =2, linetype = 1) + 
    scale_y_continuous(breaks = seq(0, 300000, by = 4000)) +
    theme_bw() +
    
    labs(title = "ONS Average UK House prices",     # Include titles and subtitles and also X and Y Axis titles
         subtitle ="From January 2005 to March 2023",
         # Change X and Y axis labels
         x = "Average House price", y = "Period") 
Housep_chart
  

Housep_chart 

# Save output plot 
ggsave("34_ONS_Average_UK_House_prices_Jan2005_March2023.png", width = 10, height = 6) 



# Annotates UK house prices chart 
# 5. Provide label to latest data point 
# Format house price values
endv <- House_prices_chart %>% select(house_price,datef,Year) %>% filter(datef == max(datef)) %>% 
         mutate(house_price= format(round(as.numeric(house_price), 1), big.mark=","))
      
endv <- House_prices_chart %>% select(house_price,datef,Year) %>% filter(datef == max(datef))
minv <- House_prices_chart %>% select(house_price,datef,Year) %>% filter(house_price == min(house_price))
maxv <- House_prices_chart %>% select(house_price,datef,Year) %>% filter(house_price == max(house_price))

format(value, scientific=FALSE);

House_prices_chart <- House_prices_chart %>%  
                       mutate(house_pricef = format(house_price, scientific=FALSE))
House_prices_chart

Housep_chart <- House_prices_chart %>% 
  select(datef,house_price,Year) %>% 
  ggplot(aes(x = datef, y = house_price)) +
  geom_line(color="#B94A81",size =2, linetype = 1) + 
  scale_y_continuous(breaks = seq(0, 300000, by = 20000)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 300000)) +
  theme_bw() +
  
  labs(title = "ONS Average UK House prices",     # Include titles and subtitles and also X and Y Axis titles
       subtitle ="From January 2005 to March 2023",
       # Change X and Y axis labels
       x = "Period", y = "Average House price") +
  # End value label (date and value)
     geom_text(data = endv, aes(label = datef), hjust =2.8, vjust = 1.5) +
     geom_text(data = endv, aes(label = paste0("Most recent value: ",house_price), hjust = 0.7, vjust = 1.5)) +
  # Lowest value
    geom_text(data = minv, aes(label = datef), hjust = 0.6, vjust = 1.5) +
    geom_text(data = minv, aes(label = paste0("Minimum value: ",house_price), hjust = -0.3, vjust = 1.5)) 
Housep_chart

ggsave("35_ONS_Average_UK_House_prices_Jan2005_March2023_Annotated.png", width = 10, height = 6) 

