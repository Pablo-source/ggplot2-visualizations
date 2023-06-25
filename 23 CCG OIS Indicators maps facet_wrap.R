# CCG OIS Indicators ggplot2 maps
# R Script: 23 CCG OIS Indicators maps facet_wrap.R
library(sf)
library(here)
library(dplyr)
library(ggplot2)
library(readxl)
library(janitor)


# 1. Download CCG Indicators
CCGdata <- function() {
  if(!dir.exists("data")){dir.create("data")}
  # Download master.zip file 
  download.file(
    url = "https://files.digital.nhs.uk/48/4DB2CA/CCG_OIS_MAR_2022_Excels_Files.zip",
    destfile = "data/CCGoutcomes.zip")
  unzip(zipfile = "data/CCGoutcomes.zip",
        exdir = "data",junkpaths = T)}

CCGdata()


# 2. Load Shapefile
CCG_boundaries <- st_read(here("data","Clinical_Commissioning_Groups_April_2021","CCG_APR_2021_EN_BFC.shp"))

# Check Shapefiles output
CCG_map <- ggplot() +
  geom_sf(data = CCG_boundaries, size = 0.5, color = "black", fill ="coral") +
  ggtitle("CCG Boundaries plot. April 2021") +
  coord_sf()
CCG_map

# Save maps
ggsave("plots/01_Map_CCG_Boundaries_April2021.png", width = 6, height = 4)

# 3. Obtain NHS Indicators

CCGdata <- function() {if(!dir.exists("data")){dir.create("data")}
  # Download master.zip file 
  download.file(
    url = "https://files.digital.nhs.uk/48/4DB2CA/CCG_OIS_MAR_2022_Excels_Files.zip",
    destfile = "data/CCGoutcomes.zip")
  unzip(zipfile = "data/CCGoutcomes.zip",
        exdir = "data",
        junkpaths = T) }

CCGdata()
# List excel files on Data sub-directory
list.files (path = "./data" ,pattern = "xlsx$")

# 4. Data wrangling

# Select CCG OIS - Indicator 1.17
# Name: Record of stage of cancer at diagnosis
# File: CCG_1.17_I01968_D
# Description: The file contains indicator values for CCG OIS Indicator 1.17 - Percentage of new cases of cancer
# for which a valid stage is recorded at the time of diagnosis, 95% CI
# Reporting period: 2013,2014,2015,2016,2017,2018,2019
# Soure: NHS Digital National Disease Registration Service (NDRS)


cancer_data <- read_excel(here("data", "CCG_1.17_I01968_D.xlsx"), 
                          sheet = 3, skip =13) %>%
                clean_names() %>% 
                select("reporting_period","breakdown","ons_code",
                       "level","level_description","indicator_value")%>% 
                filter(level_description !="England")
cancer_data

cancer_data_sel <- cancer_data %>% 
  select("reporting_period","breakdown","ons_code",
         "level","level_description","indicator_value") %>% 
  filter(level_description !="England")
cancer_data_sel

# 5. Split cancer data by years

# 5.1 obtain number of records by year
cancer_data_ren <- cancer_data_sel %>% select(date = reporting_period , breakdown, ons_code, 
                                    level, level_description,indicator_value )
cancer_data_ren
dist_years <- cancer_data_ren %>% select(date) %>% group_by(date) %>% count()
dist_years

# 2013 and 2014 data 
cancer_2013_14 <- cancer_data_ren %>% filter(date =="2013"|date =="2014")
cancer_2013_14

# 6. PLOT Maps using facet_wrap 
# Remove previous data sets from environment
# Just keep CCG_boundaries and indicator data sets for each year (2013,2019)
# we only need the data_evolution dataset
rm(list=ls()[! ls() %in% c("CCG_boundaries","cancer_2013_14")])

# 6.1 Load shapefile for all set of maps
CCG_boundaries_MAP <- CCG_boundaries

# 6.2 Draw cancer indicator map for each year 
# 6.2.1 Prepare data for plots (save it in a workspace)
cancer1314 <- cancer_2013_14 %>% select( date,breakdown, CCG21CD = ons_code,level,level_description,indicator_value)
cancer1314

# We merge both shape file and metric data set using DPLYR
mapdata_1314 <- left_join(CCG_boundaries_MAP, cancer1314, by = "CCG21CD") 

# 6.2.1 APPLY SPECIFIC PROJECTION TO MERGED DATA SET
# Apply specific projection (epsg:4326) to the map
# and indicator merged data set 
mapdata_coord_1314 <- st_transform(mapdata_1314, "+init=epsg:4326")

# 7. Create MAPS using facet_wrap
# Map displaying New cases of cancer for 2013 and 2014.
# facet_wrap(~date) to display two maps on the same graphical output file

cancer_map<- mapdata_coord_1314 %>%  
  ggplot(color=qsec)+ 
  aes(fill = indicator_value) +
  geom_sf() +
  facet_wrap(~date)+
    labs(title = "Percent of new cases of cancer 2013-2014",
       subtitle = "Valid stage recorded at diagnosis,(95% CI)",
       caption = "Data source: NHS Digital (NDRS). CCG OIS Indicator 1.17") +
  theme(legend.title=element_blank(),
        axis.text.x = element_blank(),
              axis.text.y = element_blank(),
              axis.ticks = element_blank(),
              rect = element_blank())
cancer_map

ggsave("plots/08_facet_wrap_ggplot2_maps_year_cases_of_cancer.png", width = 6, height = 4)
