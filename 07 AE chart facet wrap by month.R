# 07 AE Attendances facet_wrap

# This script will provide a matrix of plots by month

library(tidyverse)
library(gridExtra)


# We can clean our workspace to keep just a set of variables
rm(list=ls()[!(ls()%in%c('AE_data_plot'))])

# Kepep just attendances from the original data set

# Looking into the previous R Script: 
# 05 Tidy up downloaded AE data.R

# 3. Subset original imported AE_data set to Keep A&E Attendances
# From file  AE_England_data.xls

# Import only "Type 1 Departments- Major A&E" A&E Attendances data into R

# AE_data_subset<- read_excel(
#  here("data", "AE_England_data.xls"), 
#  sheet = 1, skip =17) %>% 
#  clean_names() %>% 
#  select(
#    "x1",                                                                      
#    "period",                                                                  
#    "type_1_departments_major_a_e",                                            
#    "type_2_departments_single_specialty",                                     
#    "type_3_departments_other_a_e_minor_injury_unit",                          
#    "total_attendances" 
#  )
# AE_data_subset

# AE_plot_prep <- AE_data_plot %>% 
#   select(
#     period,
#    type_1_Major_att = type_1_departments_major_a_e,
#     type_2_Single_esp_att = type_2_departments_single_specialty,
#    type_3_other_att = type_3_departments_other_a_e_minor_injury_unit,
#    total_att = total_attendances
#  ) 
# AE_plot_prep

# 1. Rename data set with sensible name

AE_Attendances <- AE_data_plot

names(AE_Attendances)

# 2. Create variable to display year
library(tidyverse)


AE_Att_year <- AE_Attendances %>% 
               mutate(
                      Year = format(period, format = "%Y"),
                      Month = format(period, format = "%m"),
                      Monthl = months(as.Date(period))
                                      )
                      
AE_Att_year

## 3. Rename main variables

AE_Att_monthp <- AE_Att_year %>% 
select(
    period,
      type_1_Major_att = type_1_departments_major_a_e,
       type_2_Single_esp_att = type_2_departments_single_specialty,
      type_3_other_att = type_3_departments_other_a_e_minor_injury_unit,
      total_att = total_attendances,
    Monthl
    ) 

AE_Att_monthp

## 4. Split main data set by years
Att_Full_year <- AE_Att_monthp %>% mutate(Year = format(period, format = "%Y"))
Att_Full_year

# Check number of  rows per year
Records_year <-Att_Full_year %>% 
                      select(Year) %>% 
                      group_by(Year) %>% 
                      count()
Records_year

