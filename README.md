# ggplot2-visualizations

This is a project designed to display a set of visualizations using GGPLOT2 package. Using different geoms and also creating small multiple plots using facet_wrap to split initial data by other set of variables. Using RStudio integrated with GitHub to commit all changes from my IDE.

It aims to present different ways of representing data. It will use NHS data from England,to display several ways of presenting Time Series data using R. 

Data has been downloaded from <https://www.england.nhs.uk/statistics>, these statistics are publicly available. 

Original downloaded files from the above website are Excel files .xlsx, and I have used this set of packages  installed using packman package manager pacman::p_load(readxl,here,dplyr,janitor) to conduct the initial data pre-processing, to arange the data in a way that will be easy to use when creating a set of plots. 

<https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/>

## A&E Attendances and Emergency Admissions

The Weekly and Monthly A&E Attendances and Emergency Admissions collection collects the total number of attendances in the specified period for all A&E types, including Minor Injury Units and Walk-in Centres, and of these, the number discharged, admitted or transferred within four hours of arrival.

<https://www.england.nhs.uk/statistics/statistical-work-areas/ae-waiting-times-and-activity/>

We can download the Unadjusted: Monthly A&E Time Series April 2019 (XLS 364K) file:

1. Open your web-browser browser

2. Go to Applications menu top right corner

3. Select More Tools > Page Source

4. The HTML code will be displayed. Then we need to press CTRL +F to open the find option on the HTML page, as we are looking for “Time series” word within the main website

This allows us to locate the .xls file for Unadjusted Time Series data and to download it from R. 

<p><a href="https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/11/Timeseries-monthly-Unadjusted-9kidr.xls">Unadjusted: Monthly A&amp;E Time series April 2019 (XLS, 364K)</a><br />

## Consultant-led Referral to Treatment Waiting Times

This section contains information on Consultant-led Referral To Treatment (RTT) waiting times, which monitor the length of time from referral through to elective treatment.

Monthly RTT waiting times data has been published since March 2007. Initially data was only published for patients whose RTT pathways ended in admission for treatment (admitted pathways). Non-admitted pathway data (patients whose RTT pathways ended for reasons other than admission for treatment) has been published since August 2007. 

<https://www.england.nhs.uk/statistics/statistical-work-areas/rtt-waiting-times/>

## RStudio project linked to GitHub

This project is being build using RStudio to commit directly all script changes to the ggplot2-visualizations GitHub repo. 

![Updating R scripts from Github](https://user-images.githubusercontent.com/76554081/215121553-71649b92-ea00-45d7-a100-b3857e37ddd6.jpg)

## Sample of some GGPLOT2 plots created in this repo 

Some plots produced include themes, in the plots folder there is a collection of all plots iterations using GGPLOT2
  
Using library(gridExtra) to arrange below plots: grid.arrange(TypeI_theme_bw,TypeI_theme_light,TypeI_theme_classic,TypeI_theme_dark,ncol=4)


![AE Attendances aspect ratio grid](https://user-images.githubusercontent.com/76554081/215345149-b23688a5-8e00-4ba0-99e9-c82438d9bbf9.png)

Example of a smooth line added to the AE Type I Attendances plot and tailored y axis labels

Tailored geom smooth by using these parameters (se = TRUE,FALSE, display SE; span = 0.1 Use span to control the "wiggliness" of the default loess smoother) 

geom_smooth(span = 0.1,se = TRUE, size = 0.8)

![08 AE Attendances custom geom_smooth](https://user-images.githubusercontent.com/76554081/215996970-5de470de-6e4c-4e17-b2dc-29bad4c06056.png)

### Showing set of plots split by variables using facet_wrap 

This plot is just a small example on how to use facet_wrap to display specific plots by any categorical variable. In this instance I wanted to show AE Type I attendances in England by months and years.

It is important to remember to turn your months variable into a Factor for the months label to be chronologically displayed in the plot.

Att_Full_year_f <-  Att_Full_year %>% mutate(Monthf = factor(Month, levels = month.abb))

![11_AE_Attendances_facet_wrap](https://user-images.githubusercontent.com/76554081/216084514-b1ff7681-f155-48d3-8485-27cd430000aa.png)
