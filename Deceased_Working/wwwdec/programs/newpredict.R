###############################################################################
## Title: historical data on active COVID-19 cases in Karnataka              ##
## Input: mediadata/kaHospSrinidi.xlsx                                       ##
## Output: Plots                                                             ##
## Date Modified: 21st May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

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

#adding the lamda(t) column
df_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double())
for (i in seq(unique(nrow(df)))) 
{
  m1 <-df$totalActive[i+7]
  m2=(1/10+((df$totalActive[i+7]-df$totalActive[i])/(7*(df$totalActive[i+7]))))
  m3=((df$totalActive[i+7]-df$totalActive[i])/(7*(df$totalActive[i+7])))
  m4=df$Date[i+7]
  temp<- data.frame(i,m4,m1,m2,m3)
  df_new<- rbind(df_new,temp)
}

names(df_new) <- c("No.","Date","Total Active","Rate","Rate-mu")
month_wise<-data.frame((format(df_new$Date,"%Y-%m")),df_new)
names(month_wise) <- c("Month","No.","Date","Total Active","Rate","Rate-mu")
month_wise=na.omit(month_wise)



date_need=subset(month_wise,month_wise$Rate>0.10)

for(i in seq(unique(nrow(date_need))))
{
  if (i == 1)
    date_need$diff[i]=0
  if(i>1)
    date_need$diff[i]=difftime(date_need$Date[i],date_need$Date[i-1])
}  
  
date_need1=subset(date_need,date_need$diff>10)

#prediction date=1
df_h=subset(month_wise,month_wise$Date>as.Date.character(date_need1[1,3]-6)&month_wise$Date<as.Date.character(date_need1[1,3]+20))
#estimate lamda(t)
df_f<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
for (i in seq(unique(nrow(df_h)))) 
{ 
  m1=df_h$Date[i+4] 
  m2=df_h$`Total Active`[i+4]
  m3=df_h$Rate[i+4]
  m4=df_h$`Rate-mu`[i+4]
  m5=(df_h$Rate[i]+df_h$Rate[i+1]+df_h$Rate[i+2]+df_h$Rate[i+3])/4
  temp<- data.frame(i,m1,m2,m3,m4,m5)
  df_f<- rbind(df_f,temp)
}
names(df_f) <- c("No.","Date","Total Active","Rate","Rate-mu","categ")
df_f=na.omit(df_f)

df_f_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
for (i in seq(unique(nrow(df_f)))) 
{ 
  m1=df_f$Date[i+1] 
  m2=df_f$`Total Active`[i+1]
  m3=df_f$Rate[i+1]
  m4=df_f$`Rate-mu`[i+1]
  m5=df_f$categ[i+1]
  m6=(df_f$`Total Active`[i])*(1+(df_f$categ[1]-0.1))
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6)
  df_f_new<- rbind(df_f_new,temp)
}

names(df_f_new) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
df_f_new=na.omit(df_f_new)


for(i in seq(unique(nrow(df_f_new))))
{
  if (i == 1)
    df_f_new$model[i]=df_f_new$Predicted_Active_Cases[1]
  if(i>1)
    df_f_new$model[i]<-df_f_new$model[i-1]*(1+(df_f_new$categ[2]-0.1))
}

df_f_new$model=floor(df_f_new$model)

df_f_month<-data.frame((format(df_f_new$Date,"%Y-%m")),df_f_new)
names(df_f_month) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")


#prediction date=2 #########
df_h1=subset(month_wise,month_wise$Date>="2020-05-05"&month_wise$Date<"2020-06-10")
#estimate lamda(t)
df_f1<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
for (i in seq(unique(nrow(df_h1)))) 
{ 
  m1=df_h1$Date[i+4] 
  m2=df_h1$`Total Active`[i+4]
  m3=df_h1$Rate[i+4]
  m4=df_h1$`Rate-mu`[i+4]
  m5=(df_h1$Rate[i]+df_h1$Rate[i+1]+df_h1$Rate[i+2]+df_h1$Rate[i+3])/4
  temp<- data.frame(i,m1,m2,m3,m4,m5)
  df_f1<- rbind(df_f1,temp)
}

names(df_f1) <- c("No.","Date","Total Active","Rate","Rate-mu","categ")
df_f1=na.omit(df_f1)

df_f1_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
for (i in seq(unique(nrow(df_f1)))) 
{ 
  m1=df_f1$Date[i+1] 
  m2=df_f1$`Total Active`[i+1]
  m3=df_f1$Rate[i+1]
  m4=df_f1$`Rate-mu`[i+1]
  m5=df_f1$categ[i+1]
  m6=(df_f1$`Total Active`[i])*(1+(df_f1$categ[1]-0.1))
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6)
  df_f1_new<- rbind(df_f1_new,temp)
}

names(df_f1_new) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
df_f1_new=na.omit(df_f1_new)

for(i in seq(unique(nrow(df_f1_new))))
{
  if (i == 1)
    df_f1_new$model[i]=df_f1_new$Predicted_Active_Cases[1]
  if(i>1)
    df_f1_new$model[i]<-df_f1_new$model[i-1]*(1+(df_f1_new$categ[2]-0.1))
}

df_f1_new$model=floor(df_f1_new$model)


df_f1_month<-data.frame((format(df_f1_new$Date,"%Y-%m")),df_f1_new)
names(df_f1_month) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")

#prediction date=3
df_h2=subset(month_wise,month_wise$Date>="2020-06-20"&month_wise$Date<"2020-08-10")
#estimate lamda(t)
df_f2<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
for (i in seq(unique(nrow(df_h2)))) 
{ 
  m1=df_h2$Date[i+4] 
  m2=df_h2$`Total Active`[i+4]
  m3=df_h2$Rate[i+4]
  m4=df_h2$`Rate-mu`[i+4]
  m5=(df_h2$Rate[i]+df_h2$Rate[i+1]+df_h2$Rate[i+2]+df_h2$Rate[i+3])/4
  temp<- data.frame(i,m1,m2,m3,m4,m5)
  df_f2<- rbind(df_f2,temp)
}

names(df_f2) <- c("No.","Date","Total Active","Rate","Rate-mu","categ")
df_f2=na.omit(df_f2)

df_f2_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
for (i in seq(unique(nrow(df_f2)))) 
{ 
  m1=df_f2$Date[i+1] 
  m2=df_f2$`Total Active`[i+1]
  m3=df_f2$Rate[i+1]
  m4=df_f2$`Rate-mu`[i+1]
  m5=df_f2$categ[i+1]
  m6=(df_f2$`Total Active`[i])*(1+(df_f2$categ[1]-0.1))
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6)
  df_f2_new<- rbind(df_f2_new,temp)
}

names(df_f2_new) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
df_f2_new=na.omit(df_f2_new)

for(i in seq(unique(nrow(df_f2_new))))
{
  if (i == 1)
    df_f2_new$model[i]=df_f2_new$Predicted_Active_Cases[1]
  if(i>1)
    df_f2_new$model[i]<-df_f2_new$model[i-1]*(1+(df_f2_new$categ[2]-0.1))
}

df_f2_new$model=floor(df_f2_new$model)


df_f2_month<-data.frame((format(df_f2_new$Date,"%Y-%m")),df_f2_new)
names(df_f2_month) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")

#prediction date=4
df_h3=subset(month_wise,month_wise$Date>="2021-02-25"&month_wise$Date<"2021-05-10")
#estimate lamda(t)
df_f3<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
for (i in seq(unique(nrow(df_h3)))) 
{ 
  m1=df_h3$Date[i+4] 
  m2=df_h3$`Total Active`[i+4]
  m3=df_h3$Rate[i+4]
  m4=df_h3$`Rate-mu`[i+4]
  m5=(df_h3$Rate[i]+df_h3$Rate[i+1]+df_h3$Rate[i+2]+df_h3$Rate[i+3])/4
  temp<- data.frame(i,m1,m2,m3,m4,m5)
  df_f3<- rbind(df_f3,temp)
}

names(df_f3) <- c("No.","Date","Total Active","Rate","Rate-mu","categ")
df_f3=na.omit(df_f3)

df_f3_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
for (i in seq(unique(nrow(df_f3)))) 
{ 
  m1=df_f3$Date[i+1] 
  m2=df_f3$`Total Active`[i+1]
  m3=df_f3$Rate[i+1]
  m4=df_f3$`Rate-mu`[i+1]
  m5=df_f3$categ[i+1]
  m6=(df_f3$`Total Active`[i])*(1+(df_f3$categ[1]-0.1))
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6)
  df_f3_new<- rbind(df_f3_new,temp)
}

names(df_f3_new) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
df_f3_new=na.omit(df_f3_new)

for(i in seq(unique(nrow(df_f3_new))))
{
  if (i == 1)
    df_f3_new$model[i]=df_f3_new$Predicted_Active_Cases[1]
  if(i>1)
    df_f3_new$model[i]<-df_f3_new$model[i-1]*(1+(df_f3_new$categ[2]-0.1))
}

df_f3_new$model=floor(df_f3_new$model)


df_f3_month<-data.frame((format(df_f3_new$Date,"%Y-%m")),df_f3_new)
names(df_f3_month) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")


#prediction date=5
df_h4=subset(month_wise,month_wise$Date>="2021-04-01"&month_wise$Date<"2021-06-10")
#estimate lamda(t)
df_f4<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
for (i in seq(unique(nrow(df_h4)))) 
{ 
  m1=df_h4$Date[i+4] 
  m2=df_h4$`Total Active`[i+4]
  m3=df_h4$Rate[i+4]
  m4=df_h4$`Rate-mu`[i+4]
  m5=(df_h4$Rate[i]+df_h4$Rate[i+1]+df_h4$Rate[i+2]+df_h4$Rate[i+3])/4
  temp<- data.frame(i,m1,m2,m3,m4,m5)
  df_f4<- rbind(df_f4,temp)
}

names(df_f4) <- c("No.","Date","Total Active","Rate","Rate-mu","categ")
df_f4=na.omit(df_f4)

df_f4_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
for (i in seq(unique(nrow(df_f4)))) 
{ 
  m1=df_f4$Date[i+1] 
  m2=df_f4$`Total Active`[i+1]
  m3=df_f4$Rate[i+1]
  m4=df_f4$`Rate-mu`[i+1]
  m5=df_f4$categ[i+1]
  m6=(df_f4$`Total Active`[i])*(1+(df_f4$categ[1]-0.1))
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6)
  df_f4_new<- rbind(df_f4_new,temp)
}

names(df_f4_new) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
df_f4_new=na.omit(df_f4_new)

for(i in seq(unique(nrow(df_f4_new))))
{
  if (i == 1)
    df_f4_new$model[i]=df_f4_new$Predicted_Active_Cases[1]
  if(i>1)
    df_f4_new$model[i]<-df_f4_new$model[i-1]*(1+(df_f4_new$categ[2]-0.1))
}

df_f4_new$model=floor(df_f4_new$model)


df_f4_month<-data.frame((format(df_f4_new$Date,"%Y-%m")),df_f4_new)
names(df_f4_month) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")

#prediction date=6
df_h5=subset(month_wise,month_wise$Date>="2021-04-20"&month_wise$Date<"2021-05-25")
#estimate lamda(t)
df_f5<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
for (i in seq(unique(nrow(df_h5)))) 
{ 
  m1=df_h5$Date[i+4] 
  m2=df_h5$`Total Active`[i+4]
  m3=df_h5$Rate[i+4]
  m4=df_h5$`Rate-mu`[i+4]
  m5=(df_h5$Rate[i]+df_h5$Rate[i+1]+df_h5$Rate[i+2]+df_h5$Rate[i+3])/4
  temp<- data.frame(i,m1,m2,m3,m4,m5)
  df_f5<- rbind(df_f5,temp)
}

names(df_f5) <- c("No.","Date","Total Active","Rate","Rate-mu","categ")
df_f5=na.omit(df_f5)

df_f5_new<- data.frame(Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
for (i in seq(unique(nrow(df_f5)))) 
{ 
  m1=df_f5$Date[i+1] 
  m2=df_f5$`Total Active`[i+1]
  m3=df_f5$Rate[i+1]
  m4=df_f5$`Rate-mu`[i+1]
  m5=df_f5$categ[i+1]
  m6=(df_f5$`Total Active`[i])*(1+(df_f5$categ[1]-0.1))
  temp<- data.frame(i,m1,m2,m3,m4,m5,m6)
  df_f5_new<- rbind(df_f5_new,temp)
}

names(df_f5_new) <- c("No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
df_f5_new=na.omit(df_f5_new)

for(i in seq(unique(nrow(df_f5_new))))
{
  if (i == 1)
    df_f5_new$model[i]=df_f5_new$Predicted_Active_Cases[1]
  if(i>1)
    df_f5_new$model[i]<-df_f5_new$model[i-1]*(1+(df_f5_new$categ[2]-0.1))
}

df_f5_new$model=floor(df_f5_new$model)


df_f5_month<-data.frame((format(df_f5_new$Date,"%Y-%m")),df_f5_new)
names(df_f5_month) <- c("Month","No.","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")


total_test=ggplot(month_wise,aes(x=Date,y=Rate))+geom_point(col="blue",size=.5)+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("lamda(t)") + ggtitle("Rate") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+geom_abline(intercept =1/10,slope=0,size=1)     
total_testgp=ggplotly(total_test)

total_active=ggplot(month_wise,aes(x=Date,y=`Total Active`))+geom_point(col="blue",size=.5)+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
total_activegp=ggplotly(total_active)

total_predict=ggplot()+
  geom_line(data=month_wise,aes(x=Date,y=`Total Active`),color="blue",size=1)+
  scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases(Karnataka)") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+  
  geom_line(data = df_f_month, aes(x =Date,y=model_generated), color = "red",size=1)+
  scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases(Karnataka)") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
#  geom_line(data = df_f1_month, aes(x =Date,y=model_generated), color = "green",size=1)+
#  scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases(Karnataka)") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
#  geom_line(data = df_f2_month, aes(x =Date,y=model_generated), color = "black",size=1)+
#  scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases(Karnataka)") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
#  geom_line(data = df_f3_month, aes(x =Date,y=model_generated), color = "green",size=1)+
#  scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases(Karnataka)") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
#  geom_line(data = df_f4_month, aes(x =Date,y=model_generated), color = "orange",size=1)+
#  scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases(Karnataka)") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
#  geom_line(data = df_f5_month, aes(x =Date,y=model_generated), color = "pink",size=1)+
#  scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle("Total Active Cases(Karnataka)") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  

total_predictgp=ggplotly(total_predict)

#save total_test
###NAME OF PNGFILE
#name1 = paste("total_test_lamda","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
#ggsave(name2, plot=total_predict ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
#name = paste("total_test_lamda","html", sep=".")
#path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
#htmlwidgets::saveWidget(total_predictgp, file=path, selfcontained = FALSE, libdir = "plotly.html")









