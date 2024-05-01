############################################################
## Title: Active Covid19 Cases in Karnataka               ##
## Input: IRDD_allka.csv                                  ##  
## Output: Plot of Date Vs Active Cases                   ##
## Date Modified: 23-04-2024                              ##
############################################################

library(dplyr)
library(ggplot2)
library(tidyr)
library(gganimate)
library(viridis)
library(hrbrthemes)
library(plotly)
library(anim.plots)

allka_data = read.csv('./data/IRDD_allka.csv')
region_name = 'Karnataka'
region = subset(allka_data,allka_data$District==region_name)
region <- region[,-2]
region$Date = as.Date(region$Date,"%d-%m-%Y")
region = na.omit(region)

# plot of total active cases in Karnataka over time
a_ = ggplot(region, aes(x=Date, y=Infected-Recovered-Deceased)) +
  labs(
    title=paste0("Active Coronavirus Cases in ",region_name),
    x="Date", y="Active Cases"
  ) +
  geom_point(colour='lightblue') +
  geom_line() +
  scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +
  scale_y_continuous(n.breaks=7,labels=scales::comma)+
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, size=7, face=7, hjust=1)) + 
  theme(plot.title = element_text(hjust = 0.5)) +   
  theme(plot.title = element_text(color="maroon", size=14, face="bold"), axis.title.x = element_text(color="maroon", size=14),axis.title.y = element_text(color="maroon", size=14)) +
  scale_color_viridis(discrete = TRUE)

# animate for .gif image
an_ = animate(a_+transition_reveal(region$Date), renderer = gifski_renderer(paste0('./graphs/active_cases_',region_name,'.gif')),
              width = 2560, height = 1440, res = 300, fps = 10)