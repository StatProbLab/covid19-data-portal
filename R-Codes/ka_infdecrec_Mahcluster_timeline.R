###############################################################
## Title: Histogram of the "From Maharastra" Cluster         ##
## Input: KAtrace26June.csv                                  ##
## Output: Plot of Cluster Vs Counts                         ##
## Date Modified: 02-05-2024                                 ##
###############################################################

## Histogram of the 'From Maharashtra' cluster in Karnataka 
## Each bar is color-coded according to the condition of the case- Active, Deceased or Recovered. 
## The bins of the histogram are the groups in the 'From Maharashtra' cluster

## Required Libraries
library(plotly)
library(stringr)

data1=read.csv("../Data/KAtrace26June.csv") ##note that this code only works with the KAtrace version that was not updated after 26 June

## variables to store custom fonts and colors
f <- list(family = "serif", size = 17, color = 'maroon',face="bold")
f2<- list(family = "serif", size = 13, color = 'black')
cl=c("#91090a","#42d40d","#f2a90c")

## variable to store the condition of the case- Active, Deceased or Recovered
cndtn=data1[,10]
levels(cndtn)[1]<-"A"

## defining the clusters and assigning a cluster to each case
cluster=data1[,7]
cluster=factor(cluster, levels=c("From Middle East",
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
cluster=factor(cluster,labels=c("Middle East",
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

## specifying categories of the condition
cndtn_lev=c("D","C","A")
cndtn_lev_name=c("Deceased","Cured","Active")

## selecting the 'From Maharshtra' cluster
cluster2_index=which(cluster=="Maharashtra")

## Defining groups in the 'From Maharashtra' cluster
cluster2=c()
city=data1$City[cluster2_index]
for (i in 1:length(cluster2_index)){
  cluster2[i]=word(city[i],1)
}
cluster2=factor(cluster2)
df2=data.frame(cluster2,"cndtn"=cndtn[cluster2_index])

## plotly histogram which has clusters as bins and bars color-coded according to condition
fig<-plot_ly()
for(i in 1:3){ 
  fig<-fig%>%add_histogram(x=df2[which(df2$cndtn==cndtn_lev[i]),1],y=cndtn_lev_name[i],marker=list(color=cl[i]))
}
fig<-fig%>%layout(barmode="stack",title="Histogram for Cluster: From Maharahstra", titlefont=f,yaxis=list(title="Count",titlefont=f2,tickfont=f2),xaxis=list(tickangle=-45,tickfont=f2))
fig

## saving the graph
save_image(fig, "./plotlyfigures/infdedrecMah.svg")
name = paste("infdedrec","clustersMah.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")