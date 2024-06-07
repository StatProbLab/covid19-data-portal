############################################################
## Title: Satetwise Infected Recovered and Deceased Cases ##
##        of Coronavirus in India                         ##
## Input: IRDD_allindia.csv                               ##  
## Output: Plot of Date Vs Number of Cases                ##
## Date Modified: 26-04-2024                              ##
############################################################

# Libraries Required
library(tidyverse)
library(tidyr)
library(ggplot2)
library(plotly) 

allindia = read.csv("./Data/IRDD_allindia.csv")
state_names = unique(allindia$State)

infdedrec = function(i){

  #Data frame for Active, Recovered and Deceased
  state_name = state_names[i]
  df_s = filter(allindia,State==state_name) |> mutate(Active=Infected-Recovered-Deceased)
  
  df_a = df_s[,c(1,6)]
  colnames(df_a)[2] = 'Count'
  df_a$Condition = 'Active'
  
  df_r = df_s[,c(1,4)]
  colnames(df_r)[2] = 'Count'
  df_r$Condition = 'Recovered'
  
  df_d = df_s[,c(1,5)]
  colnames(df_d)[2] = 'Count'
  df_d$Condition = 'Deceased'
  
  df = rbind(df_a,df_r,df_d)
  df$Date = format(as.Date(df$Date,"%d-%m-%Y"),"%d-%b-%y")
   # Determines the order in which the area chart is plotted
  df$Condition <- factor(df$Condition ,levels = c("Active","Recovered","Deceased"))
  # Ensures that the order of the dates on the x-axis is correct.
  df$Date<- factor(df$Date,levels=unique(df$Date))
  # Stacked area plot using ggplot
  sirdg = ggplot(df,aes(x=Date,y=Count,group=Condition,fill=Condition))+
          geom_area(position="stack")+
          scale_fill_manual(breaks = c("Active","Recovered","Deceased"), values=c("orange", "green", "darkred"))+ 
          theme_minimal()+
          theme(axis.text.x = element_text(angle = 45, hjust = 1))+
          ggtitle(as.character(unlist(state_name,use.names=FALSE)))+
          labs(y=" ", x = " ")+ 
          theme(legend.title = element_blank())+
          theme(axis.ticks = element_blank())+ 
          theme(plot.title = element_text(hjust = 0.5))+
          scale_x_discrete(breaks = unique(df$Date)[c(T,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F)])
          
  sirdg
}

#Each state graph is saved as a .html and .png
for(i in 1:37){
  sirdgp =  ggplotly(infdedrec(i),tooltip=c("x","y","group"))
  name = paste(i,"sirdg.html", sep="-")
  path <- file.path(getwd(), "plotlyfigures", name)
  htmlwidgets::saveWidget(sirdgp, file=path, selfcontained = FALSE, libdir =  "plotly.html")
  
  # Saving Output as .png
  name1 = paste(i,"sirdg.png", sep="-")
  name2 = paste0("./plotlyfigures/", name1)
  ggsave(name2)
}

