###############################################################
## Title: Histogram of the Clusters in Karnataka             ##
## Input: KAtrace26June.csv                                  ##
## Output: Plot of Cluster Vs Counts                         ##
## Date Modified: 02-05-2024                                 ##
###############################################################

## Required Libraries
library(plotly)

data1=read.csv("../Data/KAtrace26June.csv")
##note that this code only works with the KAtrace version that was not updated after 26 June

## variables to store custom fonts
f <- list(family = "serif", size = 17, color = 'maroon',face="bold")
f2<- list(family = "serif", size = 13, color = 'black')

## defining the clusters and assigning cluster to each case
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
cluster=factor(cluster,labels=c("Middle East","South America","Rest of Europe","United Kingdom","USA","Pharmaceutical in Nanjangud","TJ Congregation","Maharashtra","Rajasthan","Gujarat","Southern States","ILI","SARI","Containment Zones","Others","Unknown"))

## finding the generation of each case and storing in data frame
df=data.frame("p"=data1[,11])
df$p<-replace(df$p,is.na(df$p),0)
lev=rep(-99,length(df$p))
for (i in 1:length(lev)){
  if(df[i,1]==0){
    lev[i]<-0
  }
  
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

## Remove 'From Maharashtra' cluster.
cluster2_index=which(cluster=="Maharashtra")
temp=1:length(cluster)
cluster1_index=temp[-cluster2_index]
cluster1=cluster[cluster1_index]
cluster1=factor(cluster1)
df1=data.frame(cluster1,"lev"=lev[cluster1_index])

## label of levels for plotly graph.
l=c("parent","child","grandchild","great grandchild","great great grandchild","ggg grandchild","gggg grandchild")
r=max(lev)

## plotly histogram which has clusters as bins and bars color-coded according to generation
fig<-plot_ly()
for(i in 0:r){
  fig<-fig%>%add_histogram(x=df1[which(df1$lev==i),1],name=l[i+1])
}
fig<-fig%>%layout(barmode="stack",title="Histogram for Clusters: Set I", titlefont=f,yaxis=list(title="Count",titlefont=f2,tickfont=f2),xaxis=list(tickangle=-45,tickfont=f2))
fig

##saving the graph
save_image(fig, "./plotlyfigures/kahist1.svg")
name = paste("ka","hist1.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")
