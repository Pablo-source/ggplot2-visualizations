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
# [1] "data"

# Import data using read_excel() using use clean_names() from Janitor to tidy variable names
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

# 2. Subset initial data for each indicator

# SOURCE ONS:


# Definitions
https://www.ons.gov.uk/economy/inflationandpriceindices/articles/consumerpriceindicesabriefguide/2017

# The Consumer Prices Index including owner occupiers' housing costs (CPIH) 
# include a measure of the costs associated with owning, maintaining and living in one's own home, known as owner occupiers' housing costs (OOH), along with Council Tax
# Both of these are significant expenses for many households that are excluded from the CPI
# (CPI) The Consumer Price Index
# (CPIH) The Consumer Price Index Including owner occupier's housing costs
# (OOH) owner occupiers' housing costs


CPIH_data <- Inflation_date_format %>% select(date,cpih)
CPI_data <- Inflation_date_format %>% select(date,cpi)
OOH_data <- Inflation_date_format %>% select(date,ooh)


# Load required libraries
library(ggplot2)
library(gridExtra)


# 3. BUILD PLOTS

# 3.1 CPI plot
CPI_data <- CPI_data %>% mutate(Year = as.numeric(format(date,'%Y')))
CPI_data

# (CPI) The Consumer Price Index
CPI_yn_max <- CPI_data %>%  select(date,cpi,Year)
endv <- CPI_yn_max %>% filter(date == max(date))


CPI_chart <- CPI_data %>% 
  ggplot(aes(x = date, y = cpi, group = Year )) +
  geom_line(color="#3cd7d9",linewidth =2, linetype = 1) + 
  # End value geom_point
  geom_point(data = endv, col = 'blue') +
  # End value label (date and value)
  geom_text(data = endv, aes(label = date), hjust =2.5,vjust = -1) +
  geom_text(data = endv, aes(label = paste0("Most recent value: ",cpi), hjust = 0.7, nudge_x = 5,vjust = -1)) +
  scale_x_date(date_labels="%Y",date_breaks  ="1 year") +
  theme(
    panel.background = element_rect(fill = NA), # Remove default grey color background make it white 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "black")
  )    +
  labs(title = "CPI reach 8.7% in April 2023",
       subtitle ="The Consumer Price Index (CPI)",
       y = "Value %",
       x = "Year")
CPI_chart

# 3.2 CPIH plot
# Provide label to latest data point 


# 3.3 OOH plot
# Provide label to latest data point 