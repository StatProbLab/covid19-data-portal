###############################################################
## Title: Age of Patient vs Days taken to Deceased           ##
## Input: KAhospital.csv and KAtrace26June.csv               ##
## Output: Plot of Age Vs Days taken to Deceased             ##
## Date Modified: 03-05-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly)
library(viridis)

# Reading data of hospitalization status of patients in Karnataka and list of Patients and their information
KAhospital = read.csv("../Data/KAhospital.csv",header=TRUE)
KAtrace = read.csv("../Data/KAtrace26June.csv",header=TRUE)

# Creating vector with days taken between test positive and death
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
  Case = col[1]
  col<- col[3:length(col)]
  start = min(which(as.character(col)!="NA"))
  end =min(which(col == "D"))
  dtd[i] = (end-start)
}
Case_d = df_d$Case
trace_d = KAtrace[which(KAtrace$Case %in% Case_d),]
Case= trace_d$Case
Age = trace_d$Age
Sex = trace_d$Sex
City= trace_d$City
Cluster = trace_d$Cluster
P = trace_d$P

# Creating a separation between individuals with SARI and those who contracted the infection from a SARI Patient
Cluster <- factor(Cluster, levels = c( "Severe Acute Respiratory Infection Patient", levels(Cluster), "Contracted the infection from a SARI patient"))
for(i in 1:length(Case)){
  if(Cluster[i] == "Severe Acute Respiratory Infection"){
    if(P[i]>0){Cluster[i] = "Contracted the infection from a SARI patient"}
    if(P[i]==0){Cluster[i] = "Severe Acute Respiratory Infection Patient"}
  }
}
D = data.frame(Case, Age = as.numeric(Age), Days_to_die = dtd, Cluster, Sex, City )
D<- subset(D,Age>1)

# Scatterplot using ggplot and converting to a plotly graph
g=ggplot(D,aes(x=Days_to_die, y=Age, color = Cluster,label1 = Age, label2 = Sex, label3 = City))+geom_point(size=1) +scale_color_viridis(discrete = TRUE, option = "C")+labs(x = "Days taken to succumb to the infection")
pagedtd = ggplotly(g,tooltip=c("x", "color","label1","label2","label3"))

# Saving output as .png
name1 = paste("age","dtd.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)

# Saving output as .html
name = paste("age","dtd.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(pagedtd, file=path, selfcontained = FALSE, libdir = "plotly.html")
