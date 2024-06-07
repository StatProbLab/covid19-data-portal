############################################################
## Title: Daily New Covid19 Cases in India                ##
## Input: IRDD_allindia.csv                               ##  
## Output: Plot of Date Vs Daily New Cases                ##
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

allindia_data = read.csv('./data/IRDD_allindia.csv')
region_name = 'India'
region = subset(allindia_data,allindia_data$State==region_name)
region <- region[,-2]
region$Date = as.Date(region$Date,"%d-%m-%Y")
region = na.omit(region)

# plot of daily new cases in India over time
Newcases = region[,c(1,2)]
for (i in 2:nrow(region)) {
  Newcases[i,2] = region[i,2] - region[i-1,2]
}
colnames(Newcases) = c("Date","NewCases")
a_ = ggplot(Newcases, aes(x=Date, y=NewCases)) +
  labs(
    title=paste0("Daily New Coronavirus Cases in ",region_name),
    x="Date", y="Daily New Cases"
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
an_ = animate(a_+transition_reveal(Newcases$Date), renderer = gifski_renderer(paste0('./graphs/dailynew_cases_',region_name,'.gif')),
              width = 2560, height = 1440, res = 300, fps = 10)