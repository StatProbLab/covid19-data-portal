##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)
library(viridis)

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

#Read data
#Read data
data<- read_csv("csv/kaactivetrans.csv")

#Format date correctly
data$Date<- as.Date(data$Date, format = "%d-%m-%Y")

#mapping to district names
df_1=subset(data,data$District=="Bagalkot")
df_2=subset(data,data$District=="Ballari")
df_3=subset(data,data$District=="Belgaum")
df_4=subset(data,data$District=="Bengaluru Rural")
df_5=subset(data,data$District=="Bengaluru Urban")
df_6=subset(data,data$District=="Bidar")
df_7=subset(data,data$District=="Chamarajanagar")
df_8=subset(data,data$District=="Chikkaballapur")
df_9=subset(data,data$District=="Chikmagalur")
df_10=subset(data,data$District=="Chitradurga")
df_11=subset(data,data$District=="Dakshina Kannada")
df_12=subset(data,data$District=="Davanagere")
df_13=subset(data,data$District=="Dharwad")
df_14=subset(data,data$District=="Gadag")
df_15=subset(data,data$District=="Hassan")
df_16=subset(data,data$District=="Haveri")
df_17=subset(data,data$District=="Kalaburagi")
df_18=subset(data,data$District=="Kodagu")
df_19=subset(data,data$District=="Kolar")
df_20=subset(data,data$District=="Koppal")
df_21=subset(data,data$District=="Mandya")
df_22=subset(data,data$District=="Mysuru")
df_23=subset(data,data$District=="Raichur")
df_24=subset(data,data$District=="Ramanagar")
df_25=subset(data,data$District=="Shivamogga")
df_26=subset(data,data$District=="Tumakuru")
df_27=subset(data,data$District=="Udupi")
df_28=subset(data,data$District=="Uttara Kannada")
df_29=subset(data,data$District=="Vijayapura")
df_30=subset(data,data$District=="Yadgir")

#naming districts
#1
Target_1<- rep("107",length(nrow(df_1)))
df_1$Target_1 <-Target_1

Target_2<- rep("2142",length(nrow(df_1)))
df_1$Target_2 <-Target_2

Target_3<- rep("3213",length(nrow(df_1)))
df_1$Target_3 <-Target_3

Target_4<- rep("4284",length(nrow(df_1)))
df_1$Target_4 <-Target_4

Population<- rep("2141784",length(nrow(df_1)))
df_1$Population <-Population

#2
Target_1<- rep("155",length(nrow(df_2)))
df_2$Target_1 <-Target_1

Target_2<- rep("3097",length(nrow(df_2)))
df_2$Target_2 <-Target_2

Target_3<- rep("4645",length(nrow(df_2)))
df_2$Target_3 <-Target_3

Target_4<- rep("6193",length(nrow(df_2)))
df_2$Target_4 <-Target_4

Population<- rep("3096512",length(nrow(df_2)))
df_2$Population <-Population

#3

Target_1<- rep("268",length(nrow(df_3)))
df_3$Target_1 <-Target_1

Target_2<- rep("5355",length(nrow(df_3)))
df_3$Target_2 <-Target_2

Target_3<- rep("8032",length(nrow(df_3)))
df_3$Target_3 <-Target_3

Target_4<- rep("10709",length(nrow(df_3)))
df_3$Target_4 <-Target_4

Population<- rep("5354714",length(nrow(df_3)))
df_3$Population <-Population

#4

Target_1<- rep("57",length(nrow(df_4)))
df_4$Target_1 <-Target_1

Target_2<- rep("1140",length(nrow(df_4)))
df_4$Target_2 <-Target_2

Target_3<- rep("1710",length(nrow(df_4)))
df_4$Target_3 <-Target_3

Target_4<- rep("2279",length(nrow(df_4)))
df_4$Target_4 <-Target_4

Population<- rep("1139694",length(nrow(df_4)))
df_4$Population <-Population

#5

Target_1<- rep("681",length(nrow(df_5)))
df_5$Target_1 <-Target_1

Target_2<- rep("13626",length(nrow(df_5)))
df_5$Target_2 <-Target_2

Target_3<- rep("20439",length(nrow(df_5)))
df_5$Target_3 <-Target_3

Target_4<- rep("27252",length(nrow(df_5)))
df_5$Target_4 <-Target_4

Population<- rep("13626081",length(nrow(df_5)))
df_5$Population <-Population

#6

Target_1<- rep("95",length(nrow(df_6)))
df_6$Target_1 <-Target_1

Target_2<- rep("1904",length(nrow(df_6)))
df_6$Target_2 <-Target_2

Target_3<- rep("2855",length(nrow(df_6)))
df_6$Target_3 <-Target_3

Target_4<- rep("3807",length(nrow(df_6)))
df_6$Target_4 <-Target_4

Population<- rep("1903546",length(nrow(df_6)))
df_6$Population <-Population

#7

Target_1<- rep("54",length(nrow(df_7)))
df_7$Target_1 <-Target_1

Target_2<- rep("1076",length(nrow(df_7)))
df_7$Target_2 <-Target_2

Target_3<- rep("1614",length(nrow(df_7)))
df_7$Target_3 <-Target_3

Target_4<- rep("2152",length(nrow(df_7)))
df_7$Target_4 <-Target_4

Population<- rep("1076085",length(nrow(df_7)))
df_7$Population <-Population

#8

Target_1<- rep("68",length(nrow(df_8)))
df_8$Target_1 <-Target_1

Target_2<- rep("1364",length(nrow(df_8)))
df_8$Target_2 <-Target_2

Target_3<- rep("2046",length(nrow(df_8)))
df_8$Target_3 <-Target_3

Target_4<- rep("2729",length(nrow(df_8)))
df_8$Target_4 <-Target_4

Population<- rep("1364310",length(nrow(df_8)))
df_8$Population <-Population

#9

Target_1<- rep("57",length(nrow(df_9)))
df_9$Target_1 <-Target_1

Target_2<- rep("1137",length(nrow(df_9)))
df_9$Target_2 <-Target_2

Target_3<- rep("1705",length(nrow(df_9)))
df_9$Target_3 <-Target_3

Target_4<- rep("2273",length(nrow(df_9)))
df_9$Target_4 <-Target_4

Population<- rep("1136558",length(nrow(df_9)))
df_9$Population <-Population

#10

Target_1<- rep("90",length(nrow(df_10)))
df_10$Target_1 <-Target_1

Target_2<- rep("1803",length(nrow(df_10)))
df_10$Target_2 <-Target_2

Target_3<- rep("2705",length(nrow(df_10)))
df_10$Target_3 <-Target_3

Target_4<- rep("3606",length(nrow(df_10)))
df_10$Target_4 <-Target_4

Population<- rep("1803209",length(nrow(df_10)))
df_10$Population <-Population

#11

Target_1<- rep("117",length(nrow(df_11)))
df_11$Target_1 <-Target_1

Target_2<- rep("2335",length(nrow(df_11)))
df_11$Target_2 <-Target_2

Target_3<- rep("3503",length(nrow(df_11)))
df_11$Target_3 <-Target_3

Target_4<- rep("4670",length(nrow(df_11)))
df_11$Target_4 <-Target_4

Population<- rep("2335183",length(nrow(df_11)))
df_11$Population <-Population

#12

Target_1<- rep("105",length(nrow(df_12)))
df_12$Target_1 <-Target_1

Target_2<- rep("2102",length(nrow(df_12)))
df_12$Target_2 <-Target_2

Target_3<- rep("3154",length(nrow(df_12)))
df_12$Target_3 <-Target_3

Target_4<- rep("4205",length(nrow(df_12)))
df_12$Target_4 <-Target_4

Population<- rep("2102415",length(nrow(df_12)))
df_12$Population <-Population

#13

Target_1<- rep("105",length(nrow(df_13)))
df_13$Target_1 <-Target_1

Target_2<- rep("2099",length(nrow(df_13)))
df_13$Target_2 <-Target_2

Target_3<- rep("3149",length(nrow(df_13)))
df_13$Target_3 <-Target_3

Target_4<- rep("4199",length(nrow(df_13)))
df_13$Target_4 <-Target_4

Population<- rep("2099469",length(nrow(df_13)))
df_13$Population <-Population

#14

Target_1<- rep("58",length(nrow(df_14)))
df_14$Target_1 <-Target_1

Target_2<- rep("1157",length(nrow(df_14)))
df_14$Target_2 <-Target_2

Target_3<- rep("1736",length(nrow(df_14)))
df_14$Target_3 <-Target_3

Target_4<- rep("2314",length(nrow(df_14)))
df_14$Target_4 <-Target_4

Population<- rep("1157112",length(nrow(df_14)))
df_14$Population <-Population

#15

Target_1<- rep("92",length(nrow(df_15)))
df_15$Target_1 <-Target_1

Target_2<- rep("1840",length(nrow(df_15)))
df_15$Target_2 <-Target_2

Target_3<- rep("2760",length(nrow(df_15)))
df_15$Target_3 <-Target_3

Target_4<- rep("3680",length(nrow(df_15)))
df_15$Target_4 <-Target_4

Population<- rep("1840223",length(nrow(df_15)))
df_15$Population <-Population

#16

Target_1<- rep("88",length(nrow(df_16)))
df_16$Target_1 <-Target_1

Target_2<- rep("1759",length(nrow(df_16)))
df_16$Target_2 <-Target_2

Target_3<- rep("2639",length(nrow(df_16)))
df_16$Target_3 <-Target_3

Target_4<- rep("3518",length(nrow(df_16)))
df_16$Target_4 <-Target_4

Population<- rep("1759087",length(nrow(df_16)))
df_16$Population <-Population

#17

Target_1<- rep("149",length(nrow(df_17)))
df_17$Target_1 <-Target_1

Target_2<- rep("2976",length(nrow(df_17)))
df_17$Target_2 <-Target_2

Target_3<- rep("4465",length(nrow(df_17)))
df_17$Target_3 <-Target_3

Target_4<- rep("5953",length(nrow(df_17)))
df_17$Target_4 <-Target_4

Population<- rep("2976434",length(nrow(df_17)))
df_17$Population <-Population

#18

Target_1<- rep("28",length(nrow(df_18)))
df_18$Target_1 <-Target_1

Target_2<- rep("561",length(nrow(df_18)))
df_18$Target_2 <-Target_2

Target_3<- rep("841",length(nrow(df_18)))
df_18$Target_3 <-Target_3

Target_4<- rep("1122",length(nrow(df_18)))
df_18$Target_4 <-Target_4

Population<- rep("560797",length(nrow(df_18)))
df_18$Population <-Population

#19

Target_1<- rep("85",length(nrow(df_19)))
df_19$Target_1 <-Target_1

Target_2<- rep("1696",length(nrow(df_19)))
df_19$Target_2 <-Target_2

Target_3<- rep("2544",length(nrow(df_19)))
df_19$Target_3 <-Target_3

Target_4<- rep("3392",length(nrow(df_19)))
df_19$Target_4 <-Target_4

Population<- rep("1695959",length(nrow(df_19)))
df_19$Population <-Population

#20

Target_1<- rep("80",length(nrow(df_20)))
df_20$Target_1 <-Target_1

Target_2<- rep("1594",length(nrow(df_20)))
df_20$Target_2 <-Target_2

Target_3<- rep("2391",length(nrow(df_20)))
df_20$Target_3 <-Target_3

Target_4<- rep("3188",length(nrow(df_20)))
df_20$Target_4 <-Target_4

Population<- rep("1594147",length(nrow(df_20)))
df_20$Population <-Population

#21

Target_1<- rep("93",length(nrow(df_21)))
df_21$Target_1 <-Target_1

Target_2<- rep("1852",length(nrow(df_21)))
df_21$Target_2 <-Target_2

Target_3<- rep("2777",length(nrow(df_21)))
df_21$Target_3 <-Target_3

Target_4<- rep("3703",length(nrow(df_21)))
df_21$Target_4 <-Target_4

Population<- rep("1851525",length(nrow(df_21)))
df_21$Population <-Population

#22

Target_1<- rep("169",length(nrow(df_22)))
df_22$Target_1 <-Target_1

Target_2<- rep("3375",length(nrow(df_22)))
df_22$Target_2 <-Target_2

Target_3<- rep("5062",length(nrow(df_22)))
df_22$Target_3 <-Target_3

Target_4<- rep("6750",length(nrow(df_22)))
df_22$Target_4 <-Target_4

Population<- rep("3374961",length(nrow(df_22)))
df_22$Population <-Population

#23

Target_1<- rep("109",length(nrow(df_23)))
df_23$Target_1 <-Target_1

Target_2<- rep("2187",length(nrow(df_23)))
df_23$Target_2 <-Target_2

Target_3<- rep("3281",length(nrow(df_23)))
df_23$Target_3 <-Target_3

Target_4<- rep("4375",length(nrow(df_23)))
df_23$Target_4 <-Target_4

Population<- rep("2187486",length(nrow(df_23)))
df_23$Population <-Population

#24

Target_1<- rep("57",length(nrow(df_24)))
df_24$Target_1 <-Target_1

Target_2<- rep("1141",length(nrow(df_24)))
df_24$Target_2 <-Target_2

Target_3<- rep("1711",length(nrow(df_24)))
df_24$Target_3 <-Target_3

Target_4<- rep("2281",length(nrow(df_24)))
df_24$Target_4 <-Target_4

Population<- rep("1140574",length(nrow(df_24)))
df_24$Population <-Population

#25

Target_1<- rep("93",length(nrow(df_25)))
df_25$Target_1 <-Target_1

Target_2<- rep("1864",length(nrow(df_25)))
df_25$Target_2 <-Target_2

Target_3<- rep("2797",length(nrow(df_25)))
df_25$Target_3 <-Target_3

Target_4<- rep("3729",length(nrow(df_25)))
df_25$Target_4 <-Target_4

Population<- rep("1864370",length(nrow(df_25)))
df_25$Population <-Population

#26

Target_1<- rep("139",length(nrow(df_26)))
df_26$Target_1 <-Target_1

Target_2<- rep("2784",length(nrow(df_26)))
df_26$Target_2 <-Target_2

Target_3<- rep("4176",length(nrow(df_26)))
df_26$Target_3 <-Target_3

Target_4<- rep("5568",length(nrow(df_26)))
df_26$Target_4 <-Target_4

Population<- rep("2784099",length(nrow(df_26)))
df_26$Population <-Population

#27

Target_1<- rep("65",length(nrow(df_27)))
df_27$Target_1 <-Target_1

Target_2<- rep("1307",length(nrow(df_27)))
df_27$Target_2 <-Target_2

Target_3<- rep("1961",length(nrow(df_27)))
df_27$Target_3 <-Target_3

Target_4<- rep("2614",length(nrow(df_27)))
df_27$Target_4 <-Target_4

Population<- rep("1307243",length(nrow(df_27)))
df_27$Population <-Population

#28

Target_1<- rep("76",length(nrow(df_28)))
df_28$Target_1 <-Target_1

Target_2<- rep("1516",length(nrow(df_28)))
df_28$Target_2 <-Target_2

Target_3<- rep("2274",length(nrow(df_28)))
df_28$Target_3 <-Target_3

Target_4<- rep("3033",length(nrow(df_28)))
df_28$Target_4 <-Target_4

Population<- rep("1516250",length(nrow(df_28)))
df_28$Population <-Population

#29

Target_1<- rep("129",length(nrow(df_29)))
df_29$Target_1 <-Target_1

Target_2<- rep("2572",length(nrow(df_29)))
df_29$Target_2 <-Target_2

Target_3<- rep("3858",length(nrow(df_29)))
df_29$Target_3 <-Target_3

Target_4<- rep("5144",length(nrow(df_29)))
df_29$Target_4 <-Target_4

Population<- rep("2571844",length(nrow(df_29)))
df_29$Population <-Population

#30

Target_1<- rep("71",length(nrow(df_30)))
df_30$Target_1 <-Target_1

Target_2<- rep("1412",length(nrow(df_30)))
df_30$Target_2 <-Target_2

Target_3<- rep("2119",length(nrow(df_30)))
df_30$Target_3 <-Target_3

Target_4<- rep("2825",length(nrow(df_30)))
df_30$Target_4 <-Target_4

Population<- rep("1412445",length(nrow(df_30)))
df_30$Population <-Population



df=rbind(df_1,df_2,df_3,df_4,df_5,df_6,df_7,df_8,df_9,df_10,df_11,df_12,df_13,df_14,df_15,df_16,df_17,df_18,df_19,df_20,df_21,df_22,df_23,df_24,df_25,df_26,df_27,df_28,df_29,df_30)




#subsetting district wise
unique_district<- unique(df$District)
unique_district<- sort(unique_district)

for(j in seq(length(unique_district)))
{
  #j=5
  
  {
    df_new<- data.frame(District=character(),Date=character(),Total_Active = double(),Rate=double(),Target_1=double(),Target_2=double(),Target_3=double(),Target_4=double(),Population=double())
    
    sub_data <- subset(df,df$District==unique_district[j])
    sub_data$Active_cases=sub_data$`Total Active`
    
    {  for (i in seq(unique(nrow(sub_data)))) 
    {
      m1 <-sub_data$Active_cases[i+7]
      m2=(1/10+((sub_data$Active_cases[i+7]-sub_data$Active_cases[i])/(7*(sub_data$Active_cases[i+7]))))
      m3=((sub_data$Active_cases[i+7]-sub_data$Active_cases[i])/(7*(sub_data$Active_cases[i+7])))
      m4=sub_data$Date[i+7]
      m5=sub_data$Target_1[1]
      m6=sub_data$Target_2[1]
      m7=sub_data$Target_3[1]
      m8=sub_data$Target_4[1]
      m9=sub_data$Population[1]
      temp<- data.frame(unique_district[j],i,m4,m1,m2,m3,m5,m6,m7,m8,m9)
      df_new<- rbind(df_new,temp)
    }
    }
    names(df_new) <- c("District","No.","Date","Total Active","Rate","Rate-mu","Target_1","Target_2","Target_3","Target_4","Population")
    
    month_wise<-data.frame((format(df_new$Date,"%Y-%m")),df_new)
    names(month_wise) <- c("Month","District","No.","Date","Total Active","Rate","Rate-mu","Target_1","Target_2","Target_3","Target_4","Population")
    month_wise=na.omit(month_wise)
    month_wise$Rate[!is.finite(month_wise$Rate)]=0
    month_wise$`Rate-mu`[!is.finite(month_wise$`Rate-mu`)]=0
    
    ####now we predict for future times
    #future prediction
    df_a=subset(month_wise,month_wise$Date>as.Date.character(month_wise[nrow(month_wise),4]-6)&month_wise$Date<as.Date.character(month_wise[nrow(month_wise),4]+20))
    #estimate lamda(t)
    df_l<- data.frame(District=character(),Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),Target_1=double(),Target_2=double(),Target_3=double(),Target_4=double(),Population=double())
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
      m10=df_a$District[1]
      m11=df_a$Population[1]
      temp<- data.frame(i,m10,m1,m2,m3,m4,m5,m6,m7,m8,m9,m11)
      df_l<- rbind(df_l,temp)
    }
    names(df_l) <- c("No.","District","Date","Total Active","Rate","Rate-mu","categ","Target_1","Target_2","Target_3","Target_4","Population")
    df_l=na.omit(df_l)
    
    df_l_new<- data.frame(District=character(),Date=character(),Total_Active = double(),Rate=double(),Rate_mu=double(),categ=double(),predicted_active=double(),Target_1=double(),Target_2=double(),Target_3=double(),Target_4=double(),Population=double())
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
      m11=df_l$District[1]
      m12=df_l$Population[1]
      temp<- data.frame(i,m11,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m12)
      df_l_new<- rbind(df_l_new,temp)
    }
    
    names(df_l_new) <- c("No.","District","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases","Target_1","Target_2","Target_3","Target_4","Population")
    df_l_new=na.omit(df_l_new)
    
    ###start iterating with model  
    df_l_new[nrow(df_l_new)+10000,] <- NA
    
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
        df_l_new$model[i]=df_l_new$`Total Active`[1]
      if(i>1)
        df_l_new$model[i]<-df_l_new$model[i-1]*(1+(df_l_new$categ[1]-0.1))
    }
    
    df_l_new$model=floor(df_l_new$model)
    
    df_l_month<-data.frame((format(df_l_new$Date,"%Y-%m")),df_l_new)
    names(df_l_month) <- c("Month","No.","District","Date","Total Active","Rate","Rate-mu","categ","Predicted_Active_Cases_by_data","Target_1","Target_2","Target_3","Target_4","Population","model_generated")
    
    ###take days count    
    x1=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_1[1]))
    x2=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_2[1]))
    x3=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_3[1]))
    x4=subset(df_l_new,df_l_new$model>as.integer(df_l_new$Target_4[1]))
    
    y=c(x1[1,1],x2[1,1],x3[1,1],x4[1,1])
    
    
    df_days<- data.frame(District=character(),Date=character(),Total_Active = double(),Rate=double(),categ=double(),Days_Target_1=double(),Days_Target_2=double(),Days_Target_3=double(),Days_Target_4=double(),Population=double())
    m1=df_l_month$Date[1]
    m2=df_l_month$`Total Active`[1]
    m4=df_l_month$categ[1]
    m5=y[1]
    m6=y[2]
    m7=y[3]
    m8=y[4]
    m9=df_l$Population[1]
    temp<- data.frame(unique_district[j],m1,m2,m4,m5,m6,m7,m8,m9)
    df_days<- rbind(df_days,temp)
    
    
  }
  
  names(df_days) <- c("District","Date","Current Active Cases","Rate(lamda-t)","Days to 50 per million cases","Days to 1000 per million cases","Days to 1500 per million cases","Days to 0.2% of population cases","Population")
  df_days[is.na(df_days)]<-" "  
  df_days=df_days[,c(1,9,2,3,4,5,6,7,8)]
  
  #Writing district data
  my_name_1 <- paste(j,"daystocritical",sep="-")
  my_name_2 <- paste(my_name_1,"csv",sep=".")
  my_name <- paste0("csv/critical/", my_name_2)
  write.csv(df_days, file = my_name, row.names=FALSE)
  
  
}