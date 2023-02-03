#09 AE Attendances_by_year_geom_smooth

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