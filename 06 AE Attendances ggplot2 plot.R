# 06 AE Attendances ggplot2 plot.R

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


# We include geom_line() to display an initial plot
# geom_line()

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

# We include new parameters in geom_line() geom 
# geom_line()
# 1. Include colour geom_line(color = "#0072CE")
# 2. Include line size (1)
# 3. Include linetype (linetype="dashed", linetype="dotted", 0  is for “blank”, 1 is for “solid”, 2 is for “dashed”)
# NHS Blue	#005EB8
# NHS Bright Blue	#0072CE 
TypeI_att_plot <- AEATT_plot %>% 
                      select(period, type_1_Major_att) %>% 
                      ggplot(aes(x = period, y = type_1_Major_att)) +
                      geom_line(color="#0072CE", size=1,  linetype=1) +
                      labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
                      subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/")

TypeI_att_plot

# Save plot
ggsave("plots/A&E_Attendances_Type_1_England.png", width = 6, height = 4)

# 3. Add new geom to plot geom_point()  
# geom_point()
#   Parameters:  
#       show.legend: logical. Should this layer be included in the legends? NA, the default, includes if any aesthetics are mapped. FALSE never includes,

# Source or NHS England colors
# https://www.england.nhs.uk/nhsidentity/identity-guidelines/colours/

# I include this time two hues of NHS blues in the plot
# NHS Bright Blue #0072CE ff
# NHS Aqua Blue #00A9CE

TypeI_dot_line_plot <- AEATT_plot %>% 
                  select(period, type_1_Major_att) %>% 
                  ggplot(aes(x = period, y = type_1_Major_att)) +
                  geom_line(color="#0072CE", size=1,  linetype=1) +
                  # Included new geom
                  geom_point(fill="#00A9CE",shape=21,show.legend = FALSE) +
                  labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
                       subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/")

TypeI_dot_line_plot

ggsave("plots/A&E_Attendances_Type_1_England_line_point_geom.png", width = 6, height = 4)

# 4. Modify X and Y axis labels
Axis_labels_plot <- AEATT_plot %>% 
                          select(period, type_1_Major_att) %>% 
                          ggplot(aes(x = period, y = type_1_Major_att)) +
                          geom_line(color="#0072CE", size=1,  linetype=1) +
                          # Included new geom
                          geom_point(fill="#00A9CE",shape=21,show.legend = FALSE) +
                          labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
                               subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/",
                               # Change X and Y axis labels
                               x = "Period", 
                               y = "Type I Attendances") 
                          
Axis_labels_plot

ggsave("plots/A&E_Attendances_Type_1_England_aixs_titles.png", width = 6, height = 4)

# 5. Remove tick marks 
# theme(axis.ticks = element_blank())

Axis_ticks_removed <- AEATT_plot %>% 
  select(period, type_1_Major_att) %>% 
  ggplot(aes(x = period, y = type_1_Major_att)) +
  geom_line(color="#0072CE", size=1,  linetype=1) +
  # Included new geom
  geom_point(fill="#00A9CE",shape=21,show.legend = FALSE) +
  labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
       subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/",
       # Change X and Y axis labels
       x = "Period", 
       y = "Type I Attendances") +
  theme (axis.ticks = element_blank())

Axis_ticks_removed

ggsave("plots/A&E_Attendances_Type_1_England_Axis_ticks_removed.png", width = 6, height = 4)

# 6. Include theme 
# Arrange different plots using gridExtra
library(gridExtra)

# Theme bw
# theme_bw()
TypeI_theme_bw  <- AEATT_plot %>% 
                      select(period, type_1_Major_att) %>% 
                      ggplot(aes(x = period, y = type_1_Major_att)) +
                      geom_line(color="#0072CE", size=1,  linetype=1) +
                      # Included new geom
                      geom_point(fill="#00A9CE",shape=21,show.legend = FALSE) +
                      labs(title = "A&E Attendances \n Theme_bw",
                           subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/",
                           # Change X and Y axis labels
                           x = "Period", 
                           y = "Type I Attendances") +
                      theme (axis.ticks = element_blank()) +
                      theme_bw()

TypeI_theme_bw

# Theme light
# theme_light()

TypeI_theme_light  <- AEATT_plot %>% 
  select(period, type_1_Major_att) %>% 
  ggplot(aes(x = period, y = type_1_Major_att)) +
  geom_line(color="#0072CE", size=1,  linetype=1) +
  # Included new geom
  geom_point(fill="#00A9CE",shape=21,show.legend = FALSE) +
  labs(title = "A&E Attendances \n Theme_light",
       subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/",
       # Change X and Y axis labels
       x = "Period", 
       y = "Type I Attendances") +
  theme (axis.ticks = element_blank()) +
  theme_light()

TypeI_theme_light

# Theme classic
# theme_classic()

TypeI_theme_classic  <- AEATT_plot %>% 
  select(period, type_1_Major_att) %>% 
  ggplot(aes(x = period, y = type_1_Major_att)) +
  geom_line(color="#0072CE", size=1,  linetype=1) +
  # Included new geom
  geom_point(fill="#00A9CE",shape=21,show.legend = FALSE) +
  labs(title = "A&E Attendances \n Theme_classic",
       subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/",
       # Change X and Y axis labels
       x = "Period", 
       y = "Type I Attendances") +
  theme (axis.ticks = element_blank()) +
  theme_classic()

TypeI_theme_classic

# Theme dark (last of base themes)
# theme_dark() 

TypeI_theme_dark  <- AEATT_plot %>% 
  select(period, type_1_Major_att) %>% 
  ggplot(aes(x = period, y = type_1_Major_att)) +
  geom_line(color="#0072CE", size=1,  linetype=1) +
  # Included new geom
  geom_point(fill="#00A9CE",shape=21,show.legend = FALSE) +
  labs(title = "A&E Attendances, \n Theme_dark",
       subtitle ="Source: https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/",
       # Change X and Y axis labels
       x = "Period", 
       y = "Type I Attendances") +
  theme (axis.ticks = element_blank()) +
  theme_dark()

TypeI_theme_dark

# Arrange all plots into a single image using grid-arrange()
GRID_PLOT <- grid.arrange(TypeI_theme_bw,TypeI_theme_light,
             TypeI_theme_classic,TypeI_theme_dark,
             ncol=4)

ggsave("plots/A&E_Attendances_Grid_Arrange_themes_gallery_02.png", width = 1311, height = 4)
