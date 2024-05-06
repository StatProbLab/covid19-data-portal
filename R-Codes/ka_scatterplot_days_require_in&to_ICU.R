###############################################################
## Title: Scatter plot of Days in and to ICU                 ##
## Input: KAhospital.csv and KAtrace.csv                     ##
## Output: Plot of Days Spent in ICU Vs Days Infected        ##
##         but not requiring ICU                             ##
## Date Modified: 04-05-2024                                 ##
###############################################################

library(ggplot2)
library(plotly)

KAhospital = read.csv("../Data/KAhospital.csv",header=TRUE)
KAtrace = read.csv("../Data/KAtrace.csv",header=TRUE)

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

dticu = rep(0,length(df_icu$Case))

for(i in 1:length(df_icu$Case)){
  col = df_icu[i,]
  col<- (col[3:length(col)])
  start = min(which(as.character(col)!="NA"))
  end=100000000000000
  if(length(which(col == "ICU") )>0){end=min(which(col == "ICU"))}
  if(length(which(col == "ICUV") )>0){end=min(end,which(col == "ICUV"))}
  if(length(which(col == "ICUO") )>0){end=min(end,which(col == "ICUO"))}
  
  dticu[i] = (end-start)
}
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

n= length(names(df_icu))
now = as.character(df_icu[,n])
now = replace(now, now == "H", "Hospitalized")
now = replace(now, now == "C", "Recovered")
now = replace(now, now == "D", "Deceased")
now = replace(now, now == "ICUV", "On a Ventilator")
now = replace(now, now == "ICU", "In ICU")
now = replace(now, now == "ICUO", "In ICU - On Oxygen")

Case = df_icu$Case

icutrace = KAtrace[which(KAtrace$Case %in% Case),]

Age = icutrace$Age
Sex = icutrace$Sex
City = icutrace$City
Cluster = icutrace$Cluster

P = icutrace$P

levels(Cluster) <- c(levels(Cluster), "Contracted the infection from a SARI patient", "Severe Acute Respiratory Infection Patient" )

for(i in 1:length(Case)){
  if(Cluster[i] == "Severe Acute Respiratory Infection"){
    if(P[i]>0){Cluster[i] = "Contracted the infection from a SARI patient"}
    if(P[i]==0){Cluster[i] = "Severe Acute Respiratory Infection Patient"}
  }
}

df = data.frame(Case, Days_in_ICU = diicu, Days_to_ICU = dticu, Age, Sex, Cluster, City, Current_Condition = now)

g=ggplot(df,aes(x=Days_in_ICU, y=Days_to_ICU, color = Current_Condition, label1= Age, label2 = Sex, label3=City, label4 = Cluster))+geom_point(size=2)+labs(color = "Current Condition", x="Days spent in ICU (so far)", y = "Days infected but not requiring ICU")
g

name1 = paste("dticu","diicu.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)
dtvsdi = ggplotly(g, tooltip = c("x","y","color","label1","label2","label3", "label4"))


name = paste("dticu","diicu.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(dtvsdi, file=path, selfcontained = FALSE, libdir = "plotly.html")