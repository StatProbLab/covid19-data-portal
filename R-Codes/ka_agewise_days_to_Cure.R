###############################################################
## Title: Age of Patient vs Days taken to Recover            ##
## Input: KAhospital.csv and KAtrace26June.csv               ##
## Output: Plot of Age Vs Days taken to Recover              ##
## Date Modified: 03-05-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly)
library(viridis)

# Reading data of hospitalization status of patients in Karnataka and list of Patients and their information
KAhospital = read.csv("../Data/KAhospital.csv",header=TRUE)
KAtrace = read.csv("../Data/KAtrace26June.csv",header=TRUE)

# Creating vector with days taken to recover 
df_c=data.frame()
for(i in KAhospital$Case){
  col = KAhospital[i,]
  if (length(which(col == "C")) >0){
    df_c=rbind(df_c,KAhospital[i,])
  }else{next}
}
Case_c = df_c$Case
dtc = rep(0,length(df_c$Case))
for(i in 1:length(df_c$Case)){
  col = df_c[i,]
  Case = col[1]
  col<- col[3:length(col)]
  start = min(which(as.character(col)!="NA"))
  end =min(which(col == "C"))
  dtc[i] = (end-start)
}
trace_c = KAtrace[which(KAtrace$Case %in% Case_c),]
Case= trace_c$Case
Age = trace_c$Age
Sex = trace_c$Sex
City= trace_c$City
Cluster = trace_c$Cluster
P = trace_c$P

# Creating a separation between individuals with SARI and those who contracted the infection from a SARI Patient
Cluster <- factor(Cluster, levels = c( "Severe Acute Respiratory Infection Patient", levels(Cluster), "Contracted the infection from a SARI patient"))
for(i in 1:length(Case)){
  if(Cluster[i] == "Severe Acute Respiratory Infection"){
    if(P[i]>0){Cluster[i] = "Contracted the infection from a SARI patient"}
    if(P[i]==0){Cluster[i] = "Severe Acute Respiratory Infection Patient"}
  }
}
C = data.frame(Case, Age = as.numeric(Age), Days_to_Recover = dtc, Cluster, Sex, City )
C<- subset(C,Age>0)

# Scatterplot using ggplot
g=ggplot(C,aes(x=Days_to_Recover, y=Age, color = Cluster,label1 = Age, label2 = Sex, label3 = City))+geom_point(size=1) +scale_color_viridis(discrete = TRUE, option = "D")+labs(x = "Days taken to recover")

# Saving output as .png
name1 = paste("age","dtc.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)

# Converting to a Plotly graph
pagedtc = ggplotly(g,tooltip=c("x", "color","label1","label2","label3"))

# Saving output as .html
name = paste("age","dtc.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(pagedtc, file=path, selfcontained = FALSE, libdir = "plotly.html")
