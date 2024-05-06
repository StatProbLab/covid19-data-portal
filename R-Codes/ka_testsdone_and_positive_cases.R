###############################################################
## Title: Line plot of the daily number of tests done        ##
##        positive cases reported in Karnataka               ##
## Input: karnatakadatabriefstesting.csv                     ##
## Output: Plot of Date Vs Number of Cases                   ##
## Date Modified: 02-05-2024                                 ##
###############################################################

## Required Libraries
library(plotly)

## Reading the csv file containing tests done and number of positive cases reported
testdata=read.csv("../Data/karnatakadatabriefstesting.csv")
total=testdata[,1]
pos=testdata[,3]
neg=testdata[,2]

## preparing the date headings for x-labels
date=seq(as.Date("12/03/20","%d/%m/%y"),length=length(pos),by="1 day")
d2=format(date, "%d-%b-%y")

## variables to store custom fonts
f <- list(family = "serif", size = 17, color = 'black',face="bold")
f2<- list(family = "serif", size = 13, color = 'black',face="bold")
f3<-list( family="serif",size=13,color='black')

## preparing the data frame df2 for daily counts
tested<-pos+neg
df2<-data.frame("Date"=d2[-1],"Tested"=total[-1],"Pos"=pos[-1])
df2$Date=factor(df2$Date, levels=d2)
df2$Date=factor(df2$Date, levels=d2)

## plotly lineplot of tests done and postive cases reported daily-
fig2<-plot_ly(df2, x = ~Date, y = ~Tested, type="scatter" ,mode = 'lines',line= list(color='orange'),hoverinfo = 'text', text = ~paste('</br> Date: ',Date,'</br> Tests Done: ', Tested))
fig2<-fig2  %>% add_trace(df2, x=~Date, y=~Tested, type="scatter", mode="markers",marker=list(color='orange'),textposition='center',showlegend=FALSE) 
fig2<-fig2  %>% add_trace(x = ~Date, y = ~Pos, type="scatter" ,mode = 'lines+markers',line= list(color='darkred'),marker=list(color='darkred'),hoverinfo = 'text', text = ~paste('</br> Date: ',Date,'</br> Positive Cases: ', Pos))
fig2<-fig2  %>% layout(title= 'Karnataka- Tests Done Daily',font=f2, yaxis=list(title="Count",showline=T,zeroline=F),xaxis= list(title=" ",tickangle=-45,tickfont=f3,showline=T),showlegend=F)

## saving the graph
save_image(fig2, "./plotlyfigures/lineplottest.svg")
name = paste("lineplot","test.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig2, file=path, selfcontained = FALSE, libdir = "plotly.html")