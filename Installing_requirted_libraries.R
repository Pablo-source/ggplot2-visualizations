# Installing required libraries on this fresh Ubuntu installation on RStudio
# 07/06/2025
here()
# [1] "/home/pablo/Documents/Pablo_ubuntu/Repos/Pablo_source_repo/ggplot2-visualizations"

install.packages("readxl",dependencies = TRUE)
install.packages("tidyverse",dependencies = TRUE)
install.packages("janitor",dependencies = TRUE)

# Then Load required libraries 
library(tidyverse)
library(readxl)
library(janitor)