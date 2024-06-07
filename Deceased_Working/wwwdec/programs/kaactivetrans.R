###############################################################################
## Title: Active cases data for dictrict in Karnataka                        ##
## Input: kadistactive.csv                                                   ##
## Output: csv/kaactivetrans.csv                                             ##
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

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")


#Read data
data<- read_csv("kadistactive.csv")

###i prefer tranpose dataframe
df_1=data[c(1,2),]
df_1=as.data.frame(t(df_1))
df_1=df_1[-c(1),]
names(df_1)=c("Date","Total Active")
State<- rep("Bagalkot",length(nrow(df_1)))
df_1$State <-State
df_1=df_1[,c(3,1,2)]

df_2=data[c(1,3),]
df_2=as.data.frame(t(df_2))
df_2=df_2[-c(1),]
names(df_2)=c("Date","Total Active")
State<- rep("Ballari",length(nrow(df_2)))
df_2$State <-State
df_2=df_2[,c(3,1,2)]


df_3=data[c(1,4),]
df_3=as.data.frame(t(df_3))
df_3=df_3[-c(1),]
names(df_3)=c("Date","Total Active")
State<- rep("Belgaum",length(nrow(df_3)))
df_3$State <-State
df_3=df_3[,c(3,1,2)]


df_4=data[c(1,5),]
df_4=as.data.frame(t(df_4))
df_4=df_4[-c(1),]
names(df_4)=c("Date","Total Active")
State<- rep("Bengaluru Rural",length(nrow(df_4)))
df_4$State <-State
df_4=df_4[,c(3,1,2)]

df_5=data[c(1,6),]
df_5=as.data.frame(t(df_5))
df_5=df_5[-c(1),]
names(df_5)=c("Date","Total Active")
State<- rep("Bengaluru Urban",length(nrow(df_5)))
df_5$State <-State
df_5=df_5[,c(3,1,2)]

df_6=data[c(1,7),]
df_6=as.data.frame(t(df_6))
df_6=df_6[-c(1),]
names(df_6)=c("Date","Total Active")
State<- rep("Bidar",length(nrow(df_6)))
df_6$State <-State
df_6=df_6[,c(3,1,2)]


df_7=data[c(1,8),]
df_7=as.data.frame(t(df_7))
df_7=df_7[-c(1),]
names(df_7)=c("Date","Total Active")
State<- rep("Chamarajanagar",length(nrow(df_7)))
df_7$State <-State
df_7=df_7[,c(3,1,2)]


df_8=data[c(1,9),]
df_8=as.data.frame(t(df_8))
df_8=df_8[-c(1),]
names(df_8)=c("Date","Total Active")
State<- rep("Chikkaballapur",length(nrow(df_8)))
df_8$State <-State
df_8=df_8[,c(3,1,2)]


df_9=data[c(1,10),]
df_9=as.data.frame(t(df_9))
df_9=df_9[-c(1),]
names(df_9)=c("Date","Total Active")
State<- rep("Chikmagalur",length(nrow(df_9)))
df_9$State <-State
df_9=df_9[,c(3,1,2)]


df_10=data[c(1,11),]
df_10=as.data.frame(t(df_10))
df_10=df_10[-c(1),]
names(df_10)=c("Date","Total Active")
State<- rep("Chitradurga",length(nrow(df_10)))
df_10$State <-State
df_10=df_10[,c(3,1,2)]

df_11=data[c(1,12),]
df_11=as.data.frame(t(df_11))
df_11=df_11[-c(1),]
names(df_11)=c("Date","Total Active")
State<- rep("Dakshina Kannada",length(nrow(df_11)))
df_11$State <-State
df_11=df_11[,c(3,1,2)]

df_12=data[c(1,13),]
df_12=as.data.frame(t(df_12))
df_12=df_12[-c(1),]
names(df_12)=c("Date","Total Active")
State<- rep("Davanagere",length(nrow(df_12)))
df_12$State <-State
df_12=df_12[,c(3,1,2)]

df_13=data[c(1,14),]
df_13=as.data.frame(t(df_13))
df_13=df_13[-c(1),]
names(df_13)=c("Date","Total Active")
State<- rep("Dharwad",length(nrow(df_13)))
df_13$State <-State
df_13=df_13[,c(3,1,2)]

df_14=data[c(1,15),]
df_14=as.data.frame(t(df_14))
df_14=df_14[-c(1),]
names(df_14)=c("Date","Total Active")
State<- rep("Gadag",length(nrow(df_14)))
df_14$State <-State
df_14=df_14[,c(3,1,2)]

df_15=data[c(1,16),]
df_15=as.data.frame(t(df_15))
df_15=df_15[-c(1),]
names(df_15)=c("Date","Total Active")
State<- rep("Hassan",length(nrow(df_15)))
df_15$State <-State
df_15=df_15[,c(3,1,2)]

df_16=data[c(1,17),]
df_16=as.data.frame(t(df_16))
df_16=df_16[-c(1),]
names(df_16)=c("Date","Total Active")
State<- rep("Haveri",length(nrow(df_16)))
df_16$State <-State
df_16=df_16[,c(3,1,2)]

df_17=data[c(1,18),]
df_17=as.data.frame(t(df_17))
df_17=df_17[-c(1),]
names(df_17)=c("Date","Total Active")
State<- rep("Kalaburagi",length(nrow(df_17)))
df_17$State <-State
df_17=df_17[,c(3,1,2)]


df_18=data[c(1,19),]
df_18=as.data.frame(t(df_18))
df_18=df_18[-c(1),]
names(df_18)=c("Date","Total Active")
State<- rep("Kodagu",length(nrow(df_18)))
df_18$State <-State
df_18=df_18[,c(3,1,2)]


df_19=data[c(1,20),]
df_19=as.data.frame(t(df_19))
df_19=df_19[-c(1),]
names(df_19)=c("Date","Total Active")
State<- rep("Kolar",length(nrow(df_19)))
df_19$State <-State
df_19=df_19[,c(3,1,2)]


df_20=data[c(1,21),]
df_20=as.data.frame(t(df_20))
df_20=df_20[-c(1),]
names(df_20)=c("Date","Total Active")
State<- rep("Koppal",length(nrow(df_20)))
df_20$State <-State
df_20=df_20[,c(3,1,2)]

df_21=data[c(1,22),]
df_21=as.data.frame(t(df_21))
df_21=df_21[-c(1),]
names(df_21)=c("Date","Total Active")
State<- rep("Mandya",length(nrow(df_21)))
df_21$State <-State
df_21=df_21[,c(3,1,2)]

df_22=data[c(1,23),]
df_22=as.data.frame(t(df_22))
df_22=df_22[-c(1),]
names(df_22)=c("Date","Total Active")
State<- rep("Mysuru",length(nrow(df_22)))
df_22$State <-State
df_22=df_22[,c(3,1,2)]

df_23=data[c(1,24),]
df_23=as.data.frame(t(df_23))
df_23=df_23[-c(1),]
names(df_23)=c("Date","Total Active")
State<- rep("Raichur",length(nrow(df_23)))
df_23$State <-State
df_23=df_23[,c(3,1,2)]

df_24=data[c(1,25),]
df_24=as.data.frame(t(df_24))
df_24=df_24[-c(1),]
names(df_24)=c("Date","Total Active")
State<- rep("Ramanagar",length(nrow(df_24)))
df_24$State <-State
df_24=df_24[,c(3,1,2)]

df_25=data[c(1,26),]
df_25=as.data.frame(t(df_25))
df_25=df_25[-c(1),]
names(df_25)=c("Date","Total Active")
State<- rep("Shivamogga",length(nrow(df_25)))
df_25$State <-State
df_25=df_25[,c(3,1,2)]

df_26=data[c(1,27),]
df_26=as.data.frame(t(df_26))
df_26=df_26[-c(1),]
names(df_26)=c("Date","Total Active")
State<- rep("Tumakuru",length(nrow(df_26)))
df_26$State <-State
df_26=df_26[,c(3,1,2)]


df_27=data[c(1,28),]
df_27=as.data.frame(t(df_27))
df_27=df_27[-c(1),]
names(df_27)=c("Date","Total Active")
State<- rep("Udupi",length(nrow(df_27)))
df_27$State <-State
df_27=df_27[,c(3,1,2)]

df_28=data[c(1,29),]
df_28=as.data.frame(t(df_28))
df_28=df_28[-c(1),]
names(df_28)=c("Date","Total Active")
State<- rep("Uttara Kannada",length(nrow(df_28)))
df_28$State <-State
df_28=df_28[,c(3,1,2)]

df_29=data[c(1,30),]
df_29=as.data.frame(t(df_29))
df_29=df_29[-c(1),]
names(df_29)=c("Date","Total Active")
State<- rep("Vijayapura",length(nrow(df_29)))
df_29$State <-State
df_29=df_29[,c(3,1,2)]

df_30=data[c(1,31),]
df_30=as.data.frame(t(df_30))
df_30=df_30[-c(1),]
names(df_30)=c("Date","Total Active")
State<- rep("Yadgir",length(nrow(df_30)))
df_30$State <-State
df_30=df_30[,c(3,1,2)]

df=rbind(df_1,df_2,df_3,df_4,df_5,df_6,df_7,df_8,df_9,df_10,df_11,df_12,df_13,df_14,df_15,df_16,df_17,df_18,df_19,df_20,df_21,df_22,df_23,df_24,df_25,df_26,df_27,df_28,df_29,df_30)
names(df)=c("District","Date","Total Active")

#Writing district data
my_name_1 <- paste("kaactivetrans",sep="-")
my_name_2 <- paste(my_name_1,"csv",sep=".")
my_name <- paste0("csv/", my_name_2)
write.csv(df, file = my_name, row.names=FALSE)

