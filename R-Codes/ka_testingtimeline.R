###############################################################
## Title: Stacked plot of the Cumulative Counts of-          ##
##        Tests reported Positive, Tests reported Negative   ##
##        and Tests whose results are Awaited in Karnataka   ##
## Input: KAtrace26June.csv                                  ##
## Output: Plot of Date Vs Number of Childeren               ##
## Date Modified: 06-05-2024                                 ##
###############################################################

## Required Libraries
library(plotly)

## Reading the csv file containing tests done, number of tests reported positive and number of tests reported negative
## note that this code only works with the csv file version that was not updated after 16 July
testdata=read.csv("../Data/karnatakadatabriefstesting16July.csv") 
total=testdata[,1]
pos=testdata[,3]
neg=testdata[,2]

## preparing date headings for x-labels
date=seq(as.Date("12/03/20","%d/%m/%y"),length=length(pos),by="1 day")
d2=format(date, "%d-%b")

## variables to store custom fonts
f <- list(family = "serif", size = 17, color = 'black',face="bold")
f2<- list(family = "serif", size = 13, color = 'black',face="bold")
f3<-list( family="serif",size=13,color='black')

## preparing the data frame df for cumulative counts
tested<-pos+neg
total<-cumsum(total)
pos<-cumsum(pos)
neg<-cumsum(neg)
awaited<-total-neg-pos
df=data.frame("Date"=d2,"Awa"=awaited, "Pos"=pos,"Neg"=neg)
df$Date=factor(df$Date, levels=d2)

## plotly stacked plot of tests reported Positive, Tests reported Negative and Tests whose results are Awaited
fig<-plot_ly(df,x=~Date,y=~Pos,type="scatter",mode="lines",name="Positive Samples",fillcolor="darkred",line=list(color="darkred"),stackgroup="one",hoverinfo='text',text=~paste('</br> Date: ',Date,'</br> Positive Samples: ',Pos))
fig<-fig%>% add_trace(y=df$Neg,name="Negative Samples",fillcolor="lightgreen",line=list(color="lightgreen"),hoverinfo='text',text=~paste('<br> Date:',Date,'<br> Negative Samples: ',Neg))
fig<-fig%>% add_trace(y=df$Awa,name="Results Awaited",fillcolor="lightblue",line=list(color="lightblue"),hoverinfo='text',text=~paste('<br> Date:',Date,'<br> Results Awaited: ',Awa))
fig<-fig %>% layout(title= "Karnataka COVID Samples- Cumulative Count",font=f2, yaxis=list(title=" ", titlefont=f,tickfont=f3,showgrid=T,showline=T,zeroline=F),xaxis= list(title=" ",tickangle=-45,tickfont=f3,showgrid=T,showline=T, ticklabels=F))

## saving the graph
save_image(fig, "./plotlyfigures/sampletest.svg")
name = paste("sample","test.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")