# Annotations
library(tidyverse)

# Check available data sets
data()

# Load  built-in Data sets
data("mtcars")

head(mtcars)
nrow(mtcars)
str(mtcars)

# 1 Build a standard scatter plot

# load ggrepel to avoid overlapping labels
library(ggrepel)

Myplot <- ggplot(mtcars, aes(x = wt , y = mpg)) +
  geom_point() +
  labs(title = "Car efficiency by maker",
       subtitle ="Miles per gallong vs Weight",
       # Change X and Y axis labels
       x = "Miles per gallon", 
       y = "Weight") +
  # Repel overlapping text labels 
 geom_text_repel(label=rownames(mtcars))
Myplot

# 2. Add geom_curve() geom to annotate some points
Myplot +
  geom_curve(
    aes(x = 5.2, y = 18, xend = 5.3, yend = 16),
    arrow = arrow(length = unit(0.1, "inch")), size = 0.5, 
    color = "#0093b1", curvature = -0.5) +  # 0 straight line, , negative = left-hand curves, positive = right-hand curves) 
    
  geom_curve(
    aes(x = 2.1, y = 30.0, xend = 2.0, yend = 33),
    arrow = arrow(length = unit(0.1, "inch")), size = 0.5, 
    color = "#CC3366", curvature = -0.5) +
  
  theme_bw() +
# 3. Add annotations
annotate ("text", x = 5, y =20, label ="High  efficiency cars \n low weight high mpg", family = "seruf", color = "#0093b1") +
annotate ("text", x = 2.5, y =30, label ="Low efficiency cars \n high weight low mpg", family = "seruf", color = "#CC3366")


# Save output plot 
ggsave("02 Car efficiency.png", width = 10, height = 6) 
