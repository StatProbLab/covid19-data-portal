############################################################
## Title: Daily New Covid19 Cases in India                ##
## Input: IRDD_allindia.csv                               ##  
## Output: Plot of Date Vs Daily New Cases                ##
## Date Modified: 26-04-2024                              ##
############################################################

# Libraries Required
library(ggplot2)
library(plotly)

# Reading Data of daily counts of infected, recovered, and deceased in India.
allindia <- read.csv("./data/IRDD_allindia.csv", header=TRUE)

# The total infections upto a given day is the sum of the Infected, Recovered and deceased upto that day
inf <- subset(allindia,select = c("Date","Infected"))
ded <- subset(allindia,select = c("Date","Deceased"))
rec <- subset(allindia,select = c("Date","Recovered"))
inf$Count = inf$Infected + ded$Deceased + rec$Recovered

n=length(inf$Date)         # n is the number of days
Dates <- inf$Date[2:n]     # These are the corresponding dates, we don't plot Day 1

# Compute daily increase using diff and create data frame.
dIN<- data.frame( Date = rep(Dates,3), Condition = rep("Infected",n-1), Count = diff(inf$Count))

# Ensures that the order of the dates on the x-axis is correct.
dIN$Date <- factor(dIN$Date,levels = unique(dIN$Date))      
dIN = na.omit(dIN)
# Barplot of daily increase using ggplot
u=ggplot(dIN,aes(x=Date,y=Count))+geom_bar(position="stack",stat="identity",fill="orange")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+ theme(legend.title = element_blank())+ theme(plot.title = element_text(hjust = 0.5))+scale_x_discrete(breaks = unique(dIN$Date)[c(T,F,F,F,F,F)])+ggtitle("Daily increase in coronavirus cases in India")

# Converting to a Plotly graph
up = ggplotly(u)

# Saving Output as .html
name = paste("der","timeline.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(up, file=path, selfcontained = FALSE, libdir = "plotly.html")

# Saving Output as .png 
name1 = paste("der","timeline.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=u)
