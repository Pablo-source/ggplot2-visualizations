
library(here)

project_setup <-function(){
  
  if(!dir.exists("data")){dir.create(here::here("data"))}
  if(!dir.exists("Output")){dir.create(here::here("Output"))}
  if(!dir.exists("Shapefiles")){dir.create(here::here("Shapefiles"))}
  if(!dir.exists("Checks")){dir.create(here::here("Checks"))}
  if(!dir.exists("Maps")){dir.create(here::here("Maps"))}
  if(!dir.exists("Archive")){dir.create(here::here("Archive"))}
  #Create sub-folders within folders. This sub folder is nested under Archive folder
  if(dir.exists("Archive")){dir.create(here::here("/home/pablo/Documents/Pablo/Rprojects/Rwarehouse/Archive/subfolder_new"))}
  
} 

# Run code below to use function and create folder structure
project_setup()