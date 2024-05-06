###############################################################
## Title: Days Required for Patient to Recover               ##
## Input: KAhospital.csv                                     ##
## Output: Plot of Days taken to Recover Vs Number           ## 
##         Of patients                                       ##
## Date Modified: 03-05-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly) 

# Reading data of hospitalization status of patients in Karnataka
KAhospital = read.csv("../Data/KAhospital.csv",header=TRUE)

# Creating dataframe of days taken to recover 
df_c=data.frame()
for(i in KAhospital$Case){
  col = KAhospital[i,]
  if (length(which(col == "C")) >0){
    df_c=rbind(df_c,KAhospital[i,])
  }else{next}
}
dtc = rep(0,length(df_c$Case))
for(i in 1:length(df_c$Case)){
  col = df_c[i,]
  col<- col[3:length(col)]
  start = min(which(as.character(col)!="NA"))
  end =min(which(col == "C"))
  dtc[i] = (end-start)
}
DTC = data.frame(Days = dtc)

# Histogram using ggplot with mean line plotted
g=ggplot(DTC,aes(x=Days))+geom_histogram(binwidth=1,fill="aquamarine3")+labs(x="Number of days taken to recover",y="Number of Patients")+ggtitle("Distribution of number of days taken by patients to recover")
g=g+geom_vline(xintercept=mean(dtc),linetype="dashed",color="blue")+scale_x_continuous(breaks = seq(min(dtc),max(dtc),by=2))

# Saving output as .png
name1 = paste("days","tocure.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)

# Converting plot to plotly
dcgp = ggplotly(g)

# Saving output as .html
name = paste("days","tocure.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(dcgp, file=path, selfcontained = FALSE, libdir = "plotly.html")
