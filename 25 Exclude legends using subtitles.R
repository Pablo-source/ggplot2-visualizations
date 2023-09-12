# Legend as colors in titles

# R Script: 25 Exclude legends using subtitles.R

# install.packages("hrbrthemes")
library(tidyverse)
library(hrbrthemes)
library(ggtext)

hrbrthemes::import_roboto_condensed()

# This two lines below will load two data sets
# penguins
# penguins_raw
library(palmerpenguins)
data(package = 'palmerpenguins')

data <- data(package = 'palmerpenguins')
head(penguins)
head(penguins_raw)

# penguins_raw,contains all the variables and original names as downloaded
Data <- penguins

# Using this data set
names(Data)

# Choose variables
# Body Mass (g)
# Species

Weight_data <- Data %>%  select(species, flipper_length_mm,body_mass_g)
Weight_data

# 1 Create standard scatter plot
Scatterplot_init<-  ggplot(Data, aes(x =flipper_length_mm, y = body_mass_g, color = species )) +
  geom_point(size = 2) +
  labs(title="Palmer Penguins",
       subtitle="Flipper Length vs Bill Length",
       caption="cmdlinetips.com",
       x = "Flipper Length (mm)",y = "Body Mass (g)") +
  theme(title = element_text(size=16, 
                           color="purple", 
                            face="bold")) +
  theme_ipsum() 
  
Scatterplot_init

ggsave("plots/01 Flipper length by body mass ipsus theme.png", width = 6, height = 4)


# Following post to add colour to the title
install.packages("ggtext")
library(ggtext)

# 1.  We need ggtext library to display HTML tabs and format them using theme() 
Scatterplot_new<-  ggplot(Data, aes(x =flipper_length_mm, y = body_mass_g, color = species )) +
  geom_point(size = 2) +
  labs(
       title="Palmer Penguins",
       subtitle = "Penguin weights (in g) for the Species <span>Aldeie</span>,
       <span>Chintrap</span>, <span>Gentoo</span>") +
  theme(
    plot.subtitle = ggtext::element_markdown(size = 10, lineheight = 1.3)
  )

Scatterplot_new

ggsave("plots/02 Flipper length by body mass adding html.png", width = 6, height = 4)

# 2. Then we need to add colour instructions
# This will display colours in the subtitle

Scatterplot_new<-  ggplot(Data, aes(x =flipper_length_mm, y = body_mass_g, color = species )) +
  geom_point(size = 2) +
  labs(
    title="Palmer Penguins",
    subtitle = 'Penguin weights (in g) for the Species <span style = "color:#E69F00">Aldeie </span>, 
                                                        <span style = "color:#0072B2">Chinstrap </span> and
                                                        <span style = "color:#009E73">Gentoo</span>') +
  theme(
    plot.subtitle = ggtext::element_markdown(size = 10, lineheight = 1.3)
  ) +
  scale_color_manual(values=c('#E69F00','#0072B2','#009E73'))

Scatterplot_new

ggsave("plots/03 Flipper length by body mass html_COLOUR_subtitle.png", width = 6, height = 4)

# HOW TO REMOVE LEGEND AND ADD COLOUR TO sub-title
# Three steps to use color in your title instead of wasting space on a huge legend. 
# Source: Tweet from Albert Rapp: https://t.co/DoZR0Z0VM9
# 3. Remove legend as it is not needed
library(ggtext)

Scatterplot_new<-  ggplot(Data, aes(x =flipper_length_mm, y = body_mass_g, color = species )) +
  geom_point(size = 2) +
  labs(
    title="Palmer Penguins",
    subtitle = 'Penguin weights (in g) for the Species <span style = "color:#E69F00">Aldeie </span>, 
                                                        <span style = "color:#0072B2">Chinstrap </span> and
                                                         <span style = "color:#009E73">Gentoo</span>',
    caption="Plot design source:AlbertRapp @rappa753",
    x = "Flipper Length (mm)",y = "Body Mass (g)") +
  theme(
    panel.background = element_blank(),
    legend.position = "none",
    plot.subtitle = ggtext::element_markdown(size = 10, lineheight = 1.3)
  ) +
  scale_color_manual(values=c('#E69F00','#0072B2','#009E73'))
Scatterplot_new

ggsave("plots/04 Final formatted scatterplot.png", width = 6, height = 4)
