# ggplot2-visualizations

This is a project designed to display a set of visualizations using GGPLOT2 package. Using different geoms and also creating small multiple plots using facet_wrap to split initial  data by other set of variables.

It aims to present different ways of representing data. It will use RTT data from NHS England, Consultant-led Referral to Treatment Waiting Times Data, to display several ways of presenting Time Series data using visualizations in R using GGPLOT2 package. 

Data has been downloaded from <https://www.england.nhs.uk/statistics/statistical-work-areas/rtt-waiting-times/rtt-data-2022-23/>, these statistics are publicly available. 

Original downloaded files from the above website are Excel files .xlsx, and I have used this set of packages  pacman::p_load(readxl,here,dplyr,janitor) to conduct the initial data pre-processing, to arange the data in a way that will be easy to use when creating a set of plots. 