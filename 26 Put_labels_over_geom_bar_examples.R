# 26 Put_labels_over_geom_bar_examples.R

# Include labels over geom bar for each bar in a ggplot2 chart
# Reference
# https://stackoverflow.com/questions/12018499/how-to-put-labels-over-geom-bar-for-each-bar-in-r-with-ggplot2

library(tidyverse)
df <- cbind.data.frame(drug=c("D1","D2", "D3","D4","D5"),
                        dose=c(4.2,10,29.5,24,23),
                 subject = c("Sample1","Sample2","Sample1",
                 "Sample2","Sample1"))
head(df)
str(df)


#   geom_text(stat='count',aes(label = ..count..),vjust=-0.2)
# stats @count' will provide a value on top of each bar
DISP <- ggplot(df,aes(x=drug, y = dose, fill = subject)) +
          geom_bar(position = 'dodge', stat = 'identity') +
          geom_text(aes(label = dose), position = position_dodge(width = 0.9),
                    vjust = -0.30) +  # Set vjust to -0.30 to display just a small gap between chart and figure 
          ggtitle("Adding mark label to ggplot") 
 
DISP    

ggsave("39 Geom_bar_charts_labels_example.png", width = 10, height = 6) 

# This is an example with real data from 2019 population countries from WDI website
# Script to get repeated values: Year <-rep("2019", each=3)

# Getting population figures
## if (!require("WDI")) install.packages("WDI")
# library(WDI)
# WDI_population <- WDI(indicator = c("SP.POP.TOTL"), extra = TRUE)
# WDI_population


Countries <-c("Armenia","Aruba","Australia","Austria","Azerbaijan","Bahrain","Bangladesh",
              "Barbados","Belarus","Belgium","Belize","Benin","Bermuda")
length(Countries)

Year <-rep("2019", each=13)
Population <-c(2820602,106442,25334826,8879920,10024283,1494188,165516222,280180,
               9419758,11488980,389095,12290444,63911
               )
length(Population)

popcountries <- cbind.data.frame(Countries,Year,Population)
popc_sorted <- popcountries %>% 
               arrange(desc(Population))
# Create plot

COUNTRIES_chart <- ggplot(popc_sorted,aes(x=Countries, y = Population, fill = Year)) +
  geom_bar(position = 'dodge', stat = 'identity') +
  geom_text(aes(label = Population), position = position_dodge(width = 0.9),
            vjust = -0.30) +  # Set vjust to -0.30 to display just a small gap between chart and figure 
  ggtitle("Adding mark label to ggplot") 
COUNTRIES_chart  

ggsave("40 Countries_pop_labels_geom_bar.png", width = 10, height = 6) 

# 3. Display previous chart in ascending order
# https://stackoverflow.com/questions/16961921/plot-data-in-descending-order-as-appears-in-data-frame
# using the reorder() function
# We use the reorder function to 

# This is how you use this reorder() function: 
#  aes(x = reorder(Countries, -Population), y = Population)


COUNTRIES_sorted <- ggplot(popc_sorted,
                           aes(x = reorder(Countries, -Population), y = Population), fill = Year) +
  geom_bar(position = 'dodge', stat = 'identity') +
  geom_text(aes(label = Population), position = position_dodge(width = 0.9),
            vjust = -0.30) +  # Set vjust to -0.30 to display just a small gap between chart and figure 
  ggtitle("Adding mark label to geom_bar() and display results sort descending order") 
COUNTRIES_sorted

ggsave("41 Countries_pop_labels_geom_bar_sorted.png", width = 10, height = 6) 

