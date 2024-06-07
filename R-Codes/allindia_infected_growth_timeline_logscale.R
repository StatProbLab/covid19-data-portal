###############################################################
## Title: All india Timeline for Infection Growth (log scale)## 
## Input: IRDD_allindia.csv                                  ##  
## Output: Plot of Date Vs Number of Cases                   ##
## Date Modified: 29-04-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly) 
library(tidyr)

# Reading Data of daily counts of infected, recovered, and deceased in India.
allindia = read.csv("./data/IRDD_allindia.csv",header=TRUE)
allindia = filter(allindia,State=='India')
IN = pivot_longer(allindia,c("Infected","Recovered","Deceased"),names_to = "Condition", values_to = "Count")[,-2]

# Add Factor: "Active Cases". Replaced  "Infected" with "Active Cases."
IN$Condition <- factor(IN$Condition ,levels = c("Infected","Active Cases","Recovered","Deceased"))
IN$Condition[which(IN$Condition=="Infected")] = "Active Cases"

# Ensures that the order of the dates on the x-axis is correct.
IN$Date = format(as.Date(IN$Date,"%d-%m-%Y"),"%d-%b-%y")
IN$Date<- factor(IN$Date,levels=unique(IN$Date))

# Stacked Area Plot using ggplot
g = ggplot(IN,aes(x=Date,y=Count,group=Condition,fill=Condition))+geom_area(position="stack")+scale_fill_manual(breaks = c("Active Cases","Recovered","Deceased"), values=c("orange", "green", "darkred"))+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle("All India")+labs(y=" ", x = " ") + theme(legend.title = element_blank())+ theme(plot.title = element_text(hjust = 0.5))+scale_x_discrete(breaks = unique(IN$Date)[c(T,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F)])+ scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

# Converting to a Plotly graph
gp = ggplotly(g, tooltip =c("x","y","group"))

# Saving Output as .png and .html
name = paste("allindia","timeline.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

name1 = paste("allindia","timeline.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)
