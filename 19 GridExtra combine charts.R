# 19 GridExtra 

# Example on how to use GridExtra using Inflation data 
pacman::p_load(readxl,here,dplyr,janitor,tidyverse)

# Load required libraries 
library(ggplot2)
library(gridExtra)
library(lubridate)

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
# https://www.ons.gov.uk/economy/inflationandpriceindices/articles/consumerpriceindicesabriefguide/2017

# The Consumer Prices Index including owner occupiers' housing costs (CPIH) 
# include a measure of the costs associated with owning, maintaining and living in one's own home, known as owner occupiers' housing costs (OOH), along with Council Tax
# Both of these are significant expenses for many households that are excluded from the CPI
# (CPI) The Consumer Price Index
# (CPIH) The Consumer Price Index Including owner occupier's housing costs
# (OOH) owner occupiers' housing costs

CPI_data <- Inflation_date_format %>% select(date,cpi)
CPIH_data <- Inflation_date_format %>% select(date,cpih)
OOH_data <- Inflation_date_format %>% select(date,ooh)

# 3. BUILD PLOTS
# 3.1 Create year variable for each series
CPI_data <- CPI_data %>% mutate(Year = as.numeric(format(date,'%Y')))
CPI_data

CPIH_data <- CPIH_data %>% mutate(Year = as.numeric(format(date,'%Y')))
CPIH_data

OOH_data <- OOH_data %>% mutate(Year = as.numeric(format(date,'%Y')))
OOH_data

# Quick visual data checks for each series
CPI_chart <- CPI_data %>% ggplot(aes(x = date, y = cpi)) + geom_line(color="#3cd7d9",linewidth =1, linetype = 1) + theme_light()  +
  labs(title = "(CPI) The Consumer Price Index. April 2023", subtitle ="Source: ONS,consumer price indicesa brief guide")
CPI_chart

ggsave("plots/26_CPI_EDA_chart.png", width = 6, height = 4) 

CPIH_chart <- CPIH_data %>% ggplot(aes(x = date, y = cpih)) + geom_line(color="#F08080",linewidth =1, linetype = 1) + theme_light()  +
  labs(title = "(CPIH) The Consumer Price Index Including owner occupier's housing costs. April 2023", subtitle ="Source: ONS,consumer price indicesa brief guide")
CPIH_chart

ggsave("plots/27_CPIH_EDA_chart.png", width = 6, height = 4) 

OOH_chart <- OOH_data %>% ggplot(aes(x = date, y = ooh)) + geom_line(color="#008000",linewidth =1, linetype = 1) + theme_light()  +
  labs(title = "(OOH) owner occupiers' housing costs. April 2023", subtitle ="Source: ONS,consumer price indicesa brief guide")
OOH_chart

ggsave("plots/28_OOH_EDA_chart.png", width = 6, height = 4) 

# 3.1 CPI plot
CPI_data <- CPI_data %>% mutate(Year = as.numeric(format(date,'%Y')))
CPI_data


# (CPI) The Consumer Price Index    
CPI_yn_max <- CPI_data %>%  select(date,cpi,Year)
endv <- CPI_yn_max %>% filter(date == max(date))


CPI_chart <- CPI_data %>%  
  ggplot(aes(x = date, y = cpi)) +
  geom_line(color="#3cd7d9",linewidth =1, linetype = 1) + 
  # End value geom_point
  geom_point(data = endv, col = 'blue') +
  # End value label (date and value)
  geom_text(data = endv, aes(label = date), hjust =2.0,vjust = 2.9) +
  geom_text(data = endv, aes(label = paste0("Most recent value: ",cpi), hjust = 1.5,vjust = 1.5)) +
  scale_x_date(date_labels="%Y",date_breaks  ="1 year") +
  theme(
    panel.background = element_rect(fill = NA), # Remove default grey color background make it white 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "black")
  )    +
  labs(title = "CPI reach 8.7% in April 2023",
       subtitle ="The Consumer Price Index (CPI).source: ONS,consumer price indices a brief guide",
       y = "Value %",
       x = "Year")
CPI_chart

ggsave("plots/29_CPI_formatted_April_2023.png", width = 6, height = 4) 


# 3.2 CPIH plot
# Provide label to latest data point 
# Included several theme options 
CPIH_yn_max <- CPIH_data %>%  select(date,cpih,Year)
endv <- CPIH_yn_max %>% filter(date == max(date))

CPIH_chart <- CPIH_data %>% 
  ggplot(aes(x = date, y = cpih)) + 
  geom_line(color="#F08080",linewidth =1, linetype = 1) + theme_light()  +
  geom_point(data = endv, col = 'blue') +
  geom_text(data = endv, aes(label = date), hjust =2.3,vjust = 4.5) +
  geom_text(data = endv, aes(label = paste0("Most recent value: ",cpih), hjust = 1.7,vjust = 3.2)) +
  scale_x_date(date_labels="%Y",date_breaks  ="1 year") +
  theme(
    panel.background = element_rect(fill = NA), # Remove default grey color background make it white 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "black")
  )   +
  labs(title = "CPIH reach 7.8% in April 2023",
       subtitle ="(CPIH) The Consumer Price Index Including owner occupier's housing costs.source: ONS",
       y = "Value %",
       x = "Year")

CPIH_chart
ggsave("plots/30_CPIH_formatted_April_2023.png", width = 6, height = 4) 


# 3.3 OOH plot
# Provide label to latest data point
OOH_yn_max <- OOH_data %>%  select(date,ooh,Year)
endv <- OOH_yn_max %>% filter(date == max(date))

OOH_chart <- OOH_data %>% 
  ggplot(aes(x = date, y = ooh)) + 
  geom_line(color="#008000",linewidth =1, linetype = 1) + theme_light()  +
  geom_point(data = endv, col = 'blue') +
  geom_text(data = endv, aes(label = date), hjust =1.9,vjust = 2.70) +
  geom_text(data = endv, aes(label = paste0("Most recent value: ",ooh), hjust = 1.55,vjust = 1.5)) +
  scale_x_date(date_labels="%Y",date_breaks  ="1 year") +
  theme(
    panel.background = element_rect(fill = NA), # Remove default grey color background make it white 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "black")
  )   +
  labs(title = "OOH reach 4.0% in April 2023",
       subtitle ="The Consumer Price Index (CPI).source: ONS,consumer price indices a brief guide",
       y = "Value %",
       x = "Year")

OOH_chart
ggsave("plots/31_OOH_formatted_April_2023.png", width = 6, height = 4) 

## 4. COMBINE PLOTS USING GRIDEXTRA
# CPI_chart
# CPIH_chart
# OOH_chart

grid.arrange(CPI_chart, CPIH_chart, OOH_chart, ncol=3)
ggsave("plots/32_Inflation_grid_April_2023.png", width = 6, height = 4) 


# Combining four charts into a single image
boerates <- read_excel(here("data", "BoE-Database_export.xlsx"), sheet = 1) %>% clean_names()
boerates_num <- boerates %>% mutate(bank_rate_n = as.numeric(bank_rate))
boerates_y <- boerates_num  %>%  mutate(Date = as.Date(date,"%d%b%Y"),Year = as.numeric(format(Date,'%Y'))) 
# Subset required variables for charts (Date,bank_rate_n,Year)
boerates_yn <- boerates_y %>% select(Date,bank_rate_n,Year)

# 5. Provide label to latest data point  
boerates_yn_max <- boerates_yn %>%  select(Date,bank_rate_n,Year)
endv <- boerates_yn_max %>% filter(Date == max(Date))

# Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
# ℹ Please use `linewidth` instead.
# Ensure we have now bank rate defined as NUMERIC !!! 
str(boerates_yn)

BoErates <- boerates_yn %>% 
  select(Date,bank_rate_n,Year) %>% 
  ggplot(aes(x = Date, y = bank_rate_n, group = Year )) +
  geom_line(color="#3cd7d9",linewidth =2, linetype = 1) + 
  # End value geom_point
  geom_point(data = endv, col = 'blue') +
  # End value label (date and value)
  geom_text(data = endv, aes(label = Date), hjust =1.9, nudge_x = 5,vjust = 1.0) +
  geom_text(data = endv, aes(label = paste0("Most recent value: ",bank_rate_n), hjust = 1.5, nudge_x = 5,vjust = -1)) +
  scale_x_date(date_labels="%Y",date_breaks  ="1 year") +
  theme(
    panel.background = element_rect(fill = NA), # Remove default grey color background make it white 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "black")
  )    +
  labs(title = "BoE Interest rates reach 4.5% in May 2023",
       subtitle ="Twelfth interest rate increase since Dec 2021",
       y = "Interest rate %",
       x = "Year")
BoErates

# We can combine the three inflation rate measures plus BoE intertest rate plot into a single image
grid.arrange(CPI_chart, CPIH_chart, OOH_chart,BoErates, ncol=2)
ggsave("plots/34_Inflation_interest_rates.png", width = 6, height = 4) 

