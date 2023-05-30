# 19 GridExtra 

# Example on how to use GridExtra using Inflation data 
pacman::p_load(readxl,here,dplyr,janitor,tidyverse)

# Load inflation data from ONS website
library(gridExtra)

# 1. Import data from ONS website
# https://www.ons.gov.uk/economy/inflationandpriceindices/bulletins/consumerpriceinflation/latest

# Data we will use to two draw two plots: 

# Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls
# Figure_6__Housing_and_household_services_made_the_largest_upward_contribution_to_the_change_in_the_annual_CPIH_inflation_rate.xls
# Figure_8__The_annual_inflation_rate_eased_in_the_European_Union,_Germany_and_the_United_States_in_April_2023.xls

# ONS data for Inflation indicators are .xls files

ONS_Inflation_files <-list.files (path = "./data" ,pattern = "xls$")
ONS_Inflation_files

# Re-create Figure 01
# Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls

 
# Step 02 List tabs from above Excel file to know which tab to import 
excel_sheets("./data/Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls")
[1] "data"

Inflation_rates <- read_excel(here("data", "Figure_1__Annual_CPIH_and_CPI_inflation_rates_continue_to_ease_in_April_2023.xls"), sheet = 1,
                              skip = 6,
                              col_types = c("text", "numeric", "numeric", "numeric")) %>% 
                   clean_names()
Inflation_rates
names(Inflation_rates)

# Format first variable to obtain a date variable
# Using this script to format APR 2013 dates format
# https://github.com/Pablo-source/R-Automation-Functions/blob/main/26%20Format_YYYY_MMM%20to%20r%20dates.R

# We create new variable datef with the right date format

Inflation_formatted <- Inflation_rates %>% 
                      select(Date = x1,cpih,cpi,ooh) %>% 
                      mutate(
                        Year = substring(Date,5,9),
                        Month = substring(Date,1,3),
                        Day = 01,
                        date = paste0(Year,"/",Month,"/",Day)
                      ) %>% 
                      mutate(datef = as.Date(date, format = "%Y/%b/%d"))
Inflation_formatted

# Re-arrange variaboles

Inflation_date_format <- Inflation_formatted %>% 
                        select(date = datef, cpih, cpi, ooh)
Inflation_date_format