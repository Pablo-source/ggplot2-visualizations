# 01 BoEInterest rate data wrangling
# R Script: 01 BoE Interest rates.R
# Excel file: "baserate_29APR2023.xls"
library(readxl)
library(here)
library(dplyr)
library(janitor)

Path <- here()
Path

# List excel files on Data sub-directory
# Data from BoE can be dowloaded as .xls file
# Download data file: 


# Download it from website
# https://www.bankofengland.co.uk/monetary-policy/the-interest-rate-bank-rate
# <a class="btn btn-pubs btn-has-img btn-lg" href="/-/media/boe/files/monetary-policy/baserate.xls">  <img src="/assets/img/icon-xls.svg" alt="" width="40" height="44">Official Bank Rate history data from 1694</a>

# Saved this file locally as baserate_29APR2023.xls
# You can also download it as baserate.xls from the above BoE website

# Save it as baserate_29APR2023.xls
# Step 01
list.files (path = "./data" ,pattern = "xls$")
# [1] "01 baserate CLEAN.xls"  "baserate_29APR2023.xls"

# Step 02 List tabs from above Excel file to know which tab to import
excel_sheets("./data/baserate_29APR2023.xls")

# excel_sheets("./data/baserate.xls")

# We want to import the storical data since 1694 tab
# [1] "FAME Persistence"      "BOEBASERATE"           "Chart"                 "HISTORICAL SINCE 1694" "Raw Data" 

# Step 03  "Download tab "HISTORICAL SINCE 1694" tab information
boerates <- read_excel(here("data", "baserate_29APR2023.xls"), sheet = 4) %>% 
  clean_names()
boerates

# boerates <- read_excel(here("data", "baserate_29APR2023.xls"), sheet = 4) %>% 
#   clean_names()

# "HISTORICAL SINCE 1694"

# Step 04 Read in data from Row 7 onwards
# So we need to skip the first 6 rows of data
boerates <- read_excel(here("data", "baserate_29APR2023.xls"), sheet = 4,
                       skip = 6, na ="NA") %>% 
                       clean_names()
boerates

# names(boerates)
# [1] "bank_rate" "x2"        "x3"        "x4"        "x5"        "x6" 

# Step 05: Rename column names
boe_rate <- boerates %>% 
  select(Year = bank_rate,Day = x2,Month = x3,rate = x4) 
boe_rate

# Step 06: Filter out data where day is not available. Prior to 1884 day is not available
#  filter(!is.na(col1))
# Filter out na values for Day column 

boe_rates <- boe_rate %>% filter(!is.na(Day))
boe_rates      

# Step 07: Populate NA values in Year column  with previous filled in Year value on that same colum
#          As we have several rows per year when the interest rate changed 
# Fill in missing values with previous value

library(tidyr)

# Value (Year is recorded only when it changes)
# fill() defaults to replacing missing data from top to bottom (we apply it on Year variable)

boe_rates_year <- boerates %>% 
                  select(Year = bank_rate,Day = x2,Month = x3,rate = x4) %>% 
                  filter(!is.na(Day)) %>% 
                  fill(Year)
boe_rates_year

# Step 08: Create new variable using mutate in R date format using as.Date
# Dates in R format 
boe_rates_datef <- boerates %>% 
  select(Year = bank_rate,Day = x2,Month = x3,rate = x4) %>% 
  filter(!is.na(Day)) %>% 
  fill(Year) %>% 
  mutate(date_nf = paste0(Year,"/",Month,"/",Day)) %>% 
  mutate(date_f = as.Date(date_nf, format = "%Y/%b/%d"))
boe_rates_datef

rm(boe_rate,boe_rates,boe_rates_year)

# Step 09: Re-arrange them for plots
boe_rates <- boe_rates_datef %>%  select(date_f,rate)

boe_rates <- boe_rates_datef %>%  select(date_f,rate) %>%  mutate(source = "BoE_official_bank_rate")
boe_rates

head(boe_rates)
tail(boe_rates)
