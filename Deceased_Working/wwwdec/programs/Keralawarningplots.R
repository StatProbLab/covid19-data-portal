###############################################################################
## Title: Kerala Analysis                                                    ##
## Input: earlywarning/DISTRICTINF KL.xlsx                                   ##
## Output: csv/criticalKerala/[j]-prediction.csv, Plots                      ##
## Date Modified: 22nd May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)
library(viridis)

#Read data
data<- read_excel("earlywarning/DISTRICTINF KL.xlsx")

#Format date correctly
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")
data=data[,c(1,2,3,4,5)]

#Name Districts

df1=subset(data,data$DISTRICTCODE=="99")
df2=subset(data,data$DISTRICTCODE=="100")
df3=subset(data,data$DISTRICTCODE=="101")
df4=subset(data,data$DISTRICTCODE=="102")
df5=subset(data,data$DISTRICTCODE=="103")
df6=subset(data,data$DISTRICTCODE=="104")
df7=subset(data,data$DISTRICTCODE=="105")
df8=subset(data,data$DISTRICTCODE=="106")
df9=subset(data,data$DISTRICTCODE=="107")
df10=subset(data,data$DISTRICTCODE=="108")
df11=subset(data,data$DISTRICTCODE=="109")
df12=subset(data,data$DISTRICTCODE=="110")
df13=subset(data,data$DISTRICTCODE=="111")
df14=subset(data,data$DISTRICTCODE=="112")

District<- rep("Alappuzha",length(nrow(df1)))
df1$District <-District

District<- rep("Ernakulam",length(nrow(df2)))
df2$District <-District

District<- rep("Idukki",length(nrow(df3)))
df3$District <-District

District<- rep("Kannur",length(nrow(df4)))
df4$District <-District

District<- rep("Kasaragod",length(nrow(df5)))
df5$District <-District

District<- rep("Kollam",length(nrow(df6)))
df6$District <-District

District<- rep("Kottayam",length(nrow(df7)))
df7$District <-District

District<- rep("Kozhikode",length(nrow(df8)))
df8$District <-District

District<- rep("Malappuram",length(nrow(df9)))
df9$District <-District

District<- rep("Palakkad",length(nrow(df10)))
df10$District <-District

District<- rep("Pathanamthitta",length(nrow(df11)))
df11$District <-District

District<- rep("Thiruvananthapuram",length(nrow(df12)))
df12$District <-District

District<- rep("Thrissur",length(nrow(df13)))
df13$District <-District

District<- rep("Wayanad",length(nrow(df14)))
df14$District <-District

df=rbind(df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12,df13,df14)
df=df[,c(6,2,3,4,5)]





#subsetting district wise
unique_district<- unique(df$District)
unique_district<- sort(unique_district)

for(j in seq(length(unique_district)))
{
#j=2
  df_new<- data.frame(District=character(),Date=character(),Total_Active = double(),Rate=double())
  
  sub_data <- subset(df,df$District==unique_district[j])
  sub_data$Active_cases=sub_data$TINF-sub_data$TREC-sub_data$TDEC
  
  {  for (i in seq(unique(nrow(sub_data)))) 
  {
    m1 <-sub_data$Active_cases[i+7]
    m2=(1/10+((sub_data$Active_cases[i+7]-sub_data$Active_cases[i])/(7*(sub_data$Active_cases[i+7]))))
    m3=((sub_data$Active_cases[i+7]-sub_data$Active_cases[i])/(7*(sub_data$Active_cases[i+7])))
    m4=sub_data$Date[i+7]
    temp<- data.frame(j,i,m4,m1,m2,m3)
    df_new<- rbind(df_new,temp)
  }
  }
  names(df_new) <- c("District","No.","Date","Total Active","Rate","Rate-mu")
  
  month_wise<-data.frame((format(df_new$Date,"%Y-%m")),df_new)
  names(month_wise) <- c("Month","District","No.","Date","Total Active","Rate","Rate-mu")
  month_wise=na.omit(month_wise)
  month_wise$Rate[!is.finite(month_wise$Rate)]=0
  month_wise$`Rate-mu`[!is.finite(month_wise$`Rate-mu`)]=0
  
  df_f<- data.frame(Date=character(),District=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
  for (i in seq(unique(nrow(month_wise)))) 
  { 
    m1=month_wise$Date[i+4] 
    m2=month_wise$`Total Active`[i+4]
    m3=month_wise$Rate[i+4]
    m4=month_wise$`Rate-mu`[i+4]
    m5=(month_wise$Rate[i]+month_wise$Rate[i+1]+month_wise$Rate[i+2]+month_wise$Rate[i+3])/4
    m6=month_wise$District[i+4]
    temp<- data.frame(i,m1,m6,m2,m3,m4,m5)
    df_f<- rbind(df_f,temp)
  }
  names(df_f) <- c("No.","Date","District","Total Active","Rate","Rate-mu","categ")
  df_f=na.omit(df_f)
  
  ###plot lamda and total active
  total_test=ggplot(month_wise,aes(x=Date,y=Rate))+geom_point(col="blue",size=.5)+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("lamda(t)") + ggtitle("Rate") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+geom_abline(intercept =1/10,slope=0,size=1)     
  total_testgp=ggplotly(total_test)
  
  total_active=ggplot(month_wise,aes(x=Date,y=`Total Active`))+geom_point(col="blue",size=.5)+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("count") + ggtitle("Total Active Cases") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
  total_activegp=ggplotly(total_active)
  
  
  #prediction date=1
  df_k=subset(df_f,df_f$Date>="2020-05-30"&df_f$Date<"2020-07-20")
  df_n=subset(df_k,df_k$categ>0.1)
  df_h=subset(df_f,df_f$Date>=as.Date.character(df_n[1,2])&df_f$Date<(as.Date.character(df_n[1,2])+20))
  #estimate lamda(t)
  
  for(i in seq(unique(nrow(df_h))))
  {
    if (i == 1)
      df_h$model[i]=df_h$`Total Active`[1]
    if(i>1)
      df_h$model[i]<-df_h$model[i-1]*(1+(df_h$categ[1]-0.1))
  }
  
  df_h$model=floor(df_h$model)
  
  df_f_month<-data.frame((format(df_h$Date,"%Y-%m")),df_h)
  names(df_f_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","model_generated")
  
  
  #prediction date=2
  df_k1=subset(df_f,df_f$Date>="2020-07-20"&df_f$Date<"2020-08-20")
  df_n1=subset(df_k1,df_k1$categ>0.1)
  df_h1=subset(df_f,df_f$Date>=as.Date.character(df_n1[1,2])&df_f$Date<(as.Date.character(df_n1[1,2])+20))
  #estimate lamda(t)
  
  
  for(i in seq(unique(nrow(df_h1))))
  {
    if (i == 1)
      df_h1$model[i]=df_h1$`Total Active`[1]
    if(i>1)
      df_h1$model[i]<-df_h1$model[i-1]*(1+(df_h1$categ[1]-0.1))
  }
  
  df_h1$model=floor(df_h1$model)
  
  
  df_f1_month<-data.frame((format(df_h1$Date,"%Y-%m")),df_h1)
  names(df_f1_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","model_generated")
  
  #prediction date=3
  df_k2=subset(df_f,df_f$Date>="2020-09-10"&df_f$Date<"2020-10-10")
  df_n2=subset(df_k2,df_k2$categ>0.1)
  df_h2=subset(df_f,df_f$Date>=as.Date.character(df_n2[1,2])&df_f$Date<(as.Date.character(df_n2[1,2])+20))
  #estimate lamda(t)
  for(i in seq(unique(nrow(df_h2))))
  {
    if (i == 1)
      df_h2$model[i]=df_h2$`Total Active`[1]
    if(i>1)
      df_h2$model[i]<-df_h2$model[i-1]*(1+(df_h2$categ[1]-0.1))
  }
  
  df_h2$model=floor(df_h2$model)
  
  
  df_f2_month<-data.frame((format(df_h2$Date,"%Y-%m")),df_h2)
  names(df_f2_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","model_generated")
  
  #prediction date=4
  df_k3=subset(df_f,df_f$Date>="2021-03-10"&df_f$Date<"2021-04-20")
  df_n3=subset(df_k3,df_k3$categ>0.1)
  df_h3=subset(df_f,df_f$Date>=as.Date.character(df_n3[1,2])&df_f$Date<(as.Date.character(df_n3[1,2])+20))
  #estimate lamda(t)
  
  for(i in seq(unique(nrow(df_h3))))
  {
    if (i == 1)
      df_h3$model[i]=df_h3$`Total Active`[1]
    if(i>1)
      df_h3$model[i]<-df_h3$model[i-1]*(1+(df_h3$categ[1]-0.1))
  }
  
  df_h3$model=floor(df_h3$model)
  
  
  df_f3_month<-data.frame((format(df_h3$Date,"%Y-%m")),df_h3)
  names(df_f3_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","model_generated")
  
  
  #prediction date=5
  df_k4=subset(df_f,df_f$Date>="2021-04-10"&df_f$Date<"2021-05-20")
  df_n4=subset(df_k4,df_k4$categ>0.1)
  df_h4=subset(df_f,df_f$Date>=as.Date.character(df_n4[1,2])&df_f$Date<(as.Date.character(df_n4[1,2])+20))
  #estimate lamda(t)
  
  for(i in seq(unique(nrow(df_h4))))
  {
    if (i == 1)
      df_h4$model[i]=df_h4$`Total Active`[1]
    if(i>1)
      df_h4$model[i]<-df_h4$model[i-1]*(1+(df_h4$categ[1]-0.1))
  }
  
  df_h4$model=floor(df_h4$model)
  
  
  df_f4_month<-data.frame((format(df_h4$Date,"%Y-%m")),df_h4)
  names(df_f4_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","model_generated")
  
  #prediction date=6
  df_k5=subset(df_f,df_f$Date>="2021-04-20"&df_f$Date<"2021-05-20")
  df_n5=subset(df_k5,df_k5$categ>0.1)
  df_h5=subset(df_f,df_f$Date>=as.Date.character(df_n5[1,2])&df_f$Date<(as.Date.character(df_n5[1,2])+20))
  #estimate lamda(t)
  
  for(i in seq(unique(nrow(df_h5))))
  {
    if (i == 1)
      df_h5$model[i]=df_h5$`Total Active`[1]
    if(i>1)
      df_h5$model[i]<-df_h5$model[i-1]*(1+(df_h5$categ[1]-0.1))
  }
  
  df_h5$model=floor(df_h5$model)
  
  
  df_f5_month<-data.frame((format(df_h5$Date,"%Y-%m")),df_h5)
  names(df_f5_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","model_generated")
  
  
  
  head1<- paste("",unique_district[j], sep = " ")
  
  
  total_predict=ggplot()+
    geom_line(data=month_wise,aes(x=Date,y=`Total Active`),color="blue",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+  
    geom_line(data = df_f_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f1_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f2_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f3_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f4_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f5_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
  
  total_predictgp=ggplotly(total_predict)
  
  ####now we predict for future times
  #k=1 
  #future prediction
  df_a=subset(month_wise,month_wise$Date>as.Date.character(month_wise[nrow(month_wise),4]-6)&month_wise$Date<as.Date.character(month_wise[nrow(month_wise),4]+20))
  #estimate lamda(t)
  df_l<- data.frame(Date=character(),District=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
  for (i in seq(unique(nrow(df_a)))) 
  { 
    m1=df_a$Date[i+4] 
    m2=df_a$`Total Active`[i+4]
    m3=df_a$Rate[i+4]
    m4=df_a$`Rate-mu`[i+4]
    m5=(df_a$Rate[i]+df_a$Rate[i+1]+df_a$Rate[i+2]+df_a$Rate[i+3])/4
    m6=df_a$District[i+4]
    temp<- data.frame(i,m1,m6,m2,m3,m4,m5)
    df_l<- rbind(df_l,temp)
  }
  names(df_l) <- c("No.","Date","District","Total Active","Rate","Rate-mu","categ")
  df_l=na.omit(df_l)
  
  df_l_new<- data.frame(Date=character(),District=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
  for (i in seq(unique(nrow(df_l)))) 
  { 
    m1=df_l$Date[i+1] 
    m2=df_l$`Total Active`[i+1]
    m3=df_l$Rate[i+1]
    m4=df_l$`Rate-mu`[i+1]
    m5=df_l$categ[i+1]
    m6=(df_l$`Total Active`[i])*(1+(df_l$categ[1]-0.1))
    m7=df_l$District[i+1]
    temp<- data.frame(i,m1,m7,m2,m3,m4,m5,m6)
    df_l_new<- rbind(df_l_new,temp)
  }
  
  names(df_l_new) <- c("No.","Date","District","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
  df_l_new=na.omit(df_l_new)
  
  df_l_new[nrow(df_l_new)+14,] <- NA
  
  
  for(i in seq(unique(nrow(df_l_new))))
  {
    if (i == 1)
      df_l_new$model[i]=df_l_new$`Total Active`[1]
    if(i>1)
      df_l_new$model[i]<-df_l_new$model[i-1]*(1+(df_l_new$categ[1]-0.1))
  }
  
  for(t in seq(unique(nrow(df_l_new))))
  {
    if (t == 1)
      df_l_new$Date[t]=as.Date.character(df_l_new$Date[1])
    if(t>1)
      df_l_new$Date[t]=as.Date.character(df_l_new$Date[t-1])+1
  } 
  
  df_l_new$model=floor(df_l_new$model)
  
  df_l_month<-data.frame((format(df_l_new$Date,"%Y-%m")),df_l_new)
  names(df_l_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")
  
  df_save=df_l_month[,c(4,3,5,8,10)]
  names(df_save) <- c("District","Date","Current Active Cases","Rate(lamda-t)","model_generated")
  
  
  #Writing district data
  my_name_1 <- paste(j,"prediction",sep="-")
  my_name_2 <- paste(my_name_1,"csv",sep=".")
  my_name <- paste0("csv/criticalKerala/", my_name_2)
  write.csv(df_save, file = my_name, row.names=FALSE)
  
  
  
  
  future=total_predict+
    geom_line(data=df_l_month,aes(x =Date,y=model_generated), color = "green",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
  
  
  
  
  
  futuregp=ggplotly(future)
  
  
  
#save plots
  n1 <- paste(j,"KL_lamda_t_plots",sep="-")
  name = paste(n1,"html", sep=".")
  path <- file.path(getwd(),"graphs/kerelawarning", name)
  htmlwidgets::saveWidget(futuregp, file=path, selfcontained = FALSE, libdir = "plotly.html")
  name1 <- paste(n1,"png",sep=".")
  name2 <- paste0("graphs/kerelawarning/", name1)
  ggsave(name2, plot=future ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}
