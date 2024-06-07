###############################################################
## Title: Number of days ICU is required                     ##
## Input: KAhospital.csv                                     ##
## Output: Plot of Days ICU is required Vs Number            ## 
##         Of patients                                       ##
## Date Modified: 03-05-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly) 

# Reading data of hospitalization status of patients in Karnataka
KAhospital = read.csv("../Data/KAhospital.csv",header=TRUE)

# Extract rows for which patient has been in ICU
df_icu=data.frame()
for(i in KAhospital$Case){
  col = KAhospital[i,]
  a=length(which(col == "ICUV"))
  b=length(which(col == "ICUO"))
  c=length(which(col == "ICU"))
  if (a+b+c >0){
    df_icu=rbind(df_icu,KAhospital[i,])
  }else{next}
}

# To find the number of days they were in ICU/on ventilator/oxygen and create dataframe
diicu = rep(0,length(df_icu$Case))
for(i in 1:length(df_icu$Case)){
  col = df_icu[i,]
  col<- col[3:length(col)]
  start = 100000000000
  if(length(which(col == "ICU") )>0){start=min(which(col == "ICU"))}
  if(length(which(col == "ICUV") )>0){start=min(start,which(col == "ICUV"))}
  if(length(which(col == "ICUO") )>0){start=min(start,which(col == "ICUO"))}
  end= 0
  if(length(which(col == "ICU") )>0){end=max(which(col == "ICU"))}
  if(length(which(col == "ICUV") )>0){end=max(end,which(col == "ICUV"))}
  if(length(which(col == "ICUO") )>0){end=max(end,which(col == "ICUO"))}
  diicu[i] = (end-start+1)
}
DIICU = data.frame(days=diicu)

# Histogram using ggplot
diig=ggplot(DIICU,aes(x=days))+geom_histogram(binwidth=1,fill="slateblue")+labs(x="Days spent in ICU",y="Number of Patients")+scale_x_continuous(breaks = seq(min(diicu),max(diicu),by=2))+ggtitle("Distribution of days spent in ICU")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+ theme(plot.title = element_text(hjust = 0.5))

# Saving output as .png
name1 = paste("days","inICU.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=diig)

#  Converting to a plotly graph
diigp=ggplotly(diig)

# Saving output as .html
name = paste("days","inICU.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(diigp, file=path, selfcontained = FALSE, libdir = "plotly.html")
