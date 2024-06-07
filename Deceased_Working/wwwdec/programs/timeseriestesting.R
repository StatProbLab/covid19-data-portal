###############################################################################
## Title: Testing Rates and Positivity in Karnataka                          ##
## Input: mediadata/katestingSandipan.xlsx                                   ##
## Output: Plots                                                             ##
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
#Read Data
#data<- read_excel("summertime/wwwdec/mediadata/katestingSandipan.xlsx")
data<- read_excel("mediadata/katestingSandipan.xlsx")
#Data Frame
df=data[,c(1,3,9)]
df=df[-c(1:11),]
df_new<- data.frame(Date=character(),Daily_Samples_Tested= double(),Daily_Samples_Positive_for_COVID_19=double(),Ratio=double())
for (i in seq(unique(nrow(df)-1))) 
{
  m1 <-df$`Daily Samples Tested`[i]
  m2 <-df$`Daily Samples Positive for COVID-19`[i]
  m3 <-round((df$`Daily Samples Positive for COVID-19`[i+1]/df$`Daily Samples Tested`[i])*100,3)
  m4=df$Date[i]
  temp<- data.frame(i,m4,m1,m2,m3)
  df_new<- rbind(df_new,temp)
}
names(df_new) <- c("No.","Date","Daily Samples Collected","Daily Samples Positive for Covid-19","Test Positivity Rate")
#Format Date df
df$Date <- as.Date(df$Date, format ="%d-%m-%Y")
#Format Date df_new
df_new$Date=as.Date(df_new$Date,format ="%d-%m-%Y")

#add month
month_wise<-data.frame((format(df_new$Date,"%Y-%m")),df_new)
names(month_wise) <- c("Month","No.","Date","Daily Samples Collected","Daily Samples Positive for Covid-19","Test Positivity Rate")

#plot total Sample
total_test=ggplot(month_wise,aes(x=Date,y=`Daily Samples Collected`))+geom_point()+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("Counts") + ggtitle("Total Test Samples Collected") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
total_test_p=ggplot(month_wise,aes(x=Date,y=`Daily Samples Collected`))+geom_point()+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("Counts") + ggtitle("Total Test Samples Collected") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
total_test_gp=ggplotly(total_test_p)


#save total Sample
###NAME OF PNGFILE
name1 = paste("total_Sample","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("graphs/timeseriestesting/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=total_test ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("total_Sample","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "graphs/timeseriestesting/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(total_test_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")



#plot ratio positive
ratio_test=ggplot(month_wise,aes(x=Date,y=`Test Positivity Rate`))+geom_point()+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("Rate") + ggtitle("Daily Positivity Rate") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
ratio_test_p=ggplot(month_wise,aes(x=Date,y=`Test Positivity Rate`))+geom_point()+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("Rate") + ggtitle("Daily Positivity Rate") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
ratio_test_gp=ggplotly(ratio_test_p)

#save ratio positive
###NAME OF PNGFILE
name1 = paste("ratio_positive","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("graphs/timeseriestesting/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=ratio_test,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("ratio_positive","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "graphs/timeseriestesting/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(ratio_test_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")


#plot total positive
pos_test=ggplot(month_wise,aes(x=Date,y=`Daily Samples Positive for Covid-19`))+geom_point()+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("Counts") + ggtitle("Number of Positive Test Samples") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
pos_test_p=ggplot(month_wise,aes(x=Date,y=`Daily Samples Positive for Covid-19`))+geom_point()+geom_line(col="#D55E00")+scale_x_date(date_breaks = "1 month",date_labels = "%Y-%m")+scale_color_viridis(discrete = TRUE) + xlab("Days") + ylab("Counts") + ggtitle("Number of Positive Test Samples") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
pos_test_gp=ggplotly(pos_test_p)
#save total positive
###NAME OF PNGFILE
name1 = paste("total_positive","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("graphs/timeseriestesting/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=pos_test,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("total_positive","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "graphs/timeseriestesting/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(pos_test_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
