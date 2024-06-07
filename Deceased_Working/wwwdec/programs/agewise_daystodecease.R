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

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

#read data
data <- read.csv("mediadata/Master.csv")

#Converting character to date and then formatting it
data$DOA <- as.Date(data$DOA, format = "%Y-%m-%d")
data$DOA <- format(as.Date(data$DOA),"%Y-%m-%d")

data$DOD <- as.Date(data$DOD, format = "%Y-%m-%d")
data$DOD <- format(as.Date(data$DOD),"%Y-%m-%d")

data$`MB.Date` <- as.Date(data$`MB.Date`, format = "%Y-%m-%d")
data$`MB.Date` <- format(as.Date(data$`MB.Date`),"%Y-%m-%d")

#calculating differences between dates
data$Difference1=difftime(data$DOD,data$DOA,units = "days")
data$Difference2=difftime(data$`MB.Date`,data$DOD,units = "days")

#Create data frames:positive, negatives,na
data <- data[data$District != "Others",]
data <- data[data$District != "NA",]
negative=subset(data,as.numeric(data$Difference1)<0)
negative1=subset(data, as.numeric(data$Difference2)< 0)
positive=subset(data,(as.numeric(data$Difference1)>0&as.numeric(data$Difference2)>0))
positive1=subset(data, (as.numeric(data$Difference1)<=61 & as.numeric(data$Difference1)>0))
positive2=subset(data,(as.numeric(data$Difference2)<=91 & as.numeric(data$Difference2)>0))

#separating waves wrt dates for DOD-DOA & MB-DOD
positive$Difference3=difftime("2020-11-01",positive$`MB.Date`,units = "days")
positive$Difference4=difftime(positive$`MB.Date`,"2021-02-27",units = "days")
wave1=subset(positive,as.numeric(positive$Difference3)>0)
wave2=subset(positive,as.numeric(positive$Difference4)>0)
wave_1.5=subset(positive,as.numeric(positive$Difference4)<0&as.numeric(positive$Difference4>-118))

#create age frame
#Creating dataframes
df_0_10 <- positive[positive$Age.In.Years< 10,]
df_10_20 <- positive[positive$Age.In.Year>=10 & positive$Age.In.Year< 20,]
df_20_30 <- positive[positive$Age.In.Year>=20 & positive$Age.In.Year< 30,]
df_30_40 <- positive[positive$Age.In.Year>=30 & positive$Age.In.Year< 40,]
df_40_50 <- positive[positive$Age.In.Year>=40 & positive$Age.In.Year< 50,]
df_50_60 <- positive[positive$Age.In.Year>=50 & positive$Age.In.Year< 60,]
df_60_70 <- positive[positive$Age.In.Year>=60 & positive$Age.In.Year< 70,]
df_70_80 <- positive[positive$Age.In.Year>=70 & positive$Age.In.Year< 80,]
df_80_90 <- positive[positive$Age.In.Year>=80 & positive$Age.In.Year< 90,]


#Creating new columns to add age category feature
categ <- rep("0 - 10",length(nrow(df_0_10)))
df_0_10$categ <- categ
categ <- rep("10 - 20",length(nrow(df_10_20)))
df_10_20$categ <- categ
categ <- rep("20 - 30",length(nrow(df_20_30)))
df_20_30$categ <- categ
categ <- rep("30 - 40",length(nrow(df_30_40)))
df_30_40$categ <- categ
categ <- rep("40 - 50",length(nrow(df_40_50)))
df_40_50$categ <- categ
categ <- rep("50 - 60",length(nrow(df_50_60)))
df_50_60$categ <- categ
categ <- rep("60 - 70",length(nrow(df_60_70)))
df_60_70$categ <- categ
categ <- rep("70 - 80",length(nrow(df_70_80)))
df_70_80$categ <- categ
categ <- rep("80 - 90",length(nrow(df_80_90)))
df_80_90$categ <- categ


#final data frame

df_new=rbind(df_0_10,df_10_20,df_20_30,df_30_40,df_40_50,df_50_60,df_60_70,df_70_80,df_80_90)
df_new[is.na(df_new)]=0

colnames(df_new)[17]="Age Category"
colnames(df_new)[13]="Days to Decease"

#Box-plot age to days to decease
box_age_decease<- ggplot(df_new,aes(x=`Age Category`,y=`Days to Decease`,col=`Age Category`)) + geom_boxplot(outlier.colour = NULL)+theme_minimal() + scale_fill_viridis(discrete = TRUE) + ggtitle("Days to Decease Age wise") + xlab("Age interval") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 34),plot.title = element_text(color = "#D55E00",face = "bold", size = 40),axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28)) + scale_y_continuous(name = "Days to Decease",breaks = seq(0,120,10),limits = c(0,120))
box_age_decease_gp=ggplotly(box_age_decease)

#save box_age_decease
###NAME OF PNGFILE
name1 = paste("box_age_decease","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/agewise/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=box_age_decease ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("box_age_decease","html", sep=".")
path <- file.path(getwd(), "graphs/agewise/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(box_age_decease_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

scat_death_age<- ggplot(df_new,aes(x=`Days to Decease`,color=`Age Category`)) + geom_point(stat="count")+theme_minimal() + scale_fill_viridis(discrete = TRUE) + ggtitle("Days to Decease age-wise") + xlab("Days") + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34)) + scale_y_continuous(name = "Number of deceased")
scat_death_age_gp=ggplotly(scat_death_age)

#save scat_death_age
###NAME OF PNGFILE
name1 = paste("scat_death_age","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/agewise/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=scat_death_age ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scat_death_age","html", sep=".")
path <- file.path(getwd(), "graphs/agewise/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(scat_death_age_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#ci age days to decease
age_days <- data.frame(Age_Cat = character(),cnt_days = integer(),t_days = double(),Mean_days = double(), variance_days = double(), sd_days = double())
unique_agecategory_names<- unique(df_new$`Age Category`)
unique_agecategory_names<- sort(unique_agecategory_names)

for(i in seq(length(unique_agecategory_names)))
{
  sub_data_days <- subset(df_new,df_new$`Age Category`==unique_agecategory_names[i])
  w1_n_wd <- nrow(sub_data_days)
  t_w1_wd <- round(qt(0.05/2, w1_n_wd-1,lower.tail = FALSE),3)
  t1_wd <- round(mean(sub_data_days$`Days to Decease`),3)
  t2_wd <- round(var(sub_data_days$`Days to Decease`),3)
  t3_wd <- round(sqrt(t2_wd),3)
  temp_days <- data.frame(unique_agecategory_names[i],w1_n_wd,t_w1_wd,t1_wd,t2_wd,t3_wd)
  age_days <- rbind(age_days,temp_days)
}
names(age_days) <- c("Age Category","Total Counts","t_days","Mean_days", "variance_days", "sd_days")
#age_days=age_days%>% arrange(Mean_days) %>% mutate(`Age Category`=factor(`Age Category`, levels=`Age Category`)) 
age_days[is.na(age_days)]=0

#t-interval
age_days_t<- ggplot(age_days,aes(x =`Age Category`,y =Mean_days)) + geom_pointrange(aes(x = `Age Category`, ymin = Mean_days - ((t_days*sd_days)/round(sqrt(`Total Counts`))), ymax = Mean_days + ((t_days*sd_days)/round(sqrt(`Total Counts`)))),color="#0072B2",size=1)+theme_minimal() + xlab("Age Category") + ylab("Days to Decease") + ggtitle("Age-wise Days to decease") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=24,color = '#D55E00'),axis.title.y = element_text(size=24,color = '#D55E00'),plot.title = element_text(face="bold",size=40,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = age_days, aes(label = Mean_days))
age_days_p<- ggplot(age_days,aes(x =`Age Category`,y =Mean_days)) + geom_pointrange(aes(x = `Age Category`, ymin = Mean_days - ((t_days*sd_days)/round(sqrt(`Total Counts`))), ymax = Mean_days + ((t_days*sd_days)/round(sqrt(`Total Counts`)))),color="#0072B2",size=1)+theme_minimal() + xlab("Age Category") + ylab("Days to Decease") + ggtitle("Age-wise Days to decease") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=18,color = '#D55E00'),axis.title.y = element_text(size=18,color = '#D55E00'),plot.title = element_text(face="bold",size=30,color = '#D55E00')) + geom_point(show.legend = FALSE) + geom_text(data = age_days, aes(label = Mean_days))
age_days_t_gp=ggplotly(age_days_p)

#save age_days_t
###NAME OF PNGFILE
name1 = paste("age_days_t","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/agewise/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=age_days_t ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("age_days_t","html", sep=".")
path <- file.path(getwd(), "graphs/agewise/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(age_days_t_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#Separating male female wise

df_0_10_m=subset(df_0_10,df_0_10$Sex=="Male")
df_0_10_f=subset(df_0_10,df_0_10$Sex=="Female")
df_10_20_m=subset(df_10_20,df_10_20$Sex=="Male")
df_10_20_f=subset(df_10_20,df_10_20$Sex=="Female")
df_20_30_m=subset(df_20_30,df_20_30$Sex=="Male")
df_20_30_f=subset(df_20_30,df_20_30$Sex=="Female")
df_30_40_m=subset(df_30_40,df_30_40$Sex=="Male")
df_30_40_f=subset(df_30_40,df_30_40$Sex=="Female")
df_40_50_m=subset(df_40_50,df_40_50$Sex=="Male")
df_40_50_f=subset(df_40_50,df_40_50$Sex=="Female")
df_50_60_m=subset(df_50_60,df_50_60$Sex=="Male")
df_50_60_f=subset(df_50_60,df_50_60$Sex=="Female")
df_60_70_m=subset(df_60_70,df_60_70$Sex=="Male")
df_60_70_f=subset(df_60_70,df_60_70$Sex=="Female")
df_70_80_m=subset(df_70_80,df_70_80$Sex=="Male")
df_70_80_f=subset(df_70_80,df_70_80$Sex=="Female")
df_80_90_m=subset(df_80_90,df_80_90$Sex=="Male")
df_80_90_f=subset(df_80_90,df_80_90$Sex=="Female")

#Creating new columns to add age gender category feature
categ <- rep("0 - 10(M)",length(nrow(df_0_10_m)))
df_0_10_m$categ <- categ

categ <- rep("0 - 10(F)",length(nrow(df_0_10_f)))
df_0_10_f$categ <- categ

categ <- rep("10 - 20(M)",length(nrow(df_10_20_m)))
df_10_20_m$categ <- categ

categ <- rep("10 - 20(F)",length(nrow(df_10_20_f)))
df_10_20_f$categ <- categ

categ <- rep("20 - 30(M)",length(nrow(df_20_30_m)))
df_20_30_m$categ <- categ

categ <- rep("20 - 30(F)",length(nrow(df_20_30_f)))
df_20_30_f$categ <- categ

categ <- rep("30 - 40(M)",length(nrow(df_30_40_m)))
df_30_40_m$categ <- categ

categ <- rep("30 - 40(F)",length(nrow(df_30_40_f)))
df_30_40_f$categ <- categ

categ <- rep("40 - 50(M)",length(nrow(df_40_50_m)))
df_40_50_m$categ <- categ

categ <- rep("40 - 50(F)",length(nrow(df_40_50_f)))
df_40_50_f$categ <- categ

categ <- rep("50 - 60(M)",length(nrow(df_50_60_m)))
df_50_60_m$categ <- categ

categ <- rep("50 - 60(F)",length(nrow(df_50_60_f)))
df_50_60_f$categ <- categ

categ <- rep("60 - 70(M)",length(nrow(df_60_70_m)))
df_60_70_m$categ <- categ

categ <- rep("60 - 70(F)",length(nrow(df_60_70_f)))
df_60_70_f$categ <- categ

categ <- rep("70 - 80(M)",length(nrow(df_70_80_m)))
df_70_80_m$categ <- categ

categ <- rep("70 - 80(F)",length(nrow(df_70_80_f)))
df_70_80_f$categ <- categ

categ <- rep("80 - 90(M)",length(nrow(df_80_90_m)))
df_80_90_m$categ <- categ

categ <- rep("80 - 90(F)",length(nrow(df_80_90_f)))
df_80_90_f$categ <- categ

#Final data frame for age-gebder days to decease
df_new_m=rbind(df_0_10_m,df_10_20_m,df_20_30_m,df_30_40_m,df_40_50_m,df_50_60_m,df_60_70_m,df_70_80_m,df_80_90_m)
df_new_m[is.na(df_new_m)]=0
df_new_f=rbind(df_0_10_f,df_10_20_f,df_20_30_f,df_30_40_f,df_40_50_f,df_50_60_f,df_60_70_f,df_70_80_f,df_80_90_f)
df_new_f[is.na(df_new_f)]=0

#overall
df_new_age=rbind(df_0_10_m,df_0_10_f,df_10_20_m,df_10_20_f,df_20_30_m,df_20_30_f,df_30_40_m,df_30_40_f,df_40_50_m,df_40_50_f,df_50_60_m,df_50_60_f,df_60_70_m,df_60_70_f,df_70_80_m,df_70_80_f,df_80_90_m,df_80_90_f)
df_new_age[is.na(df_new_age)]=0

#Naming col
colnames(df_new_m)[17]="Age-Gender Category"
colnames(df_new_m)[13]="Days to Decease"

colnames(df_new_f)[17]="Age-Gender Category"
colnames(df_new_f)[13]="Days to Decease"

colnames(df_new_age)[17]="Age-Gender Category"
colnames(df_new_age)[13]="Days to Decease"

#plot boxplot
box_age_gender_decease<- ggplot(df_new_age,aes(x=`Age-Gender Category`,y=`Days to Decease`,col=Sex)) + geom_boxplot(outlier.colour = NULL)+theme_minimal() + scale_fill_viridis(discrete = TRUE) + ggtitle("Days to Decease Age-Gender wise") + xlab("Age-Gender interval") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 34),plot.title = element_text(color = "#D55E00",face = "bold", size = 40),axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28)) + scale_y_continuous(name = "Days to Decease",breaks = seq(0,120,10),limits = c(0,120))
box_age_gender_decease_gp=ggplotly(box_age_gender_decease)

#save box_age_gender_decease
###NAME OF PNGFILE
name1 = paste("box_age_gender_decease","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/agewise/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=box_age_gender_decease ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("box_age_gender_decease","html", sep=".")
path <- file.path(getwd(), "graphs/agewise/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(box_age_gender_decease_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#try scatter

scat_death_age_gender<- ggplot(df_new_age,aes(x=`Days to Decease`,color=`Age-Gender Category`)) + geom_point(stat="count")+theme_minimal() + scale_fill_viridis(discrete = TRUE) + ggtitle("Days to Decease Age-Gender-wise") + xlab("Days") + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34)) + scale_y_continuous(name = "Number of deceased")
scat_death_age_gender_gp=ggplotly(scat_death_age_gender)

#save scat_death_age_gender
###NAME OF PNGFILE
name1 = paste("scat_death_age_gender","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/agewise/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=scat_death_age_gender ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scat_death_age_gender","html", sep=".")
path <- file.path(getwd(), "graphs/agewise/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(scat_death_age_gender_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#ci age-gender days to decease
age_ag_days <- data.frame(Age_gender_Cat = character(),cnt_ag_days = integer(),t_ag_days = double(),Mean_ag_days = double(), variance_ag_days = double(), sd_ag_days = double())
unique_agegendercategory_names<- unique(df_new_age$`Age-Gender Category`)
unique_agegendercategory_names<- sort(unique_agegendercategory_names)

for(i in seq(length(unique_agegendercategory_names)))
{
  sub_data_ag_days <- subset(df_new_age,df_new_age$`Age-Gender Category`==unique_agegendercategory_names[i])
  w1_n_wd_ag <- nrow(sub_data_ag_days)
  t_w1_wd_ag <- round(qt(0.05/2, w1_n_wd_ag-1,lower.tail = FALSE),3)
  t1_wd_ag <- round(mean(sub_data_ag_days$`Days to Decease`),3)
  t2_wd_ag <- round(var(sub_data_ag_days$`Days to Decease`),3)
  t3_wd_ag <- round(sqrt(t2_wd_ag),3)
  temp_days_ag <- data.frame(unique_agegendercategory_names[i],w1_n_wd_ag,t_w1_wd_ag,t1_wd_ag,t2_wd_ag,t3_wd_ag)
  age_ag_days <- rbind(age_ag_days,temp_days_ag)
}
names(age_ag_days) <- c("Age-Gender Category","Total Counts","t_days","Mean_days", "variance_days", "sd_days")
#age_ag_days=age_ag_days%>% arrange(Mean_days) %>% mutate(`Age-Gender Category`=factor(`Age-Gender Category`, levels=`Age-Gender Category`)) 
age_ag_days[is.na(age_ag_days)]=0

df_age_0_10_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="0 - 10(F)")
df_age_0_10_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="0 - 10(M)")
df_age_10_20_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="10 - 20(F)")
df_age_10_20_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="10 - 20(M)")
df_age_20_30_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="20 - 30(F)")
df_age_20_30_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="20 - 30(M)")
df_age_30_40_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="30 - 40(F)")
df_age_30_40_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="30 - 40(M)")
df_age_40_50_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="40 - 50(F)")
df_age_40_50_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="40 - 50(M)")
df_age_50_60_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="50 - 60(F)")
df_age_50_60_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="50 - 60(M)")
df_age_60_70_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="60 - 70(F)")
df_age_60_70_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="60 - 70(M)")
df_age_70_80_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="70 - 80(F)")
df_age_70_80_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="70 - 80(M)")
df_age_80_90_f=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="80 - 90(F)")
df_age_80_90_m=subset(age_ag_days,age_ag_days$`Age-Gender Category`=="80 - 90(M)")



#Creating new columns to add age gender category feature
categ <- rep("Female",length(nrow(df_age_0_10_f)))
df_age_0_10_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_0_10_m)))
df_age_0_10_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_10_20_f)))
df_age_10_20_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_10_20_m)))
df_age_10_20_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_20_30_f)))
df_age_20_30_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_20_30_m)))
df_age_20_30_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_30_40_f)))
df_age_30_40_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_30_40_m)))
df_age_30_40_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_40_50_f)))
df_age_40_50_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_40_50_m)))
df_age_40_50_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_50_60_f)))
df_age_50_60_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_50_60_m)))
df_age_50_60_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_60_70_f)))
df_age_60_70_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_60_70_m)))
df_age_60_70_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_70_80_f)))
df_age_70_80_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_70_80_m)))
df_age_70_80_m$categ <- categ

categ <- rep("Female",length(nrow(df_age_80_90_f)))
df_age_80_90_f$categ <- categ

categ <- rep("Male",length(nrow(df_age_80_90_m)))
df_age_80_90_m$categ <- categ


age_ag_days_new=rbind(df_age_0_10_m,df_age_0_10_f,df_age_10_20_m,df_age_10_20_f,df_age_20_30_m,df_age_20_30_f,df_age_30_40_m,df_age_30_40_f,df_age_40_50_m,df_age_40_50_f,df_age_50_60_m,df_age_50_60_f,df_age_60_70_m,df_age_60_70_f,df_age_70_80_m,df_age_70_80_f,df_age_80_90_m,df_age_80_90_f)
colnames(age_ag_days_new)[7]="Gender"

#t-interval
age_ag_days_t<- ggplot(age_ag_days_new,aes(x =`Age-Gender Category`,y =Mean_days)) + geom_pointrange(aes(x = `Age-Gender Category`, ymin = Mean_days - ((t_days*sd_days)/round(sqrt(`Total Counts`))), ymax = Mean_days + ((t_days*sd_days)/round(sqrt(`Total Counts`))),col=Gender),size=1)+theme_minimal() + xlab("Age-Gender Category") + ylab("Days to Decease") + ggtitle("Age-Gender-wise Days to decease") + theme(axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=24,color = '#D55E00'),axis.title.y = element_text(size=24,color = '#D55E00'),plot.title = element_text(face="bold",size=40,color = '#D55E00')) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = age_ag_days_new, aes(label = Mean_days))
age_ag_days_p<- ggplot(age_ag_days_new,aes(x =`Age-Gender Category`,y =Mean_days)) + geom_pointrange(aes(x = `Age-Gender Category`, ymin = Mean_days - ((t_days*sd_days)/round(sqrt(`Total Counts`))), ymax = Mean_days + ((t_days*sd_days)/round(sqrt(`Total Counts`))),col=Gender),size=1)+theme_minimal() + xlab("Age-Gender Category") + ylab("Days to Decease") + ggtitle("Age-Gender-wise Days to decease") + theme(axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=18,color = '#D55E00'),axis.title.y = element_text(size=18,color = '#D55E00'),plot.title = element_text(face="bold",size=30,color = '#D55E00')) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) + geom_point(show.legend = FALSE) + geom_text(data = age_ag_days_new, aes(label = Mean_days))
age_ag_days_t_gp=ggplotly(age_ag_days_p)

#save age_ag_days_t
###NAME OF PNGFILE
name1 = paste("age_ag_days_t","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/agewise/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=age_ag_days_t ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("age_ag_days_t","html", sep=".")
path <- file.path(getwd(), "graphs/agewise/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(age_ag_days_t_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#write csv
write.csv(x=age_ag_days_new,file="csv/age_ag_days_new.csv",row.names = FALSE)


#Only means for gender wise report
#ci age-gender days to report
age_ag_rep <- data.frame(Age_gender_Cat = character(),cnt_ag_days = integer(),t_ag_days = double(),Mean_ag_days = double(), variance_ag_days = double(), sd_ag_days = double())
unique_agegendercategory_names<- unique(df_new_age$`Age-Gender Category`)
unique_agegendercategory_names<- sort(unique_agegendercategory_names)

for(i in seq(length(unique_agegendercategory_names)))
{
  sub_data_ag_rep <- subset(df_new_age,df_new_age$`Age-Gender Category`==unique_agegendercategory_names[i])
  w1_n_wd_ag <- nrow(sub_data_ag_rep)
  t_w1_wd_ag <- round(qt(0.05/2, w1_n_wd_ag-1,lower.tail = FALSE),3)
  t1_wd_ag <- round(mean(sub_data_ag_rep$Difference2),3)
  t2_wd_ag <- round(var(sub_data_ag_rep$Difference2),3)
  t3_wd_ag <- round(sqrt(t2_wd_ag),3)
  temp_rep<- data.frame(unique_agegendercategory_names[i],w1_n_wd_ag,t_w1_wd_ag,t1_wd_ag,t2_wd_ag,t3_wd_ag)
  age_ag_rep <- rbind(age_ag_rep,temp_rep)
}
names(age_ag_rep) <- c("Age-Gender Category","Total Counts","t_days","Mean_days", "variance_days", "sd_days")
#age_ag_rep=age_ag_rep%>% arrange(Mean_days) %>% mutate(`Age-Gender Category`=factor(`Age-Gender Category`, levels=`Age-Gender Category`)) 
age_ag_rep[is.na(age_ag_rep)]=0

#adding gender

df_rep_0_10_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="0 - 10(F)")
df_rep_0_10_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="0 - 10(M)")
df_rep_10_20_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="10 - 20(F)")
df_rep_10_20_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="10 - 20(M)")
df_rep_20_30_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="20 - 30(F)")
df_rep_20_30_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="20 - 30(M)")
df_rep_30_40_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="30 - 40(F)")
df_rep_30_40_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="30 - 40(M)")
df_rep_40_50_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="40 - 50(F)")
df_rep_40_50_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="40 - 50(M)")
df_rep_50_60_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="50 - 60(F)")
df_rep_50_60_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="50 - 60(M)")
df_rep_60_70_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="60 - 70(F)")
df_rep_60_70_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="60 - 70(M)")
df_rep_70_80_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="70 - 80(F)")
df_rep_70_80_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="70 - 80(M)")
df_rep_80_90_f=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="80 - 90(F)")
df_rep_80_90_m=subset(age_ag_rep,age_ag_rep$`Age-Gender Category`=="80 - 90(M)")



#Creating new columns to add age gender category feature
categ <- rep("Female",length(nrow(df_rep_0_10_f)))
df_rep_0_10_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_0_10_m)))
df_rep_0_10_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_10_20_f)))
df_rep_10_20_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_10_20_m)))
df_rep_10_20_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_20_30_f)))
df_rep_20_30_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_20_30_m)))
df_rep_20_30_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_30_40_f)))
df_rep_30_40_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_30_40_m)))
df_rep_30_40_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_40_50_f)))
df_rep_40_50_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_40_50_m)))
df_rep_40_50_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_50_60_f)))
df_rep_50_60_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_50_60_m)))
df_rep_50_60_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_60_70_f)))
df_rep_60_70_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_60_70_m)))
df_rep_60_70_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_70_80_f)))
df_rep_70_80_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_70_80_m)))
df_rep_70_80_m$categ <- categ

categ <- rep("Female",length(nrow(df_rep_80_90_f)))
df_rep_80_90_f$categ <- categ

categ <- rep("Male",length(nrow(df_rep_80_90_m)))
df_rep_80_90_m$categ <- categ


age_ag_rep_new=rbind(df_rep_0_10_m,df_rep_0_10_f,df_rep_10_20_m,df_rep_10_20_f,df_rep_20_30_m,df_rep_20_30_f,df_rep_30_40_m,df_rep_30_40_f,df_rep_40_50_m,df_rep_40_50_f,df_rep_50_60_m,df_rep_50_60_f,df_rep_60_70_m,df_rep_60_70_f,df_rep_70_80_m,df_rep_70_80_f,df_rep_80_90_m,df_rep_80_90_f)
colnames(age_ag_rep_new)[7]="Gender"



#t-interval
age_ag_rep_t<- ggplot(age_ag_rep_new,aes(x =`Age-Gender Category`,y =Mean_days)) + geom_pointrange(aes(x = `Age-Gender Category`, ymin = Mean_days - ((t_days*sd_days)/round(sqrt(`Total Counts`))), ymax = Mean_days + ((t_days*sd_days)/round(sqrt(`Total Counts`))),col=Gender),size=1)+theme_minimal() + xlab("Age-Gender Category") + ylab("Days to Report") + ggtitle("Age-Gender-wise Days to Report") + theme(axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=24,color = '#D55E00'),axis.title.y = element_text(size=24,color = '#D55E00'),plot.title = element_text(face="bold",size=40,color = '#D55E00')) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = age_ag_rep, aes(label = Mean_days))
age_ag_rep_p<- ggplot(age_ag_rep_new,aes(x =`Age-Gender Category`,y =Mean_days)) + geom_pointrange(aes(x = `Age-Gender Category`, ymin = Mean_days - ((t_days*sd_days)/round(sqrt(`Total Counts`))), ymax = Mean_days + ((t_days*sd_days)/round(sqrt(`Total Counts`))),col=Gender),size=1)+theme_minimal() + xlab("Age-Gender Category") + ylab("Days to Report") + ggtitle("Age-Gender-wise Days to Report") + theme(axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=18,color = '#D55E00'),axis.title.y = element_text(size=18,color = '#D55E00'),plot.title = element_text(face="bold",size=30,color = '#D55E00')) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) + geom_point(show.legend = FALSE) + geom_text(data = age_ag_rep, aes(label = Mean_days))
age_ag_rep_gp=ggplotly(age_ag_rep_p)

#save age_ag_rep_t
###NAME OF PNGFILE
name1 = paste("age_ag_rep_t","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/agewise/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=age_ag_rep_t ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("age_ag_rep_t","html", sep=".")
path <- file.path(getwd(), "graphs/agewise/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(age_ag_rep_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#write csv
write.csv(x=age_ag_rep_new,file="csv/age_ag_rep_new.csv",row.names = FALSE)



