# 06 AE Attendances ggplot2 plot

# We start by Loading previous data set
# AEATT_plot 

names(AEATT_plot)

head(AEATT_plot)



# 6.1. Plot 01: A&E Attendances: Type 1 Departments - Major A&E
# Data: AEATT_plot
# Variables: period,type_1_Major_att
#type_1_Major_att = type_1_departments_major_a_e,


# type_2_Single_esp_att = type_2_departments_single_specialty,
# type_3_other_att = type_3_departments_other_a_e_minor_injury_unit,
# total_att = total_attendances


# 1. Initial plot using Type I attendances data across time
library(tidyverse)

head(AEATT_plot)
names(AEATT_plot)

#[1] "period"                "type_1_Major_att"      "type_2_Single_esp_att"
#[4] "type_3_other_att"      "total_att" 


TypeI_att_plot <- AEATT_plot %>% 
                  select(period, type_1_Major_att) %>% 
                  ggplot(aes(x = period, y = type_1_Major_att )) +
                  geom_line() +
                  labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
                       subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/")

TypeI_att_plot


# 2. Add color to line

# Interesting resource from nhs-R-community GitHub repo with 
# NHSR Color Themes

# https://github.com/nhs-r-community/NHSRtheme
# https://nhsengland.github.io/nhs-r-reporting/documentation/nhs-colours.html

# NHS Blue	#005EB8
# NHS Bright Blue	#0072CE

TypeI_att_plot <- AEATT_plot %>% 
                      select(period, type_1_Major_att) %>% 
                      ggplot(aes(x = period, y = type_1_Major_att)) +
                      geom_line(color="#0072CE", size=1,  linetype=1) +
                      labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
                      subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/")

TypeI_att_plot


