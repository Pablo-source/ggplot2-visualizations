## 22 ONS Inflation CPIH CPI.R script
# Load required packages
if(!require("pacman")) install.packages("pacman")
if(!require("here")) install.packages("here")
if(!require("janitor")) install.packages("janitor")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("gridExtra")) install.packages("gridExtra")
if(!require("lubridate")) install.packages("lubridate")

pacman::p_load(readxl,here,dplyr,janitor,tidyverse,ggplot2,gridExtra,lubridate)

# Sep 01 List files in 02 ONS_Inflation folder
# Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls

# ONS data for Inflation indicators are .xls files
ONS_Inflation_files <-list.files (path = "./data/02 ONS_Inflation" ,pattern = "xls$")
ONS_Inflation_files

# Re-create Figure 01
# Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls

# Step 02 List tabs from above Excel file to know which tab to import 
excel_sheets("./data/02 ONS_Inflation/Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls")
# [1] "data"

# Step 03 Import data using read_excel() using use clean_names() from Janitor to tidy variable names
Inflation_rates <- read_excel(here("data","02 ONS_Inflation","Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls"), sheet = 1,
                              skip = 6,
                              col_types = c("text", "numeric", "numeric", "numeric")) %>% 
                              clean_names()
Inflation_rates

names(Inflation_rates)

# 16/06/2023
# Step 04: Pivot longer the data using pivot_longer() from tidyr
library(tidyr)

Inflation_long <- Inflation_rates %>% 
                  pivot_longer(names_to = "Indicator",cols = 2:ncol(Inflation_rates)) %>% 
                  select(Date = x1,Indicator,value)
Inflation_long

# Step 05: Transform Date into a Date variable

Inflation_long <- Inflation_long %>% 
                      mutate(
                          Year = substring(Date,5,8),
                          Month = substring(Date,1,3),
                          Day = 01,
                          date = paste0(Year,"/",Month,"/",Day)) %>% 
                      mutate(datef = as.Date(date, format = "%Y/%b/%d"))
Inflation_long

# Retain just required variables

data_plot <- Inflation_long %>% select(datef,Indicator,value)
data_plot


# Step 05: Create a quick plot to check data
# Important we need to use group = Indicator to have one line per Inflation measure
Inflation_rates <- data_plot %>% ggplot(aes(x = datef, y = value, group = Indicator, color = Indicator)) + 
              geom_line(linewidth =1, linetype = 1) + theme_light()  +
             labs(title = "Annual CPIH and CPI Inflation rates continue to ease in April 2023", subtitle ="Source: ONS,consumer price indicesa brief guide")
Inflation_rates


ggsave("output_charts/36_Inflation_interest_rates_ONS_APRIL2023.png", width = 6, height = 4) 

