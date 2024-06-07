###############################################################################
## Title: Covid-19 data fro dictricts in maharashtra                         ##
## Input: earlywarning/DISTRICTINF MH.xlsx                                   ##
## Output: csv/criticalMH/[j]-prediction.csv                                 ##
## Date Modified: 22nd May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)
library(viridis)

data<- read_excel("earlywarning/DISTRICTINF MH.xlsx")

#Format date correctly
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")
data=data[,c(1,2,3,4,5)]

#Name Districts

df1=subset(data,data$DISTRICTCODE=="114")
df2=subset(data,data$DISTRICTCODE=="115")
df3=subset(data,data$DISTRICTCODE=="116")
df4=subset(data,data$DISTRICTCODE=="117")
df5=subset(data,data$DISTRICTCODE=="118")
df6=subset(data,data$DISTRICTCODE=="119")
df7=subset(data,data$DISTRICTCODE=="120")
df8=subset(data,data$DISTRICTCODE=="121")
df9=subset(data,data$DISTRICTCODE=="122")
df10=subset(data,data$DISTRICTCODE=="123")
df11=subset(data,data$DISTRICTCODE=="124")
df12=subset(data,data$DISTRICTCODE=="125")
df13=subset(data,data$DISTRICTCODE=="126")
df14=subset(data,data$DISTRICTCODE=="127")
df15=subset(data,data$DISTRICTCODE=="128")
df16=subset(data,data$DISTRICTCODE=="129")
df17=subset(data,data$DISTRICTCODE=="130")
df18=subset(data,data$DISTRICTCODE=="131")
df19=subset(data,data$DISTRICTCODE=="132")
df20=subset(data,data$DISTRICTCODE=="133")
df21=subset(data,data$DISTRICTCODE=="134")
df22=subset(data,data$DISTRICTCODE=="135")
df23=subset(data,data$DISTRICTCODE=="136")
df24=subset(data,data$DISTRICTCODE=="137")
df25=subset(data,data$DISTRICTCODE=="138")
df26=subset(data,data$DISTRICTCODE=="139")
df27=subset(data,data$DISTRICTCODE=="140")
df28=subset(data,data$DISTRICTCODE=="141")
df29=subset(data,data$DISTRICTCODE=="142")
df30=subset(data,data$DISTRICTCODE=="143")
df31=subset(data,data$DISTRICTCODE=="144")
df32=subset(data,data$DISTRICTCODE=="145")
df33=subset(data,data$DISTRICTCODE=="146")
df34=subset(data,data$DISTRICTCODE=="147")
df35=subset(data,data$DISTRICTCODE=="148")
df36=subset(data,data$DISTRICTCODE=="149")




District<- rep("Ahmednagar",length(nrow(df1)))
df1$District <-District

District<- rep("Akola",length(nrow(df2)))
df2$District <-District

District<- rep("Amaravati",length(nrow(df3)))
df3$District <-District

District<- rep("Aurangabad",length(nrow(df4)))
df4$District <-District

District<- rep("Beed",length(nrow(df5)))
df5$District <-District

District<- rep("Bhandara",length(nrow(df6)))
df6$District <-District

District<- rep("Buldhana",length(nrow(df7)))
df7$District <-District

District<- rep("Chandrapur",length(nrow(df8)))
df8$District <-District

District<- rep("Dhule",length(nrow(df9)))
df9$District <-District

District<- rep("Gadchiroli",length(nrow(df10)))
df10$District <-District

District<- rep("Gondia",length(nrow(df11)))
df11$District <-District

District<- rep("Hingoli",length(nrow(df12)))
df12$District <-District

District<- rep("Jalgaon",length(nrow(df13)))
df13$District <-District

District<- rep("Jalna",length(nrow(df14)))
df14$District <-District

District<- rep("Kolhapur",length(nrow(df15)))
df15$District <-District

District<- rep("Latur",length(nrow(df16)))
df16$District <-District

District<- rep("Mumbai",length(nrow(df17)))
df17$District <-District

District<- rep("Nagpur",length(nrow(df18)))
df18$District <-District

District<- rep("Nanded",length(nrow(df19)))
df19$District <-District

District<- rep("Nandurbar",length(nrow(df20)))
df20$District <-District

District<- rep("Nashik",length(nrow(df21)))
df21$District <-District

District<- rep("Osmanabad",length(nrow(df22)))
df22$District <-District

District<- rep("Palghar",length(nrow(df23)))
df23$District <-District

District<- rep("Parbhani",length(nrow(df24)))
df24$District <-District

District<- rep("Pune",length(nrow(df25)))
df25$District <-District

District<- rep("Raigad",length(nrow(df26)))
df26$District <-District

District<- rep("Ratnagiri",length(nrow(df27)))
df27$District <-District

District<- rep("Sangli",length(nrow(df28)))
df28$District <-District

District<- rep("Satara",length(nrow(df29)))
df29$District <-District

District<- rep("Sindhudurg",length(nrow(df30)))
df30$District <-District

District<- rep("Solapur",length(nrow(df31)))
df31$District <-District

District<- rep("Thane",length(nrow(df32)))
df32$District <-District

District<- rep("Wardha",length(nrow(df33)))
df33$District <-District

District<- rep("Washim",length(nrow(df34)))
df34$District <-District

District<- rep("Yavatmal",length(nrow(df35)))
df35$District <-District





df=rbind(df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12,df13,df14,df15,df16,df17,df18,df19,df20,df21,df22,df23,df24,df25,df26,df27,df28,df29,df30,df31,df32,df33,df34,df35)
df=df[,c(6,2,3,4,5)]

#subsetting district wise
unique_district<- unique(df$District)
unique_district<- sort(unique_district)

for(j in seq(length(unique_district)))
{
#j=4
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
  df_k=subset(df_f,df_f$Date>="2020-05-20"&df_f$Date<"2020-07-20")
  df_n=subset(df_k,df_k$categ>0.1)
  df_h=subset(df_f,df_f$Date>=as.Date.character(df_n[1,2])&df_f$Date<(as.Date.character(df_n[1,2])+20))

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
  df_k1=subset(df_f,df_f$Date>="2020-06-30"&df_f$Date<"2020-08-20")
  df_n1=subset(df_k1,df_k1$categ>0.1)
  df_h1=subset(df_f,df_f$Date>=as.Date.character(df_n1[1,2])&df_f$Date<(as.Date.character(df_n1[1,2])+20))

  
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
  df_k2=subset(df_f,df_f$Date>="2020-07-10"&df_f$Date<"2020-10-10")
  df_n2=subset(df_k2,df_k2$categ>0.1)
  df_h2=subset(df_f,df_f$Date>=as.Date.character(df_n2[1,2])&df_f$Date<(as.Date.character(df_n2[1,2])+20))
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
  df_k3=subset(df_f,df_f$Date>="2021-03-01"&df_f$Date<"2021-05-20")
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
  df_k4=subset(df_f,df_f$Date>="2021-03-20"&df_f$Date<"2021-07-30")
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
  df_k5=subset(df_f,df_f$Date>="2021-04-10"&df_f$Date<"2021-07-20")
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
  df_a=subset(df_f,df_f$Date>=as.Date.character(df_f[nrow(df_f),2])&df_f$Date<as.Date.character(df_f[nrow(df_f),2]+20))
  #estimate lamda(t)
  df_a[nrow(df_a)+14,] <- NA
  
  
  for(i in seq(unique(nrow(df_a))))
  {
    if (i == 1)
      df_a$model[i]=df_a$`Total Active`[1]
    if(i>1)
      df_a$model[i]<-df_a$model[i-1]*(1+(df_a$categ[1]-0.1))
  }
  
  for(t in seq(unique(nrow(df_a))))
  {
    if (t == 1)
      df_a$Date[t]=as.Date.character(df_a$Date[1])
    if(t>1)
      df_a$Date[t]=as.Date.character(df_a$Date[t-1])+1
  } 
  
  df_a$model=floor(df_a$model)
  
  df_l_month<-data.frame((format(df_a$Date,"%Y-%m")),df_a)
  names(df_l_month) <- c("Month","No.","Date","District","Total Active","Rate","Rate-mu","categ","model_generated")
  
  df_save=df_l_month[,c(4,3,5,8,9)]
  names(df_save) <- c("District","Date","Current Active Cases","Rate(lamda-t)","model_generated")
  
  
  #Writing district data
  my_name_1 <- paste(j,"prediction",sep="-")
  my_name_2 <- paste(my_name_1,"csv",sep=".")
  my_name <- paste0("csv/criticalMH/", my_name_2)
  write.csv(df_save, file = my_name, row.names=FALSE)
  
  
  
  
  future=total_predict+
    geom_line(data=df_l_month,aes(x =Date,y=model_generated), color = "green",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
  
  
  
  
  
  futuregp=ggplotly(future)
  
  
  
#save plots
  n1 <- paste(j,"MH_lamda_t_plots",sep="-")
  name = paste(n1,"html", sep=".")
  path <- file.path(getwd(),"graphs/MHwarning", name)
  htmlwidgets::saveWidget(futuregp, file=path, selfcontained = FALSE, libdir = "plotly.html")
  name1 <- paste(n1,"png",sep=".")
  name2 <- paste0("graphs/MHwarning/", name1)
  ggsave(name2, plot=future ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}