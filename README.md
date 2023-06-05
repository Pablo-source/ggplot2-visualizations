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

#### a) AE_Type_I Attendances by Year

This plot is just a small example on how to use facet_wrap to display specific plots by any categorical variable. In this instance I wanted to show AE Type I attendances in England by months and years.

It is important to remember to turn your months variable into a Factor for the months label to be chronologically displayed in the plot.

Att_Full_year_f <-  Att_Full_year %>% mutate(Monthf = factor(Month, levels = month.abb))
  
![13 Facet_wrap_attendances](https://user-images.githubusercontent.com/76554081/216088100-9966c033-61de-4bfe-8ba4-20dfbe18c32b.png)

#### b) AE Attendances by metric (Type I Major Attendances, Type 2 Single esp Attendances, Type 3 Other Attendances

This time we first re-shape our data to be in long format and then we use  facet_wrap with the newly created Metrics column

![12_AE_Attendances_facet_wrap_metric_01](https://user-images.githubusercontent.com/76554081/216392499-94f5af7a-cfd9-4827-aa1c-db8508dd6730.png)


### AE Attendances by type on a single plot

We can also re-shape our data in long format to use Metric as color ggplot(aes(x = period, y = value,group = Metrics, colour = Metrics)).
Allowing us to plot a single line for each AE Attendances type (I,II,III and Total) on the same figure.

![14_AE_Attendances_by_type](https://user-images.githubusercontent.com/76554081/216571537-6f0cc2f2-8247-411c-bc52-ce4649dd072a.png)


### AE Attendances by type by month and year including a smooth line

We can also include a regression line for each of the individual facettted plots, as in "09 AE Attendances_by_year_geom_smooth.R", by using facet_wrap(~Year), group = Year and specially adding this new layer to the ggplot "geom_smooth(se = TRUE, colour = "darkorchid1" as shown below:

![18_AE_Attendances_facet_wrap_smooth](https://user-images.githubusercontent.com/76554081/216657329-3bf3f51b-0d51-4c08-b9a7-a1278891a726.png)

### AE Attendances by type combining density plot and scatterplot

We can also combine two continuous measures like AE Type 1 Major AE And Type 2 single specialty into a scatterplot and add to this initial plot two density plots for each X and Y axis, describing the shape of the distribution for each of these metrics. See "11 Density plot Major Single AE Attendances.R" script for details.  

Desity_plot02 <- Att_months %>% 
  ggplot(aes(Major_att, Single_esp_att, Metrics, color = Month)) +
  ggtitle("AE Major attendances (Type 2: Major A_E vs Single_specialty departments. 2011-2019") +
  geom_point(size = 2, alpha = 0.3)   +
  
- Adding density plot for X axis (AE Type_2 major_a_e)
  geom_xsidedensity(
    aes(y = after_stat(density),fill = Month),
    alpha = 0.5, size = 1,
    position = "stack") +

- Adding density plot for Y axis (AE Type_2 single_specialty)
geom_ysidedensity(
  aes(x = after_stat(density),fill = Month),
  alpha = 0.5, size = 1,
  position = "stack")  
  
Desity_plot02

In the plot below is the result of this combination:

![23 AE_major_attendances_A_E_single_Specialty](https://user-images.githubusercontent.com/76554081/217067693-539bbb28-b88e-45eb-ad69-aad187449c23.png)

### AE Attendances by year using a Raincloud chart

A Raincloud chart allows us to combine different visualizations to explore metrics distributions shape using ggdist package
In this particular example, I plot number of Major A&E Attendances by year for 2010-2013 period, using the following three density plot functios from ggdis package:
stat_halfeye(), stat_dots() and geom_boxplot(). 

Using this ggdis plackage, many other functions allow to select the best geom to visualize frequency distributions in our plots. See script "12 Raincloud chart AE Attendances.R" in this project for further details about this Raincloud chart below:

![24_AE_Attendances_Raincloud_chart](https://user-images.githubusercontent.com/76554081/219657470-8f9e3baf-a818-41a4-bc04-29bd88370147.png)

### OECD Iflation CPI using a Spaghetti plot

An standard area plot can be quickly transformed into a Spaghetti plot

![01 Consumer price index 1974-2022](https://user-images.githubusercontent.com/76554081/221425760-879d6d16-2a7a-4e4f-843c-6417a20216e7.png)

This is an exmaple on how to create a Spaghetti plot to highlight a serie within a set of several time series indicators

![02 Spaghetti chart inflation selected countries](https://user-images.githubusercontent.com/76554081/221425688-d23b1197-732b-42cc-92d1-45bd889dd498.png)

See script "13 Spaghetti plot OECD CPI 1974_2022.R" in this project for further details

Also we can include latest value for each country, highlighted as a purple dot, See script "13 01 Spaghetti plot OECD CPI 1974_2022.R" for details

![03 Spaguetti plot latest value purple](https://user-images.githubusercontent.com/76554081/222247710-87e5ced9-54b7-4fcf-bd0b-7eca70b761f6.png)




### OECD Inflation CPI metric using a Sparkline plot

Furthermore, we can use this charts to identify Min, Max and latest values in any TS, using facets to split plots in this instance by county.
See script **14 Sprkline OECD CPI.R*" in this project for specific details on this sparkline charts

The building blocks of this chart is made of an adhoc set of calculations to be displayed as dots in the main line chart. They will be visual references, and it can be extended to compute the five number summary (Min, Q1, Q2 (median), Q3, Max) or any other adhoc statistics like any central tendency measure

- Set of calculated values to be displayed in the line as dot geoms using ggplot2

minv <- group_by(OECD_subset, country) %>% slice(which.min(value))  (red dot)

maxv <- group_by(OECD_subset, country) %>% slice(which.max(value))  (blue dot)

endv <- group_by(OECD_subset, country) %>% filter(time == max(time)) (purple dot)

![05 Sparkline OECD CPI sel countries](https://user-images.githubusercontent.com/76554081/221958954-7448a992-403c-43c4-9b02-2853b6438518.png)

## Appendix

## Create an animated GIF from a ggplot2 chart

How to use Camcoder package to record animated GIF from GGPLOT2 charts
https://github.com/thebioengineer/camcorder

There is an example on this project on how to use camcoder to create a GIF from a ggplot chart. Useful to explore the design process of any chart in R

![AE_Attendances_England](https://user-images.githubusercontent.com/76554081/220868334-87326e42-3bd1-4584-9ceb-07ebed26cbab.gif)

This can be included in any presentation, when it might be useful to teach of to design ggplots in R. See details in this folder on this repo: https://github.com/Pablo-source/ggplot2-visualizations/tree/main/camcoder

## Using google fonts

There is the showtext package that allows us to use different google fonts on our chats. It can be useful when producing a more elaborated charts in R linke maps, where we want to obtain a specific aesthetic effect using fonts. See:  https://fonts.google.com/. Some examples of this can bee seen in "A Using Google fonts in plots.R" scripts.

![03 Histogram bell family Barlow condensed google font](https://user-images.githubusercontent.com/76554081/219947428-803ddd33-c745-4cb0-bff9-e7ef1feacce5.png)

![04 Histogram bell google font didactic gothic](https://user-images.githubusercontent.com/76554081/219947433-40f2e618-d89e-4e7f-89bc-f1814280f3c9.png)

## Annotations in ggplot2 plots

This is an example on how to use annotations and reference lines to a ggplot2 charts. In this example I plot Bank of England Official Bank Rates against the three lockdowns that we had in the UK during COVID19 pandemic. For details on the scrips used to produce this chart please see "16 BoE Interest rates from chart.R" script. 

![01 Bank of England Bank Rates and covid lockdowns](https://user-images.githubusercontent.com/76554081/235512513-efc676e4-b828-4529-968a-bb50228b0261.png)

## Using arrows to point to specific features in charts

We can use geom_curve() function to draw specific arrows pointing to data points we want to highlight in our chart. The plot below build from "17 Annotations mtcars data set.R" script in this project. Also, I have used geom_text_repel() function to avoid labels overlapping in the plot. 

![02 Car efficiency](https://user-images.githubusercontent.com/76554081/235616257-803f886d-8438-42ba-8a51-aba882de6cec.png)

## Improve charts quality using Tufte design principles
  
The chart below is an example on how to apply Tufte design priniples to improve graph readibility. He claimed that a good graphical representations maximize data-ink and erase as much non-data-ink as possible. This is a good design practise when creating ggplot2 charts in R. One key concept he developed was the data-ink ratio which is calculated by 1 minus the proportion of the graph that can be erased without loss of data-information.

The five design principles he created can be an excelent guide to create better charts in R: 
 - Above all else show data.
- Maximize the data-ink ratio.
- Erase non-data-ink.
- Erase redundant data-ink.
- Revise and edit

On top of these design principles, I have improved the previous **BoE Interest rates chart** design by apoplying these set of changes: 
1. Adding several paramters to the theme() function: 
- Remove default chart area grey color background, make it white instead
      panel.background = element_rect(fill = NA), 
- Remove X axis grid lines, x axis lines provide sufficient guideline to identify (bank interest rate) value 
       panel.grid.major.x = element_blank(),
       panel.grid.minor.x = element_blank(), 
- Keep just major Y axis grid lines, use black colour to match axis and title font colour
        panel.grid.major.y = element_line(colour = "black")

2. Added custom Title to x and Y axis using labs() function
- labs(title = "BoE Interest rates reach 4.5% in May 2023",
- subtitle ="Twelfth interest rate increase since Jan 2022",
- y = "Interest rate %",
- x = "Year")

 See script "18 Tufte style charts in R.R" for details on the above changes applied to this chart: 
  
![02 BoE Interest rates May2023](https://github.com/Pablo-source/ggplot2-visualizations/assets/76554081/bb3d07e3-a0f7-4e7d-95b0-4df4fb3dac67)


  The final ggplot2 chart output can be found here on this ggplot2 visualizations project: plots/25 Tufte style chart.png

## Arrange several plots on a page

Using gridExtra package we can arrange several charts in one image, choosing the layout of the charts in rows and cols. In this instance I combine the three inflation measures (CPI,CPIH,OOH) using ONS data, from the Consumer price inflation latest release: https://www.ons.gov.uk/economy/inflationandpriceindices/bulletins/consumerpriceinflation/april2023, 
into a single image made of three charts arranged in three columns and one row. See script "19 GridExtra combine charts.R", for details on how to use grid.arrange() function see: https://cran.r-project.org/web/packages/gridExtra/vignettes/arrangeGrob.html
  
  ![33 Grid_Extra_inflation_charts](https://github.com/Pablo-source/ggplot2-visualizations/assets/76554081/59b4dcb7-667c-4607-89f2-0a343519a600)

  
  
  
