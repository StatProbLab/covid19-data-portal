###############################################################
## Title: Histogram of the "From Maharastra" Cluster         ##
## Input: KAtrace26June.csv                                  ##
## Output: Plot of Cluster Vs Counts                         ##
## Date Modified: 02-05-2024                                 ##
###############################################################

## Required Libraries
library(plotly)
library(stringr)

data1=read.csv("../Data/KAtrace26June.csv") 

## variables to store custom fonts
f <- list(family = "serif", size = 17, color = 'maroon',face="bold")
f2<- list(family = "serif", size = 13, color = 'black')

## defining the clusters and separating data according to them
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

## finding the generation of each case and storing in data frame
df=data.frame("p"=data1[,11])
df$p<-replace(df$p,is.na(df$p),0)
lev=rep(-99,length(df$p))

for (i in 1:length(lev)){
  if(df[i,1]==0){lev[i]<-0}
  
  ## recursively finding parents till we reach a case which has no parent
  else{ tree=c()
  kid=i
  parent=-99
  k=1
  tree[k]<-i
  while(df[kid,1]!=0){
    parent=df[kid,1]
    tree[k+1]=parent
    k<-k+1
    kid<-parent}
  lev[i]<-length(tree)-1
  }
}
df<-cbind(df,lev)

## selecting the 'From Maharashtra' cluster
cluster2_index=which(cluster=="Maharashtra")

## Defining groups in the 'From Maharashtra' cluster
cluster2=c()
city=data1$City[cluster2_index]
for (i in 1:length(cluster2_index)){
  cluster2[i]=word(city[i],1)
}
cluster2=factor(cluster2)
df2=data.frame(cluster2,"lev"=lev[cluster2_index])

## label of levels for plotly graph
l=c("parent","child","grandchild","great grandchild","great great grandchild","ggg grandchild","gggg grandchild")
r2=max(df2$lev)

## plotly histogram which has clusters as bins and bars color-coded according to generation
fig<-plot_ly()
for(i in 0:r2){ 
  fig<-fig%>%add_histogram(x=df2[which(df2$lev==i),1],name=l[i+1])
}
fig<-fig%>%layout(barmode="stack",title="Histogram for Cluster: From Maharashtra", titlefont=f,yaxis=list(title="Count",titlefont=f2,tickfont=f2),xaxis=list(tickangle=-45,tickfont=f2))
fig

## saving the graph
save_image(fig, "./plotlyfigures/kahistMah.svg")
name = paste("ka","histMah.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")