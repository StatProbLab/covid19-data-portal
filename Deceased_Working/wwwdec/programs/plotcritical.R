###############################################################################
## Title: Predicting and Visualizing Critical Cases in Karnataka Districts   ##
## Input: distcasfat.xlsx                                                    ##
## Output: csv/critical.csv                                                  ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################

#include Libraries
library(readxl)
library(readr)
library(ggplot2)
library(plotly)
library(readxl)
library(gridExtra)
library(grid)
library(dplyr)
library(lubridate)
library(viridis)
library(ggpubr)
library(padr)
library(tidyverse)
library(maps)
library(mapproj)

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")


###
#Read population
pop<- read_excel("distcasfat.xlsx")
pop1=pop[c(1:31),2]
pop2=pop[c(1:31),c(5,6,7,8)]

#Read all data
df1<- read_csv("csv/critical/1-daystocritical.csv")
df2<- read_csv("csv/critical/2-daystocritical.csv")
df3<- read_csv("csv/critical/3-daystocritical.csv")
df4<- read_csv("csv/critical/4-daystocritical.csv")
df5<- read_csv("csv/critical/5-daystocritical.csv")
df6<- read_csv("csv/critical/6-daystocritical.csv")
df7<- read_csv("csv/critical/7-daystocritical.csv")
df8<- read_csv("csv/critical/8-daystocritical.csv")
df9<- read_csv("csv/critical/9-daystocritical.csv")
df10<- read_csv("csv/critical/10-daystocritical.csv")
df11<- read_csv("csv/critical/11-daystocritical.csv")
df12<- read_csv("csv/critical/12-daystocritical.csv")
df13<- read_csv("csv/critical/13-daystocritical.csv")
df14<- read_csv("csv/critical/14-daystocritical.csv")
df15<- read_csv("csv/critical/15-daystocritical.csv")
df16<- read_csv("csv/critical/16-daystocritical.csv")
df17<- read_csv("csv/critical/17-daystocritical.csv")
df18<- read_csv("csv/critical/18-daystocritical.csv")
df19<- read_csv("csv/critical/19-daystocritical.csv")
df20<- read_csv("csv/critical/20-daystocritical.csv")
df21<- read_csv("csv/critical/21-daystocritical.csv")
df22<- read_csv("csv/critical/22-daystocritical.csv")
df23<- read_csv("csv/critical/23-daystocritical.csv")
df24<- read_csv("csv/critical/24-daystocritical.csv")
df25<- read_csv("csv/critical/25-daystocritical.csv")
df26<- read_csv("csv/critical/26-daystocritical.csv")
df27<- read_csv("csv/critical/27-daystocritical.csv")
df28<- read_csv("csv/critical/28-daystocritical.csv")
df29<- read_csv("csv/critical/29-daystocritical.csv")
df30<- read_csv("csv/critical/30-daystocritical.csv")
df31<- read_csv("csv/critical/KA-daystocritical.csv")

df_pre=rbind(df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12,df13,df14,df15,df16,df17,df18,df19,df20,df21,df22,df23,df24,df25,df26,df27,df28,df29,df30,df31)
df=cbind(df_pre,pop1,pop2)

df=df[,c(1,3,4,5,6,7,8,9,10,2,11,12,13,14)]

names(df) <- c("District","Date","Current Active Cases","Growth Rate(lamda-t)","Days to 50 Active cases per million population","Days to 1000 Active cases per million population","Days to 1500 Active cases per million population","Days to 0.2% of population Active cases","Population as on 2011","Projected Population-2020 ","Population-50 per million","Population-1000 per million","Population-1500 per million","0.2% of population")


#df_dist=df[-c(31),]

#df_high=subset(df_dist,df_dist$`Rate(lamda-t)`>0.10 & df_dist$`Days to 50 per million cases`=="1")
#Alarm<- rep("High",length(nrow(df_high)))
#df_high$Alarm <-Alarm

#df_medium=subset(df_dist,df_dist$`Rate(lamda-t)`<0.10 & df_dist$`Days to 50 per million cases`>="1")
#Alarm<- rep("Medium",length(nrow(df_medium)))
#df_medium$Alarm <-Alarm

#df_low=subset(df_dist,df_dist$`Rate(lamda-t)`<0.10 & df_dist$`Days to 50 per million cases`=="---")
#Alarm<- rep("Low",length(nrow(df_low)))
#df_low$Alarm <-Alarm

#df_dist_final=rbind(df_high,df_medium,df_low)



###save
write.csv(x=df,file="csv/critical.csv",row.names = FALSE)

###try to put alarm in map




