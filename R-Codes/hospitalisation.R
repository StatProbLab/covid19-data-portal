###############################################################################
## Title: Hospitalization Rates in Karnataka by District and Wave            ##
## Input: mediadata/Master.csv                                                   ##
## Output: Multiple files                                                    ##
## Date Modified: 22nd May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

#Include libraries
library(readxl)
library(lubridate)
library(ggplot2)
library(dplyr)
library(stringr)
library(viridis)
library(plotly)
library(readr)

#Read Data
data<- read_csv("mediadata/Master.csv")
#calculating differences between dates
data$Difference1=difftime(data$DOD,data$DOA,units = "days")
data$Difference2=difftime(data$`MB.Date`,data$DOD,units = "days")

#Data frames to draw waves
data <- data[data$District != "Others",]
data <- data[data$District != "NA",]
#designing data frame
req_dist=subset(data,as.numeric(data$Difference2)>0)

#Mutate notes
req_dist=req_dist %>%
  mutate(Death = case_when(
    req_dist$Notes %in% "Brought dead" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "Brought Dead" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "Died at her residence" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "Died at his residence" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "Died at his residence on" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "Died at residence" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "Not hospitalized" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "01-08-2020" ~ "NOT HOSPITALISED",
    req_dist$Notes %in% "NA" ~ "HOSPITALISED",
    req_dist$Notes %in% NA ~ "HOSPITALISED",
  ))

#separating waves wrt dates for DOD-DOA & MB-DOD
req_dist$Difference3=difftime("2020-11-01",req_dist$`MB.Date`,units = "days")
req_dist$Difference4=difftime(req_dist$`MB.Date`,"2021-02-27",units = "days")
wave1=subset(req_dist,as.numeric(req_dist$Difference3)>0)
wave2=subset(req_dist,as.numeric(req_dist$Difference4)>0&as.numeric(req_dist$Difference4<155))
wave_1.5=subset(req_dist,as.numeric(req_dist$Difference4)<0&as.numeric(req_dist$Difference4>-118))

#Wave wise ration of hospitalisation each district.
wave_ratio=data.frame(District = character(),w1_total_death = integer(),w1_hospitalised=integer(),w1_hospitalisation_ratio = double(),w2_total_death=integer(),w2_hospitalised=integer(),w2_hospitalisation_ratio=double())
unique_district_names_waves <- unique(req_dist$District)
unique_district_names_waves <- sort(unique_district_names_waves)

for(i in seq(length(unique_district_names_waves)))
{ 
  #i=5
  sub_data_w1<-subset(wave1,wave1$District==unique_district_names_waves[i])
  t1=sum(table(sub_data_w1$Death))
  t2=table(sub_data_w1$Death)[1]
  t3=round(t2/t1,3)
  sub_data_w2<-subset(wave2,wave2$District==unique_district_names_waves[i])
  n1=sum(table(sub_data_w2$Death))
  n2=table(sub_data_w2$Death)[1]
  n3=round(n2/n1,3)
  temp <- data.frame(unique_district_names_waves[i],t1,t2,t3,n1,n2,n3)
  wave_ratio<- rbind(wave_ratio,temp)
}
names(wave_ratio)=c("District","w1_total_death","w1_hospitalised","w1_hospitalisation_ratio","w2_total_death","w2_hospitalised","w2_hospitalisation_ratio")

wave_scat_ratio=ggplot(wave_ratio,aes(x=w1_hospitalisation_ratio,y=w2_hospitalisation_ratio,color=w1_total_death+w2_total_death,size=w1_total_death+w2_total_death))+geom_point()+geom_abline(intercept = 0,slope = 1,col="red")+theme_minimal()+xlab("Wave 1-Ratio")+ylab("Wave 2-Ratio")+ggtitle("Hospitalisation Ratio-Karnataka") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00"))+scale_colour_viridis_c(option = "H")+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+ggrepel::geom_text_repel(data=wave_ratio,aes(label=District),size=4)+coord_fixed()
wave_scat_ratio_p=ggplot(wave_ratio,aes(x=w1_hospitalisation_ratio,y=w2_hospitalisation_ratio,color=w1_total_death+w2_total_death,size=w1_total_death+w2_total_death))+geom_point()+geom_abline(intercept = 0,slope = 1,col="red")+theme_minimal()+xlab("Wave 1-Ratio")+ylab("Wave 2-Ratio")+ggtitle("Hospitalisation Ratio-Karnataka") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00"))+scale_colour_viridis_c(option = "H")+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+geom_text(data=wave_ratio,aes(label=District),size=4)+coord_fixed()
wave_scat_ratio_gp<- ggplotly(wave_scat_ratio_p, tooltip = c("x","y","size","label"))

#save wave ratio csv
write.csv(x=wave_ratio,file = "csv/wave_ratio.csv",row.names = FALSE)

#save wave_scat_ratio
###NAME OF PNGFILE
name1 = paste("wavewise_hospitalisation_ratio","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/hospitalization/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=wave_scat_ratio ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("wavewise_hospitalisation_ratio","html", sep=".")
path <- file.path(getwd(), "graphs/hospitalization/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(wave_scat_ratio_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")


#we do scatter ratio dist wise
req_dist=req_dist[,c(2,11,15)]
#Format Date df
req_dist$MB.Date<- as.Date(req_dist$MB.Date, format ="%Y-%m-%d")

#add month
month_wise<-data.frame((format(req_dist$MB.Date,"%Y-%m")),req_dist)
names(month_wise) <- c("Month","District","Date","POD")
month_wise=month_wise[,c(1,2,4)]

#Dividing by districts
unique_district<- unique(month_wise$District)
unique_district<- sort(unique_district)
for(j in seq(length(unique_district)))
{  
#j=5
monthly<- data.frame(District=character(),Month=character(),Total_Death = double(), Hospitalised = double(),Ratio_of_Hospitalised=double())
sub_data<- subset(month_wise,month_wise$District==unique_district[j])
unique_month=unique(sub_data$Month)
unique_month=sort(unique_month)

{for (i in seq(length(unique_month))) 
 {   
  sub_data_month=subset(sub_data,sub_data$Month==unique_month[i])
  m1=sum(table(sub_data_month$POD))
  m2=table(sub_data_month$POD)[1]
  m3=round(m2/m1,3)
  temp<- data.frame(unique_district[j],unique_month[i],m1,m2,m3)
  monthly=rbind(monthly,temp)
 }
}
names(monthly)=c("District","Month","Total_Death","Hospitalised","Ratio_of_Hospitalised")
head1<- paste("", unique_district[j], sep = " ")
total_ratio=ggplot(monthly,aes(x=Month,y=Ratio_of_Hospitalised))+geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+geom_abline(intercept=max(0.95,min(monthly$Ratio_of_Hospitalised)),slope = 0,col="#00846b",size=3)+guides(size=F)+scale_size_continuous(range = c(5,10))+theme_minimal()+xlab("Months") + ylab("Ratio") + ggtitle(head1) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
total_ratio_gp=ggplotly(total_ratio)

n1 <- paste(j,"Hospitalisation_ratio",sep="-")
name = paste(n1,"html", sep=".")
path <- file.path(getwd(),"graphs/hospitalization", name)
htmlwidgets::saveWidget(total_ratio_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste(n1,"png",sep=".")
name2 <- paste0("graphs/hospitalization/", name1)
ggsave(name2, plot=total_ratio ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}

#for Karnataka
monthlyKA<- data.frame(Month=character(),Total_Death = double(), Hospitalised = double(),Ratio_of_Hospitalised=double())
unique_monthKA=unique(month_wise$Month)
unique_monthKA=sort(unique_monthKA)


for (i in seq(length(unique_monthKA))) 
#i=4
{ 
  sub_data_monthKA=subset(month_wise,month_wise$Month==unique_monthKA[i])
  m1KA=sum(table(sub_data_monthKA$POD))
  m2KA=table(sub_data_monthKA$POD)[1]
  m3KA=round(m2KA/m1KA,3)
  tempKA<- data.frame(unique_monthKA[i],m1KA,m2KA,m3KA)
  monthlyKA=rbind(monthlyKA,tempKA)
}

names(monthlyKA)=c("Month","Total_Death","Hospitalised","Ratio_of_Hospitalised")

total_ratioKA=ggplot(monthlyKA,aes(x=Month,y=Ratio_of_Hospitalised))+geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+geom_abline(intercept=max(0.95,min(monthlyKA$Ratio_of_Hospitalised)),slope = 0,col="#00846b",size=3)+guides(size=F)+scale_size_continuous(range = c(5,10))+theme_minimal()+xlab("Months") + ylab("Ratio") + ggtitle("Karnataka") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
total_ratioKA_gp=ggplotly(total_ratioKA)

#save total_ratioKA
###NAME OF PNGFILE
name1 = paste("hospitalisation_ratioKA","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
name2 = paste0("graphs/hospitalization", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=total_ratioKA ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("hospitalisation_ratioKA","html", sep=".")
path <- file.path(getwd(), "graphs/hospitalization/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(total_ratioKA_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

