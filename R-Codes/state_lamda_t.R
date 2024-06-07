###############################################################
## Title: EWS for each states in India                       ##
## Input: indiaactivetrans.csv                               ##
## Output: Plot of Date Vs Count                             ##
## Date Modified: 13-05-2024                                 ##
###############################################################

##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)
library(viridis)
library(readr)

#Read data
df<- read_csv("../csv/indiaactivetrans.csv")

#Format date correctly
df$Date<- as.Date(df$Date, format = "%d-%m-%Y")

#subsetting State wise
unique_state<- unique(df$State)
unique_state<- sort(unique_state)  

for(j in seq(length(unique_state)))
{
#j=8
  
  df_new<- data.frame(State=character(),Date=character(),Total_Active = double(),Rate=double())
  
  sub_data <- subset(df,df$State==unique_state[j])
  sub_data$Active_cases=sub_data$`Total Active`
  
  {  for (i in seq(unique(nrow(sub_data)))) 
  {
    m1 <-sub_data$Active_cases[i+7]
    m2=(1/10+((sub_data$Active_cases[i+7]-sub_data$Active_cases[i])/(7*(sub_data$Active_cases[i+7]))))+0.001
    m3=((sub_data$Active_cases[i+7]-sub_data$Active_cases[i])/(7*(sub_data$Active_cases[i+7])))+0.001
    m4=sub_data$Date[i+7]
    temp<- data.frame(j,i,m4,m1,m2,m3)
    df_new<- rbind(df_new,temp)
  }
  }
  names(df_new) <- c("State","No.","Date","Total Active","Rate","Rate-mu")
  
  month_wise<-data.frame((format(df_new$Date,"%Y-%m")),df_new)
  names(month_wise) <- c("Month","State","No.","Date","Total Active","Rate","Rate-mu")
  month_wise$Rate[!is.finite(month_wise$Rate)]=0
  month_wise$`Rate-mu`[!is.finite(month_wise$`Rate-mu`)]=0
  month_wise$Rate[is.na(month_wise$Rate)] = 0
  month_wise$`Rate-mu`[is.na(month_wise$`Rate-mu`)] = 0
  month_wise=na.omit(month_wise)
  
  
  
  df_f3<- data.frame(Date=character(),State=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
  for (i in seq(unique(nrow(month_wise)))) 
  { 
    m1=month_wise$Date[i+4] 
    m2=month_wise$`Total Active`[i+4]
    m3=month_wise$Rate[i+4]
    m4=month_wise$`Rate-mu`[i+4]
    m5=(month_wise$Rate[i]+month_wise$Rate[i+1]+month_wise$Rate[i+2]+month_wise$Rate[i+3])/4
    m6=month_wise$State[i+4]
    temp<- data.frame(i,m1,m6,m2,m3,m4,m5)
    df_f3<- rbind(df_f3,temp)
  }
  
  names(df_f3) <- c("No.","Date","State","Total Active","Rate","Rate-mu","categ")
  df_f3=na.omit(df_f3)  
  
  ###plot lamda and total active
  total_test=ggplot(month_wise,aes(x=Date,y=Rate))+geom_point(col="blue",size=.5)+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("lamda(t)") + ggtitle("Rate") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+geom_abline(intercept =1/10,slope=0,size=1)     
  total_testgp=ggplotly(total_test)
  
  total_active=ggplot(month_wise,aes(x=Date,y=`Total Active`))+geom_point(col="blue",size=.5)+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("count") + ggtitle("Total Active Cases") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
  total_activegp=ggplotly(total_active)
  
  
  #prediction date=4
  df_k3=subset(df_f3,df_f3$Date>="2021-03-20"&df_f3$Date<"2021-04-20")
  df_n3=subset(df_k3,df_k3$categ>0.1)
  df_h3=subset(df_f3,df_f3$Date>=as.Date.character(df_n3[1,2])&df_f3$Date<"2021-04-20")
  
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
  names(df_f3_month) <- c("Month","No.","Date","State","Total Active","Rate","Rate-mu","categ","model_generated")
  
  
  #prediction date=5
  df_k4=subset(df_f3,df_f3$Date>="2021-04-10"&df_f3$Date<"2021-05-20")
  df_n4=subset(df_k4,df_k4$categ>0.1)
  df_h4=subset(df_f3,df_f3$Date>=as.Date.character(df_n4[1,2])&df_f3$Date<"2021-05-20")
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
  names(df_f4_month) <- c("Month","No.","Date","State","Total Active","Rate","Rate-mu","categ","model_generated")
  
  #prediction date=6
  df_k5=subset(df_f3,df_f3$Date>="2021-04-20"&df_f3$Date<"2021-05-20")
  df_n5=subset(df_k5,df_k5$categ>0.1)
  df_h5=subset(df_f3,df_f3$Date>=as.Date.character(df_n5[1,2])&df_f3$Date<"2021-05-20")
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
  names(df_f5_month) <- c("Month","No.","Date","State","Total Active","Rate","Rate-mu","categ","model_generated")

  #prediction date=7
  df_k5a=subset(df_f3,df_f3$Date>="2021-12-15"&df_f3$Date<"2022-03-31")
  df_n5a=subset(df_k5a,df_k5a$categ>0.1)
  df_h5a=subset(df_f3,df_f3$Date>=as.Date.character(df_n5a[1,2])&df_f3$Date<"2022-03-31")
  #estimate lamda(t)

    for(i in seq(unique(nrow(df_h5a))))
  {
    if (i == 1)
      df_h5a$model[i]=df_h5a$`Total Active`[1]
    if(i>1)
      df_h5a$model[i]<-df_h5a$model[i-1]*(1+(df_h5a$categ[1]-0.1))
  }
  
  df_h5a$model=floor(df_h5a$model)
  
  
  df_f5a_month<-data.frame((format(df_h5a$Date,"%Y-%m")),df_h5a)
  names(df_f5a_month) <- c("Month","No.","Date","State","Total Active","Rate","Rate-mu","categ","model_generated")


  #prediction date=8
  df_k5XX=subset(df_f3,df_f3$Date>="2022-01-01"&df_f3$Date<"2022-03-31")
  df_n5XX=subset(df_k5XX,df_k5XX$categ>0.1)
  df_h5XX=subset(df_f3,df_f3$Date>=as.Date.character(df_n5XX[1,2])&df_f3$Date<"2022-03-31")
  #estimate lamda(t)

    for(i in seq(unique(nrow(df_h5XX))))
  {
    if (i == 1)
      df_h5XX$model[i]=df_h5XX$`Total Active`[1]
    if(i>1)
      df_h5XX$model[i]<-df_h5XX$model[i-1]*(1+(df_h5XX$categ[1]-0.1))
  }
  
  df_h5XX$model=floor(df_h5XX$model)
  
  
  df_f5XX_month<-data.frame((format(df_h5XX$Date,"%Y-%m")),df_h5XX)
  names(df_f5XX_month) <- c("Month","No.","Date","State","Total Active","Rate","Rate-mu","categ","model_generated")
  
    #prediction date=9
  df_k5XXX=subset(df_f3,df_f3$Date>="2022-01-15"&df_f3$Date<"2022-03-31")
  df_n5XXX=subset(df_k5XXX,df_k5XXX$categ>0.1)
  df_h5XXX=subset(df_f3,df_f3$Date>=as.Date.character(df_n5XXX[1,2])&df_f3$Date<"2022-03-31")
  #estimate lamda(t)

    for(i in seq(unique(nrow(df_h5XXX))))
  {
    if (i == 1)
      df_h5XXX$model[i]=df_h5XXX$`Total Active`[1]
    if(i>1)
      df_h5XXX$model[i]<-df_h5XXX$model[i-1]*(1+(df_h5XXX$categ[1]-0.1))
  }
  
  df_h5XXX$model=floor(df_h5XXX$model)
  
  
  df_f5XXX_month<-data.frame((format(df_h5XXX$Date,"%Y-%m")),df_h5XXX)
  names(df_f5XXX_month) <- c("Month","No.","Date","State","Total Active","Rate","Rate-mu","categ","model_generated")
  

  
  
  head1<- paste("",unique_state[j], sep = " ")
  
  
  total_predict=ggplot()+
    geom_line(data=month_wise,aes(x=Date,y=`Total Active`),color="blue",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+  
#    geom_line(data = df_f_month, aes(x =Date,y=model_generated), color = "red",size=1)+
#    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
#    geom_line(data = df_f1_month, aes(x =Date,y=model_generated), color = "red",size=1)+
#    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
   geom_line(data = df_f3_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f4_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f5_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f5a_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28)) +
    geom_line(data = df_f5XX_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))+
    geom_line(data = df_f5XXX_month, aes(x =Date,y=model_generated), color = "red",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
     
    
  
  total_predictgp=ggplotly(total_predict)
  
  ####now we predict for future times
  #k=1 
  #future prediction
  df_a=subset(month_wise,month_wise$Date>as.Date.character(month_wise[nrow(month_wise),4]-6)&month_wise$Date<as.Date.character(month_wise[nrow(month_wise),4]+20))
  #estimate lamda(t)
  df_l<- data.frame(Date=character(),State=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double())
  for (i in seq(unique(nrow(df_a)))) 
  { 
    m1=df_a$Date[i+4] 
    m2=df_a$`Total Active`[i+4]
    m3=df_a$Rate[i+4]
    m4=df_a$`Rate-mu`[i+4]
    m5=(df_a$Rate[i]+df_a$Rate[i+1]+df_a$Rate[i+2]+df_a$Rate[i+3])/4
    m6=df_a$State[i+4]
    temp<- data.frame(i,m1,m6,m2,m3,m4,m5)
    df_l<- rbind(df_l,temp)
  }
  names(df_l) <- c("No.","Date","State","Total Active","Rate","Rate-mu","categ")
  df_l=na.omit(df_l)
  
  df_l_new<- data.frame(Date=character(),State=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double())
  for (i in seq(unique(nrow(df_l)))) 
  { 
    m1=df_l$Date[i+1] 
    m2=df_l$`Total Active`[i+1]
    m3=df_l$Rate[i+1]
    m4=df_l$`Rate-mu`[i+1]
    m5=df_l$categ[i+1]
    m6=(df_l$`Total Active`[i])*(1+(df_l$categ[1]-0.1))
    m7=df_l$State[i+1]
    temp<- data.frame(i,m1,m7,m2,m3,m4,m5,m6)
    df_l_new<- rbind(df_l_new,temp)
  }

  
  names(df_l_new) <- c("No.","Date","State","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases")
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
  names(df_l_month) <- c("Month","No.","Date","State","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","model_generated")
  
  df_save=df_l_month[,c(4,3,5,8,10)]
  names(df_save) <- c("State","Date","Current Active Cases","Rate(lamda-t)","model_generated")
  
  
  #Writing State data
  my_name_1 <- paste(j,"state-prediction",sep="-")
  my_name_2 <- paste(my_name_1,"csv",sep=".")
  my_name <- paste0("../csv/critical/", my_name_2)
  write.csv(df_save, file = my_name, row.names=FALSE)
  
  
  
  
  future=total_predict+
    geom_line(data=df_l_month,aes(x =Date,y=model_generated), color = "green",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
  
  
  
  
  
  futuregp=ggplotly(future)
  
  
  
  
  #save plots
  n1 <- paste(j,"state_lamda_t_plots",sep="-")
  name = paste(n1,"html", sep=".")
  path <- file.path(getwd(),"../graphs/", name)
  htmlwidgets::saveWidget(futuregp, file=path, selfcontained = FALSE, libdir = "plotly.html")
  name1 <- paste(n1,"png",sep=".")
  name2 <- paste0("../graphs/", name1)
  ggsave(name2, plot=future ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}




