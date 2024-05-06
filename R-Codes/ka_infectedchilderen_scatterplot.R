###############################################################
## Title: Number of Children produced                        ##
##        by the cases in Karnataka                          ##
## Input: KAtrace26June.csv                                  ##
## Output: Plot of Number of Cases Vs Number of Childeren    ##
## Date Modified: 04-05-2024                                 ##
###############################################################

## required libraries
library(plotly)

data1=read.csv("../Data/KAtrace26June.csv") ##note that this code only works with the KAtrace version that was not updated after 26 June

## variables to store custom fonts
f <- list(family = "serif", size = 17, color = 'maroon',face="bold")
f2<- list(family = "serif", size = 13, color = 'black')

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

## preparing data frame that contains the cluster and parent of each case
df=data.frame("cluster"=cluster,"p"=data1[,11])
df$p<-replace(df$p,is.na(df$p),0)
lev=rep(-99,length(df$p))

## finding the generation (level of the node in the tree) for each case and storing them in data frame
for (i in 1:length(lev)){
  if(df[i,2]==0){lev[i]<-0}
  else{lev[i]<-1+lev[df[i,2]] 
  }
}
df<-cbind(df,lev)

## labels for the levels of node
l=c("parent","child","grandchild","great grandchild","great great grandchild","ggg grandchild")
r=max(lev)

## finding the number of children produced by each case
child_cnt=rep(0,length(lev))
for(i in 1:length(child_cnt)){
  if(df$p[i] !=0){child_cnt[df$p[i]]<-child_cnt[df$p[i]]+1
  }
}

## plotly scatterplot for the number of children
t=as.data.frame(table(child_cnt))
fig3 <- plot_ly(t, x = ~Freq, y = ~child_cnt, type="scatter" ,mode = 'markers',hoverinfo = 'text', text = ~paste('</br> Number of children: ',child_cnt,'</br> Number of Cases: ', Freq))
fig3 <-fig3  %>%layout(title='Distribution of Children',titlefont=f,yaxis=list(title='Number of Children',titlefont=f2,zeroline=F,tickvals=seq(0,round(max(child_cnt),-1)+5,by=5)),xaxis=list(title='Number of Cases with y-many children',titlefont=f2,zeroline=F,showline=T,tickvals=c(1,seq(1000,max(t$Freq),by=1000))))
fig3

## saving the graph
save_image(fig3, "./plotlyfigures/ka-childa.svg")
name = paste("ka","childa.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig3, file=path, selfcontained = FALSE, libdir = "plotly.html")