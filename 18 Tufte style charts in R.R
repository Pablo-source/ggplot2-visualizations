# R Script: 16 BoE Interest rates from chart.R  
# Date: 01/05/2023
# Excel file: "BoE-Database_export.xlsx"
pacman::p_load(readxl,here,dplyr,janitor,tidyverse)

Excel_file <-list.files (path = "./data" ,pattern = "xlsx$")
Excel_file

Path <- here()
Path

# List excel files on Data sub-directory
# Data from BoE can be dowloaded as .xls file
# Download data file: 

# Section 01: Dowload data from BoE Website

# Download it from the  "Official Bank Rate" chart on BoE website: 
# https://www.bankofengland.co.uk/monetary-policy/the-interest-rate-bank-rate
# Download icon on the chart > Save as >XLSX

# Saved this file locally as baserate_29APR2023.xls
# You can also download it as baserate.xls from the above BoE website

# Save it as baserate_29APR2023.xls
# Step 01
list.files (path = "./data" ,pattern = "xlsx$")
# [1] "01 baserate CLEAN.xls"  "baserate_29APR2023.xls"

# Step 02 List tabs from above Excel file to know which tab to import
excel_sheets("./data/BoE-Database_export.xlsx")

# There is only one tab containing all data
# [1] "amCharts"

# Step 01 Load Excel file with BoE interest rates
# This data mimics the charts on their website, the plot starts on 2008-05-01
boerates <- read_excel(here("data", "BoE-Database_export.xlsx"), sheet = 1) %>% 
  clean_names()
boerates

# IMPORTANT< we must change bank_rate to be numeric !!!

boerates_num <- boerates %>% 
                mutate(bank_rate_n = as.numeric(bank_rate))

# Step 04 Read in data from Row 7 onwards
# Transform (date as <dttm> into Date as <date>format)

library(lubridate)

boerates_y <- boerates_num  %>% 
              mutate(Date = as.Date(date,"%d%b%Y"),
                     Year = as.numeric(format(Date,'%Y'))) 
boerates_y
head(boerates_y)
tail(boerates_y)

# Subset required variables for charts (Date,bank_rate_n,Year)
boerates_yn <- boerates_y %>% select(Date,bank_rate_n,Year)



# Section 02: Create plot

# Setup initial chart to start applying some theme
# Get  Specific HEX colours colour from images: 
#   https://pinetools.com/image-color-picker
#  1. Save plot as png: BoE-Database_export.jpg
# 2. Import image using above website:
# 3. Click on different plot areas to obtain Line and Background HEX colours

# Colours for: 
# Line chart:  #3cd7d9
# Background:  #12273f

Rates_chart <- boerates_yn %>% 
               select(Date,bank_rate_n,Year) %>% 
               ggplot(aes(x = Date, y = bank_rate_n, group = Year )) +
               geom_line(color="#3cd7d9",size =2, linetype = 1) + 
  theme_bw() +
  # Add specific background colour extracted from chart
  theme(  panel.background = element_rect(fill = '#12273f')) +
  # Supress vertidal gridlines
  theme(panel.grid.major.x = element_blank()) +

# Include titles and subtitles and also X and Y Axis titles
  labs(title = "Bank of England Official Bank Rate",
       subtitle ="From 1st May 2018 to 27th April 2023",
       # Change X and Y axis labels
       x = "Bank Rate", 
       y = "Period") 

Rates_chart 

# Section 03: Add reference lines 
# https://r-graph-gallery.com/233-add-annotations-on-ggplot2-chart.html?utm_content=cmp-true
# Add ablines with geom_hline() and geom_vline()
# An abline is a line that goes from one side to the other of the chart, 
# either in horizontal or vertical directions
#  # horizontal
# geom_hline(yintercept=25, color="orange", size=1) + 
# vertical
# geom_vline(xintercept=3, color="orange", size=1)

# In this instance I want to add three vertical lines to annotate the three
# national COVID19 lockdowns 

# First lockdown: On 23 March 2020, he first national lockdownw was announced in the UK
# Second lockdown: A second national lockdown began on 5 November 2020 in response to rising cases in the UK
# Third Lockdown: On Monday 4 January 2021 at 8pm, the Prime Minister announced the third national lockdown

Rates_chart_01 <- boerates_y %>% 
  select(Date,bank_rate,Year) %>% 
  ggplot(aes(x = Date, y = bank_rate, group = Year )) +
  geom_line(color="#3cd7d9",size =1, linetype = 1) + 
  scale_x_date(date_labels="%Y",date_breaks  ="1 year") +
  theme_bw() +
  # Add specific background colour extracted from chart
  theme(  panel.background = element_rect(fill = '#12273f')) +
  # Supress vertidal gridlines
  theme(panel.grid.major.x = element_blank()) +
  
  # Include titles and subtitles and also X and Y Axis titles
  labs(title = "Bank of England Official Bank Rate",
       subtitle ="From 1st May 2018 to 27th April 2023",
       # Change X and Y axis labels
       x = "Period", 
       y = "Bank Rate") +
  
  # Add reference lines
  # First lockdown: On 23 March 2020
  geom_vline(xintercept = as.numeric(as.Date("2020-03-23")),color="#adaade",linetype=4) +
# Second lockdown: On 23 March 2020
geom_vline(xintercept = as.numeric(as.Date("2020-11-05")),color="#adaade",linetype=4) +
# Third lockdown: On 23 March 2020
geom_vline(xintercept = as.numeric(as.Date("2021-01-04")),color="#adaade",linetype=4) +
# Add annotations to the chart 
  annotate(geom = "text", x = as.Date("2019-05-01"),
           y = 12.5, label = "First Lockdown \n 23-03-2020",color="#CCFFE5",size =3) +
  annotate(geom = "text", x = as.Date("2021-10-25"),
           y = 12.5, label = "Third Lockdown \n 04-01-2021",color="#CCFFE5",size =3)

Rates_chart_01

# Save output plot 
ggsave("01 Bank of England Bank Rates and covid lockdowns.png", width = 10, height = 6) 

# Create NEW CHART IMPROVING VISUALS 

Rates_data<- boerates_y %>% select(Date,bank_rate,Year) 
Rates_data



# PLOT 02 - Improve  initial chart applying Tufte design principles 

# New elements added to the theme() function
#   1. Remove default chart area grey color background, make it white instead
#       panel.background = element_rect(fill = NA), 
#   2. Remove X axis grid lines, x axis lines provide sufficient guideline to identify (bank interest rate) value 
#         panel.grid.major.x = element_blank(),
#         panel.grid.minor.x = element_blank(), 
#   3. Keep just major Y axis grid lines, use black colour to match axis and title font colour
#         panel.grid.major.y = element_line(colour = "black")

# 4. Added custom Title to x and Y axis using labs() function
# labs(title = "BoE Interest rates reach 4.5% in May 2023",
#     subtitle ="Eleventh interest rate increase since Jan 2022",
#     y = "Interest rate %",
#     x = "Year") 

# 5. Provide label to latest data point 
boerates_yn_max <- boerates_yn %>%  select(Date,bank_rate_n,Year)
endv <- boerates_yn_max %>% filter(Date == max(Date))

# Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
# ℹ Please use `linewidth` instead.
# Ensure we have now bank rate defined as NUMERIC !!!
str(boerates_yn)

Rates_chart_02 <- boerates_yn %>% 
  select(Date,bank_rate_n,Year) %>% 
  ggplot(aes(x = Date, y = bank_rate_n, group = Year )) +
  geom_line(color="#3cd7d9",linewidth =2, linetype = 1) + 
  # End value geom_point
  geom_point(data = endv, col = 'blue') +
  # End value label (date and value)
  geom_text(data = endv, aes(label = Date), hjust =2.5, nudge_x = 5,vjust = -1) +
  geom_text(data = endv, aes(label = paste0("Most recent value: ",bank_rate_n), hjust = 0.7, nudge_x = 5,vjust = -1)) +
  scale_x_date(date_labels="%Y",date_breaks  ="1 year") +
  theme(
    panel.background = element_rect(fill = NA), # Remove default grey color background make it white 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "black")
        )    +
  labs(title = "BoE Interest rates reach 4.5% in May 2023",
       subtitle ="Eleventh interest rate increase since Jan 2022",
       y = "Interest rate %",
       x = "Year")
Rates_chart_02