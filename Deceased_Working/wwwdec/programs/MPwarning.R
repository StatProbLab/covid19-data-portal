##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)
library(viridis)

data<- read_excel("../earlywarning/DISTRICTINF MP.xlsx")
colnames(data)[2]="Date"

#Format date correctly
data$Date<- as.Date(data$Date, format = "%d-%m-%Y")
data=data[,c(1,2,3,4,5)]

#Name Districts

df1=subset(data,data$DISTRICTCODE=="419")
df2=subset(data,data$DISTRICTCODE=="420")
df3=subset(data,data$DISTRICTCODE=="421")
df4=subset(data,data$DISTRICTCODE=="422")
df5=subset(data,data$DISTRICTCODE=="423")
df6=subset(data,data$DISTRICTCODE=="424")
df7=subset(data,data$DISTRICTCODE=="425")
df8=subset(data,data$DISTRICTCODE=="426")
df9=subset(data,data$DISTRICTCODE=="427")
df10=subset(data,data$DISTRICTCODE=="428")
df11=subset(data,data$DISTRICTCODE=="429")
df12=subset(data,data$DISTRICTCODE=="430")
df13=subset(data,data$DISTRICTCODE=="431")
df14=subset(data,data$DISTRICTCODE=="432")
df15=subset(data,data$DISTRICTCODE=="433")
df16=subset(data,data$DISTRICTCODE=="434")
df17=subset(data,data$DISTRICTCODE=="435")
df18=subset(data,data$DISTRICTCODE=="436")
df19=subset(data,data$DISTRICTCODE=="437")
df20=subset(data,data$DISTRICTCODE=="438")
df21=subset(data,data$DISTRICTCODE=="439")
df22=subset(data,data$DISTRICTCODE=="440")
df23=subset(data,data$DISTRICTCODE=="441")
df24=subset(data,data$DISTRICTCODE=="442")
df25=subset(data,data$DISTRICTCODE=="443")
df26=subset(data,data$DISTRICTCODE=="444")
df27=subset(data,data$DISTRICTCODE=="445")
df28=subset(data,data$DISTRICTCODE=="446")
df29=subset(data,data$DISTRICTCODE=="447")
df30=subset(data,data$DISTRICTCODE=="448")
df31=subset(data,data$DISTRICTCODE=="449")
df32=subset(data,data$DISTRICTCODE=="450")
df33=subset(data,data$DISTRICTCODE=="451")
df34=subset(data,data$DISTRICTCODE=="452")
df35=subset(data,data$DISTRICTCODE=="453")
df36=subset(data,data$DISTRICTCODE=="454")
df37=subset(data,data$DISTRICTCODE=="455")
df38=subset(data,data$DISTRICTCODE=="456")
df39=subset(data,data$DISTRICTCODE=="457")
df40=subset(data,data$DISTRICTCODE=="458")
df41=subset(data,data$DISTRICTCODE=="459")
df42=subset(data,data$DISTRICTCODE=="460")
df43=subset(data,data$DISTRICTCODE=="461")
df44=subset(data,data$DISTRICTCODE=="462")
df45=subset(data,data$DISTRICTCODE=="463")
df46=subset(data,data$DISTRICTCODE=="464")
df47=subset(data,data$DISTRICTCODE=="465")
df48=subset(data,data$DISTRICTCODE=="466")
df49=subset(data,data$DISTRICTCODE=="467")
df50=subset(data,data$DISTRICTCODE=="468")
df51=subset(data,data$DISTRICTCODE=="469")
df52=subset(data,data$DISTRICTCODE=="470")
df53=subset(data,data$DISTRICTCODE=="471")
df54=subset(data,data$DISTRICTCODE=="472")
df55=subset(data,data$DISTRICTCODE=="473")



District<- rep("Agar Malwa",length(nrow(df1)))
df1$District <-District

District<- rep("Alirajpur",length(nrow(df2)))
df2$District <-District

District<- rep("Anuppur",length(nrow(df3)))
df3$District <-District

District<- rep("Ashok Nagar",length(nrow(df4)))
df4$District <-District

District<- rep("Balaghat",length(nrow(df5)))
df5$District <-District

District<- rep("Barwani",length(nrow(df6)))
df6$District <-District

District<- rep("Betul",length(nrow(df7)))
df7$District <-District

District<- rep("Bhind",length(nrow(df8)))
df8$District <-District

District<- rep("Bhopal",length(nrow(df9)))
df9$District <-District

District<- rep("Burhanpur",length(nrow(df10)))
df10$District <-District

District<- rep("Chachaura-Binaganj",length(nrow(df11)))
df11$District <-District

District<- rep("Chhatarpur",length(nrow(df12)))
df12$District <-District

District<- rep("Chhindwara",length(nrow(df13)))
df13$District <-District

District<- rep("Damoh",length(nrow(df14)))
df14$District <-District

District<- rep("Datia",length(nrow(df15)))
df15$District <-District

District<- rep("Dewas",length(nrow(df16)))
df16$District <-District

District<- rep("Dhar",length(nrow(df17)))
df17$District <-District

District<- rep("Dindori",length(nrow(df18)))
df18$District <-District

District<- rep("Guna",length(nrow(df19)))
df19$District <-District

District<- rep("Gwalior",length(nrow(df20)))
df20$District <-District

District<- rep("Harda",length(nrow(df21)))
df21$District <-District

District<- rep("Hoshangabad",length(nrow(df22)))
df22$District <-District

District<- rep("Indore",length(nrow(df23)))
df23$District <-District

District<- rep("Jabalpur",length(nrow(df24)))
df24$District <-District

District<- rep("Jhabua",length(nrow(df25)))
df25$District <-District

District<- rep("Katni",length(nrow(df26)))
df26$District <-District

District<- rep("Khandwa (East Nimar)",length(nrow(df27)))
df27$District <-District

District<- rep("Khargone (West Nimar)",length(nrow(df28)))
df28$District <-District

District<- rep("Maihar",length(nrow(df29)))
df29$District <-District

District<- rep("Mandla",length(nrow(df30)))
df30$District <-District

District<- rep("Mandsaur",length(nrow(df31)))
df31$District <-District

District<- rep("Morena",length(nrow(df32)))
df32$District <-District

District<- rep("Narsinghpur",length(nrow(df33)))
df33$District <-District

District<- rep("Nagda",length(nrow(df34)))
df34$District <-District

District<- rep("Neemuch",length(nrow(df35)))
df35$District <-District

District<- rep("Niwari",length(nrow(df36)))
df36$District <-District

District<- rep("Panna",length(nrow(df37)))
df37$District <-District

District<- rep("Raisen",length(nrow(df38)))
df38$District <-District

District<- rep("Rajgarh",length(nrow(df39)))
df39$District <-District

District<- rep("Ratlam",length(nrow(df40)))
df40$District <-District

District<- rep("Rewa",length(nrow(df41)))
df41$District <-District

District<- rep("Sagar",length(nrow(df42)))
df42$District <-District

District<- rep("Satna",length(nrow(df43)))
df43$District <-District

District<- rep("Sehore",length(nrow(df44)))
df44$District <-District

District<- rep("Seoni",length(nrow(df45)))
df45$District <-District

District<- rep("Shahdol",length(nrow(df46)))
df46$District <-District

District<- rep("Shajapur",length(nrow(df47)))
df47$District <-District

District<- rep("Sheopur",length(nrow(df48)))
df48$District <-District

District<- rep("Shivpuri",length(nrow(df49)))
df49$District <-District

District<- rep("Sidhi",length(nrow(df50)))
df50$District <-District

District<- rep("Singrauli",length(nrow(df51)))
df51$District <-District

District<- rep("Tikamgarh",length(nrow(df52)))
df52$District <-District

District<- rep("Ujjain",length(nrow(df53)))
df53$District <-District

District<- rep("Umaria",length(nrow(df54)))
df54$District <-District

District<- rep("Vidisha",length(nrow(df55)))
df55$District <-District





df=rbind(df1,df2,df3,df4,df5,df6,df7,df8,df9,df10,df11,df12,df13,df14,df15,df16,df17,df18,df19,df20,df21,df22,df23,df24,df25,df26,df27,df28,df29,df30,df31,df32,df33,df34,df35,df36,df37,df38,df39,df40,df41,df42,df43,df44,df45,df46,df47,df48,df49,df50,df51,df52,df53,df54,df55)
df=df[,c(6,2,3,4,5)]





#subsetting district wise
unique_district<- unique(df$District)
unique_district<- sort(unique_district)


#for(j in seq(length(unique_district)))
#{
j=10
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
  df_k=subset(df_f,df_f$Date>="2020-05-30"&df_f$Date<"2020-08-20")
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
  df_k1=subset(df_f,df_f$Date>="2020-06-20"&df_f$Date<"2020-09-10")
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
  df_k2=subset(df_f,df_f$Date>="2020-07-30"&df_f$Date<"2020-09-20")
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
  df_k3=subset(df_f,df_f$Date>="2021-03-20"&df_f$Date<"2021-04-30")
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
  df_k4=subset(df_f,df_f$Date>="2021-04-10"&df_f$Date<"2021-05-30")
  df_n4=subset(df_k4,df_k4$categ>0.1)
  df_h4=subset(df_f,df_f$Date>=as.Date.character(df_n4[1,2])&df_f$Date<(as.Date.character(df_n4[1,2])+20)+20)
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
  df_k5=subset(df_f,df_f$Date>="2021-04-30"&df_f$Date<"2021-06-10")
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
  my_name <- paste0("../csv/critical/", my_name_2)
  write.csv(df_save, file = my_name, row.names=FALSE)
  
  
  
  
  future=total_predict+
    geom_line(data=df_l_month,aes(x =Date,y=model_generated), color = "green",size=1)+
    scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Date") + ylab("count") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))  
  
  
  
  
  
  futuregp=ggplotly(future)
  
  
  
  #save plots
  n1 <- paste(j,"MP_lamda_t_plots",sep="-")
  name = paste(n1,"html", sep=".")
  path <- file.path(getwd(),"../graphs/MPwarning", name)
  htmlwidgets::saveWidget(futuregp, file=path, selfcontained = FALSE, libdir = "plotly.html")
  name1 <- paste(n1,"png",sep=".")
  name2 <- paste0("../graphs/MPwarning/", name1)
  ggsave(name2, plot=future ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
#}
