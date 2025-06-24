# Replicating NY plot
# Youtube video: Riffomonas Project: "Recreating a New York Times bar chqart using ggplot package"(CC332)
# https://www.youtube.com/watch?v=8_2frsX5MwM
# File: 27 replicate NYT figure using ggplot2.R

# 1. Load required libraries
library(tidyverse)
library(tibble) ## To use tibble function

flooding <- tibble(
  year = 2000:2024,
  declarations = c(2,5,4,0,1,2,2,1,3,3,9,25,
                   3,17,10,9,18,12,17,53,21,10,
                   14,42,66),
  is_2024 = year == 2024            # This will create a flag TRUE only for 2024
)

flooding


# 2. Create a bar plot 
# using geom_col() generated the bar plot

# 2.1 Basig bar plot uisng geom_col() function
Plot_01 <- flooding %>% 
  ggplot(aes(x=year, y = declarations)) +
  geom_col()
Plot_01

ggsave("01_Standard_bar_plot_geom_col.png", width = 6.38, height = 5.80)

# 2.2 Colours
# Using colour picker add in we choose these three colours:
# c("turquoise3", "deepskyblue2", "dodgerblue3")

# From youtube video
# # #BAD1D6 > Aquamarine colour

Plot_02 <- flooding %>% 
  ggplot(aes(x=year, y = declarations)) +
  geom_col(fill = "#BAD1D6")
Plot_02


ggsave("02_Aquamarine colour_plot_geom_col.png", width = 6.38, height = 5.80)

# 2.3 This plot just displays two default colour for True and False values of "is_2024" variable.
Plot_03 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col()
Plot_03
ggsave("03_True_false_colour_defined_by_is_2024_variable.png", width = 6.38, height = 5.80)


# 2.4 Start designing last year different colour for 2024
# using scale_fill_manual() 
# colours: FALSE values for "is_2024" variable: Aquamarine "#BAD1D6"
#          TRUE values for "is_2024" variable: Last year is 2024. DARK BLUE "#539CBA"
Plot_04 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA"))
Plot_04
ggsave("04_Flagged_2024_year_colour.png", width = 6.38, height = 5.80)


# 2.5 Apply specific theme to apply theme clasic theme to the plot 
# theme_classic()
Plot_05 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  theme_classic()
  
Plot_05
ggsave("05_Flagged_2024_year_colour_theme_classic.png", width = 6.38, height = 5.80)

# 2.6 Remove expansion around the whole perimeter
# Always remove this expansion for geom_col()
# coord_cartesian(expand = FALSE) +

Plot_06 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  theme_classic()

Plot_06
ggsave("06_Flagged_2024_year_colour_theme_classic_no_gap.png", width = 6.38, height = 5.80)


# 2.7 Include title and caption
# Also fit legend using element_textbox_simple() from library(ggtext)
library(ggtext)

Plot_07 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
    )

Plot_07
ggsave("07_Flagged_2024_year_colour_theme_title_caption.png", width = 6.38, height = 5.80)

# 2.8 Format title as bold

library(ggtext)

Plot_08 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
  )

Plot_08
ggsave("08_Flagged_2024_title_caption_title_bold.png", width = 6.38, height = 5.80) 

# 2.9 Create annotation bubble
# we will use {ggtext} to include new fonts
# Using break text with <br>
#   geom_richtext(geom = "textbox", label = "66 declarations<br>this year so far", 
#    x = 2022.5, y = 62,
#    hjust = 1,  
#    show.legend = FALSE)

library(ggtext)

Plot_09 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  geom_richtext(geom = "textbox", label = "66 declarations<br>this year so far", 
               x = 2022.5, y = 62,
               hjust = 1,  
               show.legend = FALSE) +# annotation bubble
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
  )

Plot_09
ggsave("09_Flagged_2024_title_bold_annotation_bubble.png", width = 6.38, height = 5.80) 

# 2.10 Modiffy initial annotation bubble created earlier
# New parameters introduced to geom_richtext() function
#  fill = NA,
# color = "black",

Plot_10 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  geom_richtext(geom = "textbox", label = "66 declarations<br>this year so far", 
                x = 2022.5, y = 62,
                hjust = 1,  
                fill = NA,
                color = "black",
                show.legend = FALSE) +# annotation bubble
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
  )

Plot_10

ggsave("10_Flagged_2024_title_bold_annotation_bubble_formatted.png", width = 6.38, height = 5.80) 

# 2.11 Adding the colouring emphasis for the 66 declarations
# Introducing HTML and CSS
# "<span style = 'color:#539CBA'>66 declarations</span> 

Plot_11 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  geom_richtext(geom = "textbox", label = "<span style='color:#539CBA'>66 declarations</span><br>this year so far", 
                x = 2022.5, y = 62,
                hjust = 1,  
                fill = NA,
                color = "black",
                show.legend = FALSE) +# annotation bubble
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
  )

Plot_11


ggsave("11_Flagged_2024_title_include_colour_to_text_bubble.png", width = 6.38, height = 5.80) 


# 2.12 Make the sentence "66 declarations" bold using markdown **
# geom_richtext(geom = "textbox", label = "<span style='color:#539CBA'>**66 declarations**</span><br>this year so far", 

Plot_12 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  geom_richtext(geom = "textbox", label = "<span style='color:#539CBA'>**66 declarations**</span><br>this year so far", 
                x = 2022.5, y = 62,
                hjust = 1,  
                fill = NA,
                color = "black",
                show.legend = FALSE) +# annotation bubble
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
  )

Plot_12


ggsave("12_Flagged_2024_title_include_colour_to_text_bubble_bold.png", width = 6.38, height = 5.80) 


# 2.13 Remove border around "66 declarations" text annotation
#  label.colour = NA,

Plot_13 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  geom_col(show.legend = FALSE) +
  geom_richtext(geom = "textbox", label = "<span style='color:#539CBA'>**66 declarations**</span><br>this year so far", 
                x = 2022.5, y = 62,
                hjust = 1,  
                fill = NA,
                color = "black",
                label.colour = NA,
                show.legend = FALSE) +# annotation bubble
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
  )

Plot_13


ggsave("13_Flagged_2024_title_include_colour_to_text_bubble_bold_no_border.png", width = 6.38, height = 5.80) 

# 2.14 Draw horizontal line from text to bar
# DRAW HORIZONTAL LINE FROM THE TEXT TO THE BAR
# using annotate() function after geom_richtext() function
# Placing annotate() BEFORE geom_col()

# Horizontal line position:
#  annotate(geom = "segment",x = 2022.5 , xend = 2023.4,y = 63, yend = 63)

Plot_14 <- flooding %>% 
  ggplot(aes(x=year, y = declarations, fill = is_2024)) +
  annotate(geom = "segment",
           x = 2022.5 , xend = 2023.4,
           y = 63, yend = 63) + # It requires an x,xend,y, yend
  
  geom_col(show.legend = FALSE) +
  geom_richtext(geom = "textbox", label = "<span style='color:#539CBA'>**66 declarations**</span><br>this year so far", 
                x = 2022.5, y = 62,
                hjust = 1,  
                fill = NA,
                color = "black",
                label.colour = NA,
                show.legend = FALSE) +# annotation bubble
 
  scale_fill_manual(breaks = c(FALSE,TRUE),
                    values = c("#BAD1D6","#539CBA")) +
  coord_cartesian(expand = FALSE) +
  labs(title = "A surge in U.S. flood disasters",
       caption = "Note: The 2024 total reflects declarations os of Oct. 22, 2024 * Source: Federal Emergency Management Agency * By The New York Times") +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold"),
    plot.caption = element_textbox_simple(), # Wrap legend text
    plot.caption.position = "plot", # Caption and title left aligned
    plot.title.position = "plot"
  )

Plot_14


ggsave("14_Flagged_2024_colour_to_text_bubble_bold_no_border_LINE_TO_BAR.png", width = 6.38, height = 5.80) 


# 2.15 MODIFY AXIS TICKS (WIP)












