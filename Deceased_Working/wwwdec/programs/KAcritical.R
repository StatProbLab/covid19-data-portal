###############################################################################
## Title: Active cases in karnataka                                          ##
## Input: mediadata/kaHospSrinidi.xlsx                                       ##
## Output: csv/critical/KA-daystocritical.csv                                ##
## Date Modified: 21st May 2024                                              ##
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

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

##Read data
data <- read_excel("mediadata/kaHospSrinidi.xlsx")

##Formatting data
names(data) = c("Date", "totalActiveWithoutICU", "totalDischarged", "totalDeceased", "totalICU")

data$Date <- as.Date(data$Date, format = "%d-%m-%Y")

for(i in seq(length(data$totalICU)))
{
  if(is.na(data$totalICU[i]))
  {
    data$totalICU[i] = 0
  }
}

##Creating total active cases
data$totalActive = data$totalActiveWithoutICU + data$totalICU
df=data[,c(1,6)]

Target_1<- rep("3538",length(nrow(df)))
df$Target_1 <-Target_1

Target_2<- rep("70774",length(nrow(df)))
df$Target_2 <-Target_2

Target_3<- rep("106161",length(nrow(df)))
df$Target_3 <-Target_3

Target_4<- rep("141548",length(nrow(df)))
df$Target_4 <-Target_4

Population<- rep("70774116",length(nrow(df)))
df$Population <-Population




#adding the lamda(t) column
df_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),Target_1=double(),Target_2=double(),Target_3=double(),Target_4=double(),Population=double())
for (i in seq(unique(nrow(df)))) 
{
  m1 <-df$totalActive[i+7]
  m2=(1/10+((df$totalActive[i+7]-df$totalActive[i])/(7*(df$totalActive[i+7]))))
  m3=((df$totalActive[i+7]-df$totalActive[i])/(7*(df$totalActive[i+7])))
  m4=df$Date[i+7]
  m5=df$Target_1[1]
  m6=df$Target_2[1]
  m7=df$Target_3[1]
  m8=df$Target_4[1]
  m9=df$Population[1]
  temp<- data.frame(i,m4,m1,m2,m3,m5,m6,m7,m8,m9)
  df_new<- rbind(df_new,temp)
}

names(df_new) <- c("No.","Date","Total Active","Rate","Rate-mu","Target_1","Target_2","Target_3","Target_4","Population")
month_wise<-data.frame((format(df_new$Date,"%Y-%m")),df_new)
names(month_wise) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","Target_1","Target_2","Target_3","Target_4","Population")
month_wise=na.omit(month_wise)


####now we predict for future times
#future prediction
df_a=subset(month_wise,month_wise$Date>as.Date.character(month_wise[nrow(month_wise),3]-7)&month_wise$Date<as.Date.character(month_wise[nrow(month_wise),3]+20))
#estimate lamda(t)
df_l<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),Target_1=double(),Target_2=double(),Target_3=double(),Target_4=double(),Population=double())
for (i in seq(unique(nrow(df_a)))) 
{ 
  m1=df_a$Date[i+4] 
  m2=df_a$`Total Active`[i+4]
  m3=df_a$Rate[i+4]
  m4=df_a$`Rate-mu`[i+4]
  m5=(df_a$Rate[i]+df_a$Rate[i+1]+df_a$Rate[i+2]+df_a$Rate[i+3])/4
  m6=df_a$Target_1[1]
  m7=df_a$Target_2[1]
  m8=df_a$Target_3[1]
  m9=df_a$Target_4[1]
  m10=df_a$Population[1]
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10)
  df_l<- rbind(df_l,temp)
}
names(df_l) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Target_1","Target_2","Target_3","Target_4","Population")
df_l=na.omit(df_l)

df_l_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double(),Target_1=double(),Target_2=double(),Target_3=double(),Target_4=double(),Population=double())
for (i in seq(unique(nrow(df_l)))) 
{ 
  m1=df_l$Date[i+1] 
  m2=df_l$`Total Active`[i+1]
  m3=df_l$Rate[i+1]
  m4=df_l$`Rate-mu`[i+1]
  m5=df_l$categ[i+1]
  m6=(df_l$`Total Active`[i])*(1+(df_l$categ[1]-0.1))
  m7=df_l$Target_1[1]
  m8=df_l$Target_2[1]
  m9=df_l$Target_3[1]
  m10=df_l$Target_4[1]
  m11=df_l$Population[1]
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11)
  df_l_new<- rbind(df_l_new,temp)
}

names(df_l_new) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases","Target_1","Target_2","Target_3","Target_4","Population")
df_l_new=na.omit(df_l_new)


df_l_new[nrow(df_l_new)+1000,] <- NA

for(p in seq(unique(nrow(df_l_new))))
{
  if (p == 1)
    df_l_new$No.[p]=(df_l_new$No.[1])
  if(p>1)
    df_l_new$No.[p]=(df_l_new$No.[p-1])+1
}


for(t in seq(unique(nrow(df_l_new))))
{
  if (t == 1)
    df_l_new$Date[t]=as.Date.character(df_l_new$Date[1])
  if(t>1)
    df_l_new$Date[t]=as.Date.character(df_l_new$Date[t-1])+1
} 


for(i in seq(unique(nrow(df_l_new))))
{
  if (i == 1)
    df_l_new$model[i]=df_l_new$Predicted_Active_Cases[1]
  if(i>1)
    df_l_new$model[i]<-df_l_new$model[i-1]*(1+(df_l_new$categ[2]-0.1))
}

df_l_new$model=floor(df_l_new$model)

df_l_month<-data.frame((format(df_l_new$Date,"%Y-%m")),df_l_new)
names(df_l_month) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","Target_1","Target_2","Target_3","Target_4","Population","model_generated")

x1=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_1[1]))
x2=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_2[1]))
x3=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_3[1]))
x4=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_4[1]))

y=c(x1[1,1],x2[1,1],x3[1,1],x4[1,1])


df_days<- data.frame(Date=character(),Total_Active = double(),Rate=double(),categ=double(),Days_Target_1=double(),Days_Target_2=double(),Days_Target_3=double(),Days_Target_4=double(),Population=double())
m1=df_l_month$Date[2]
m2=df_l$`Total Active`[2]
m4=df_l$categ[2]
m5=y[1]
m6=y[2]
m7=y[3]
m8=y[4]
m9=df_l$Population[2]
temp<- data.frame(m1,m2,m4,m5,m6,m7,m8,m9)
df_days<- rbind(df_days,temp)

names(df_days) <- c("Date","Current Active Cases","Rate(lamda-t)","Days to 50 per million cases","Days to 1000 per million cases","Days to 1500 per million cases","Days to 0.2% of population cases","Population")
df_days[is.na(df_days)]<-"---"  

District<- rep("Karnataka",length(nrow(df_days)))
df_days$District <-District

df_days=df_days[,c(9,8,1,2,3,4,5,6,7)]


#Writing district data
my_name_1 <- paste("KA-daystocritical",sep="-")
my_name_2 <- paste(my_name_1,"csv",sep=".")
my_name <- paste0("csv/critical/", my_name_2)
write.csv(df_days, file = my_name, row.names=FALSE)



