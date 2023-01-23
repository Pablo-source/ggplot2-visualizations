
library(here)

project_setup <-function(){ 
  
  if(!dir.exists("data")){dir.create(here("data"))}
  if(!dir.exists("plots")){dir.create(here("plots"))}
  if(!dir.exists("Archive")){dir.create(here("Archive"))}
  if(!dir.exists("Test")){dir.create(here("Test"))}

} 

# Run code below to use function and create folder structure
project_setup()