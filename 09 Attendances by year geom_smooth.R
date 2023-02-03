#09 AE Attendances_by_year_geom_smooth

library(tidyverse)

AE_att_wrap_formatted   <- Att_facet %>% 
  select(type_1_Major_att,Year,Monthf) %>% 
  ggplot(aes(x = Monthf, y = type_1_Major_att,group = Year)) +
  geom_line(color="#0072CE", size=1,  linetype=1) +
  facet_wrap(~ Year) +
  labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
       subtitle ="Type I attendances by month by year. 2011-2018",
       # Change X and Y axis labels
       x = "Period", 
       y = "Type I Attendances") +
  theme_light()  +
  
  theme(
    axis.ticks = element_blank(),
    # A value of “plot” means the titles/caption are aligned to the entire plot
    # Apply format to title plot
    plot.title.position = "plot", 
    plot.title = element_text(margin = margin (b=10), colour = "dodgerblue2", face = "bold"), # Skyblue1 colour
    # Apply format to sub-title
    plot.subtitle = element_text(
      size =8, colour = "deepskyblue2", face = "bold")
  ) 

AE_att_wrap_formatted 


ggsave("plots/15_AE_Attendances_facet_wrap.png", width = 6, height = 4) 



# We can add colour to these facet plots by metric
# Display each line on a different colour for each year
# 
AE_att_wrap_colour   <- Att_facet %>% 
  select(type_1_Major_att,Year,Monthf) %>% 
  ggplot(aes(x = Monthf, y = type_1_Major_att,group = Year,colour = Year)) +
  # Line colour defined by Metric variable
  geom_line(size=1,  linetype=1) +
  facet_wrap(~ Year) +
  labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
       subtitle ="Type I attendances by month by year. 2011-2018",
       # Change X and Y axis labels
       x = "Period", 
       y = "Type I Attendances") +
  theme_light()  +
  
  theme(
    axis.ticks = element_blank(),
    # A value of “plot” means the titles/caption are aligned to the entire plot
    # Apply format to title plot
    plot.title.position = "plot", 
    plot.title = element_text(margin = margin (b=10), colour = "dodgerblue2", face = "bold"), # Skyblue1 colour
    # Apply format to sub-title
    plot.subtitle = element_text(
      size =8, colour = "deepskyblue2", face = "bold")
  ) 

AE_att_wrap_colour 

ggsave("plots/16_AE_Attendances_facet_wrap_colour.png", width = 6, height = 4) 


# Display each line on a different colour for each year
# Add also a geom_smooth(span = 0.1,se = TRUE, size = 0.8) to the plot

AE_att_wrapy_smooth<- Att_facet %>% 
                          select(type_1_Major_att,Year,Monthf) %>% 
                          ggplot(aes(x = Monthf, y = type_1_Major_att,group = Year)) +
                          geom_line(color="#0072CE", size=1,  linetype=1) +
                          facet_wrap(~ Year) +
                          geom_smooth(se = TRUE, colour ="darkorchid1")

AE_att_wrapy_smooth  

ggsave("plots/17_AE_Attendances_facet_wrap_geom.png", width = 6, height = 4) 


AE_att_wrap_colouryear   <- Att_facet %>% 
                          select(type_1_Major_att,Year,Monthf) %>% 
                          ggplot(aes(x = Monthf, y = type_1_Major_att,group = Year,colour = Year)) +
                          # Line colour defined by Metric variable
                          geom_line(size=1,  linetype=1) +
                          facet_wrap(~ Year) +
                          # Include smooth line colour darkorchid
                          geom_smooth(se = TRUE, colour ="darkorchid1") +
                          labs(title = "A&E Attendances in England: Type 1 Departments - Major A&E",
                               subtitle ="Type I attendances by month by year. 2011-2018",
                               # Change X and Y axis labels
                               x = "Period", 
                               y = "Type I Attendances") +
                          theme_light()  +
                          
                          theme(
                            axis.ticks = element_blank(),
                            # A value of “plot” means the titles/caption are aligned to the entire plot
                            # Apply format to title plot
                            plot.title.position = "plot", 
                            plot.title = element_text(margin = margin (b=10), colour = "dodgerblue2", face = "bold"), # Skyblue1 colour
                            # Apply format to sub-title
                            plot.subtitle = element_text(
                              size =10, colour = "chartreuse4", face = "bold")
                          ) 

AE_att_wrap_colouryear 

ggsave("plots/18_AE_Attendances_facet_wrap_colour.png", width = 6, height = 4) 
