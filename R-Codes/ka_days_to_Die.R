###############################################################
## Title: Days Taken for Deceased Individual between test    ##
##        positive and death                                 ##
## Input: KAhospital.csv                                     ##
## Output: Plot of Days taken between test positive and death##
##         Vs Number Of patients                             ##
## Date Modified: 03-05-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly) 

# Reading data of hospitalization status of patients in Karnataka
KAhospital = read.csv("../Data/KAhospital.csv",header=TRUE)

# Creating dataframe of days taken to deceased 
df_d=data.frame()
for(i in KAhospital$Case){
  col = KAhospital[i,]
  if (length(which(col == "D")) >0){
    df_d=rbind(df_d,KAhospital[i,])
  }else{next}
}
dtd = rep(0,length(df_d$Case))
for(i in 1:length(df_d$Case)){
  col = df_d[i,]
  col<- col[3:length(col)]
  start = min(which(as.character(col)!="NA"))
  end =min(which(col == "D"))
  dtd[i] = (end-start)
}
DTD = data.frame(Days = dtd)

# Histogram using ggplot with mean line plotted
g=ggplot(DTD,aes(x=Days))+geom_histogram(binwidth=1,fill="darkcyan")+labs(x="Number of Days between test positive and death",y="Number of Patients")+ggtitle("Distribution of number of days between testing positive and passing of patient")+scale_x_continuous(breaks = seq(min(dtd),max(dtd),by=1))

# Saving output as .png
name1 = paste("days","todie.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)

# Converting to a Plotly graph
ddgp = ggplotly(g)

# Saving output as .html
name = paste("days","todie.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(ddgp, file=path, selfcontained = FALSE, libdir = "plotly.html")
