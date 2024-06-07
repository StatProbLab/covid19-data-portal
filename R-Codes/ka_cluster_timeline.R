###############################################################
## Title: Timeline of Karnataka Clusters                     ##
## Input: KAtrace26June.csv                                  ##
## Output: Plot of Day Vs Counts in each Cluster             ##
## Date Modified: 02-05-2024                                 ##
###############################################################

## Required Libraries
library(plotly)

data1=read.csv("../Data/KAtrace26June.csv") ##note that this code only works with the KAtrace version that was not updated after 26 June

## variables to store custom fonts
f <- list(family = "serif", size = 17, color = 'maroon',face="bold")
f2<- list(family = "serif", size = 13, color = 'black')

## cleaning the data and preparing date headings for x-labels
data1<-data1[8:length(data1[,2]),]
db=seq(from=as.Date("17-03-2020","%d-%m-%y"),to=Sys.Date(),by="1 day")
lev<-levels(factor(data1[,7]))
count=matrix(0,nrow=length(lev),ncol=length(db))
data2=as.Date(data1[,2],"%d-%b")

## finding the cumulative count of total cases reported till each date
for(j in 1:length(lev)){
  for(i in 1:length(db)){
    count[j,i]<-length(which(data1[,7]==lev[j]&data2==db[i]))
  }
}
for(j in 1:length(lev)){
  count[j,]<-cumsum(count[j,])
}

## preparing the data frame required for making a dynamic plot
df<-NULL
for(i in 1:length(count[1,])){
  for(j in 1:length(lev)){ 
    x=1:i
    y=count[j,1:i]
    f=i
    l=lev[j]
    temp=cbind(x,y,f,l)
    df=rbind(df,temp)
  }
}

## changing the data to numeric type
df<-as.data.frame(df)
df[,2]<-as.numeric(as.character(df[,2]))
df[,1]<-as.numeric(as.character(df[,1]))
df[,3]<-as.numeric(as.character(df[,3]))

## defining the clusters and assigning cluster to each case
df[,4]=factor(df[,4], levels=c("From Middle East",
                               "From South America",
                               "From the rest of Europe",
                               "From United Kingdom",
                               "From USA",
                               "Pharmaceutical Company in Nanjangud",
                               "TJ Congregation from 13th to 18th March in Delhi",
                               "From Maharashtra",
                               "From Rajasthan",
                               "From Gujarat",
                               "From the Southern States",
                               "Influenza like illness",
                               "Severe Acute Respiratory Infection",
                               "Containment Zones",
                               "Others",
                               "Unknown"))
df[,4]=factor(df[,4],labels=c("Middle East",
                              "South America",
                              "Rest of Europe",
                              "United Kingdom",
                              "USA",
                              "Pharmaceutical in Nanjangud",
                              "TJ Congregation",
                              "Maharashtra",
                              "Rajasthan",
                              "Gujarat",
                              "Southern States",
                              "ILI",
                              "SARI",
                              "Containment Zones",
                              "Others",
                              "Unknown"))

## plotly dynamic lineplot that shows the timeline of total cases in each cluster of Karnataka 
fig<-plot_ly(df,x=~x,y=~y,frame=~f,type='scatter',mode='lines',split=~l)%>% layout(title='Timeline of Karnataka Clusters',xaxis=list(title='Day',showline=F,showgrid=F),yaxis=list(title='Count',showgrid=F))
fig

## saving the graph
save_image(fig, "./plotlyfigures/dynamic-hist.svg")
name = paste("dynamic","hist.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")