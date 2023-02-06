# 10 Density plot for A&E Attendanes
library(ggside)
library(tidyverse)
library(tidyquant)


# Using the AEBYEAR_sel data set for this Density plot

AEBYEAR_sel

names(AEBYEAR_sel)
names(Att_facet)

head(Att_facet)

# 1 DENSITY PLOT FOR MAJOR_ATTENDANCES AND SINGLE ESP ATT SCATTERPLOT
MAJORYEAR <- AEBYEAR_sel %>% select(period,Major_att)
MAJORYEAR

# 2 Create variable for Moths, we are going to display Attendances by Month for 2011

Att_months  <- AEBYEAR_sel %>% select(period,Major_att) %>% 
  mutate(
    Year = format(period, format = "%Y"),
    Month = format(period, format = "%b")
  )
Att_months

# Att_2011 year

Att_months_2011 <- Att_months %>% 
                   filter(Year == '2011')
Att_months_2011
# Plot structure
# X axis (period)
# Y axis  (value)
# color (metric) 

# 2. Place both metrics Major_att, Single_esp_att on the same columns (pivot long data set)
Dendata_long<- Att_months_2011 %>% 
   pivot_longer(names_to = "Metrics",
             cols = 2:ncol(MAJORYEAR))
Dendata_long

# 2 Start building the Density plot
# 2.1 Initial GGPLOT displaying metric by date
scatter_plot <- Dendata_long %>% 
              ggplot(aes(period, value, color = Metrics)) +
              ggtitle("AE Major attendances. 2011-2019") +
              geom_point(size = 2, alpha = 0.3)   
scatter_plot

# 2.2 start building the density plot
library(tidyquant)

density_plot <- Dendata_long %>% 
  ggplot(aes(period, value, color = Metrics)) +
  ggtitle("AE Attendances by Type.2011-2019") +
  geom_point(size = 2, alpha = 0.3)   +

# Adding X axis density plot
geom_xsidedensity(
  aes(y = after_stat(density),fill = Metrics),
  alpha = 0.5, size = 1,
  position = "stack")  +

density_plot
  