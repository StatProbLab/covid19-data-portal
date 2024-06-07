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

#read data
data <- read.csv("../mediadata/Master.csv")

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
na1= subset(data,is.na(data$Difference1))
na2=subset(data,is.na(data$Difference2))
large1 = subset(data,as.numeric(data$Difference1)>61)
large2 = subset(data,as.numeric(data$Difference2)>91)
req=subset(data,as.numeric(data$Difference2)>0)
req_dist=subset(data,as.numeric(data$Difference2)>0)
conf_df <- data.frame(District = character(), mean = double(), variance = double(), sd = double())
conf_df2 <- data.frame(District = character(), Mean = double(), variance = double(), sd = double())
conf_w1 <- data.frame(District = character(), Mean_w1 = double(), variance = double(), sd = double())
conf_w2 <- data.frame(District = character(), Mean_w2 = double(), variance = double(), sd = double())
conf_w1_rep <- data.frame(District = character(), Mean_w1_rep = double(), variance = double(), sd = double())
conf_w2_rep <- data.frame(District = character(), Mean_w2_rep = double(), variance = double(), sd = double())
req_dist_scat <- data.frame(District = character(), Total_Death = double(), Hospitalised = double(),Not_Hospitalised = double())

#separating waves wrt dates for DOD-DOA & MB-DOD
positive$Difference3=difftime("2020-11-01",positive$`MB.Date`,units = "days")
positive$Difference4=difftime(positive$`MB.Date`,"2021-02-27",units = "days")
wave1=subset(positive,as.numeric(positive$Difference3)>0)
wave2=subset(positive,as.numeric(positive$Difference4)>0 & positive$Difference4<155)
wave_1.5=subset(positive,as.numeric(positive$Difference4)<0&as.numeric(positive$Difference4>-118))


##writing out dataframe
write.csv(x=negative,file="../csv/MBerror/negative.csv",row.names = FALSE)
write.csv(x=negative1,file = "../csv/MBerror/negative1.csv",row.names = FALSE)
write.csv(x=positive,file = "../csv/cleaneddiffnew.csv",row.names = FALSE)
write.csv(x=positive1,file = "../csv/cleaneddiffnew1.csv",row.names = FALSE)
write.csv(x=positive2,file = "../csv/cleaneddiffnew2.csv",row.names = FALSE)
write.csv(x=na1,file = "../csv/na1.csv",row.names = FALSE)
write.csv(x=na2,file = "../csv/na2.csv",row.names = FALSE)
write.csv(x=large1,file = "../csv/MBerror/large1.csv",row.names = FALSE)
write.csv(x=large2,file = "../csv/MBerror/large2.csv",row.names = FALSE)

#Box plot of rep,dec.
#Box plot of rep,dec.
box_rep<- ggplot(positive,aes(x=reorder(District,`Difference2`,na.rm = TRUE),y=`Difference2`,col=District)) + geom_boxplot(outlier.colour = NULL) + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("Days to Report District wise") + xlab("District") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 34),plot.title = element_text(color = "#D55E00",face = "bold", size = 40),axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28)) + scale_y_continuous(name = "Days to Report",breaks = seq(0,90,5),limits = c(0,90))
box_rep_p<- ggplot(positive,aes(x=reorder(District,`Difference2`,na.rm = TRUE),y=`Difference2`,col=District)) + geom_boxplot(outlier.colour = NULL) + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("Days to Report District wise") + xlab("District") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 20),plot.title = element_text(color = "#D55E00",face = "bold", size = 24),axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, angle = 45, size = 18)) + scale_y_continuous(name = "Days to Report",breaks = seq(0,90,5),limits = c(0,90))
box_repgp=ggplotly(box_rep_p)
#save box_rep
###NAME OF PNGFILE
name1 = paste("box_rep","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=box_rep ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("box_rep","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(box_repgp, file=path, selfcontained = FALSE, libdir = "plotly.html")

box_decease<- ggplot(positive,aes(x=reorder(District,`Difference1`,na.rm = TRUE),y=`Difference1`,col=District)) + geom_boxplot(outlier.colour = NULL) + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("Days to Decease District wise") + xlab("District") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 34),plot.title = element_text(color = "#D55E00",face = "bold", size = 40),axis.text.y = element_text(hjust = 1, size=20), axis.text.x = element_text(hjust = 1, angle = 45, size = 28)) + scale_y_continuous(name = "Days to Decease",breaks = seq(0,120,5),limits = c(0,120))
box_decease_p<- ggplot(positive,aes(x=reorder(District,`Difference1`,na.rm = TRUE),y=`Difference1`,col=District)) + geom_boxplot(outlier.colour = NULL) + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("Days to Decease District wise") + xlab("District") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 20),plot.title = element_text(color = "#D55E00",face = "bold", size = 24),axis.text.y = element_text(hjust = 1, size=15), axis.text.x = element_text(hjust = 1, angle = 45, size = 18)) + scale_y_continuous(name = "Days to Decease",breaks = seq(0,120,5),limits = c(0,120))
box_deceasegp=ggplotly(box_decease_p)
#save box_decease
###NAME OF PNGFILE
name1 = paste("box_decease","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=box_decease ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("box_decease","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(box_deceasegp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#scatter for hospital death
scatter_death<-positive1[positive1$District != "Bengaluru Urban",]
colnames(scatter_death)[13]="Days_to_Decease"
scat_death<- ggplot(scatter_death,aes(x=`Days_to_Decease`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot(without Bengaluru Urban)") + xlab("Days") + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34)) + scale_y_continuous(name = "Number of deceased")
scat_death_p<- ggplot(scatter_death,aes(x=`Days_to_Decease`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot(without Bengaluru Urban)") + xlab("Days") + theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, angle = 45, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20)) + scale_y_continuous(name = "Number of deceased")
scat_death_gp=ggplotly(scat_death_p)
#save scat_death
###NAME OF PNGFILE
name1 = paste("scat_death","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=scat_death ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scat_death","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(scat_death_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
#include blr
scat_death_blr_data=as.data.frame(positive1)
colnames(scat_death_blr_data)[13]="Days_to_Decease"
scat_death_blr<- ggplot(scat_death_blr_data,aes(x=`Days_to_Decease`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot") + xlab("Days") + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34)) + scale_y_continuous(name = "Number of deceased")
scat_death_blr_p<- ggplot(scat_death_blr_data,aes(x=`Days_to_Decease`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot") + xlab("Days") + theme(axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, angle = 45, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20)) + scale_y_continuous(name = "Number of deceased")
scat_death_blr_gp=ggplotly(scat_death_blr_p)
#save scat_death_blr
###NAME OF PNGFILE
name1 = paste("scat_death_blr","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=scat_death_blr ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scat_death_blr","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(scat_death_blr_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
#scatter for hospital report
scatter_death_rep<-positive2[positive2$District != "Bengaluru Urban",]
colnames(scatter_death_rep)[14]="Days_to_Report"
scat_death_rep<- ggplot(scatter_death_rep,aes(x=`Days_to_Report`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot(without Bengaluru Urban)") + xlab("Days") + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34)) + scale_y_continuous(name = "Number of deceased")
scat_death_rep_p<- ggplot(scatter_death_rep,aes(x=`Days_to_Report`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot(without Bengaluru Urban)") + xlab("Days") + theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, angle = 45, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20)) + scale_y_continuous(name = "Number of deceased")
scat_death_rep_gp=ggplotly(scat_death_rep_p)
#save scat_death_rep
###NAME OF PNGFILE
name1 = paste("scat_death_rep","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=scat_death_rep ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scat_death_rep","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(scat_death_rep_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
#include blr
scat_death_rep_blr_data=as.data.frame(positive2)
colnames(scat_death_rep_blr_data)[14]="Days_to_Report"
scat_death_rep_blr<- ggplot(scat_death_rep_blr_data,aes(x=`Days_to_Report`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot") + xlab("Days") + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34)) + scale_y_continuous(name = "Number of deceased")
scat_death_rep_blr_p<- ggplot(scat_death_rep_blr_data,aes(x=`Days_to_Report`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE)+theme_minimal() + ggtitle("District wise Scatter Plot") + xlab("Days") + theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, angle = 45, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20)) + scale_y_continuous(name = "Number of deceased")
scat_death_rep_blr_gp=ggplotly(scat_death_rep_blr_p)
#save scat_death_rep_blr
###NAME OF PNGFILE
name1 = paste("scat_death_rep_blr","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=scat_death_rep_blr ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scat_death_rep_blr","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(scat_death_rep_blr_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#plotting histogram
#plot of days to decease overall
df1=positive1[,c(3,2,9,10,13)]
names(df1)=c("Patient ID","District","D.O.A","D.O.D","Days")
g1=ggplot(df1,aes(x=Days))+geom_histogram(bins=61,colour="#0072B2",fill="white",size=1)+labs(title="Karnataka-Histogram of Days to Decease",x="Days to Decease",y="Decease Count")+theme_light()+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)+theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 30), axis.text.y = element_text(size = 24), axis.text.x = element_text(size = 24))
gp1=ggplotly(g1)
#gp1
#save csv days to decease
dfsave=df1[order(df1[,2],df1[,4]),]
write.csv(x=dfsave,file = "../csv/Days_to_Deceasecount.csv",row.names = FALSE)

#save gp1
###NAME OF PNGFILE
name1 = paste("daystodecease","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=g1 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("daystodecease","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(gp1, file=path, selfcontained = FALSE, libdir = "plotly.html")

#confidence interval total for days to decease
unique_district_names <- unique(positive1$District)
unique_district_names <- sort(unique_district_names)
for(i in seq(length(unique_district_names)))
{
    sub_data <- subset(positive1, positive1$District==unique_district_names[i])
    t1 <- round(mean(sub_data$Difference1),3)
    t2 <- round(var(sub_data$Difference1),3)
    t3 <- round(sqrt(t2),3)
    temp <- data.frame(unique_district_names[i],t1,t2,t3)
    conf_df <- rbind(conf_df,temp)
}
names(conf_df) <- c("District", "mean", "Variance", "sd")
conf_df_ord=conf_df %>% arrange(mean) %>% mutate(District=factor(District, levels=District)) 
con1 <- ggplot(conf_df_ord,aes(x = District, y = mean)) + geom_pointrange(aes(x = District, ymin = mean - sd, ymax = mean + sd),color="#0072B2")+theme_minimal() + xlab("Districts(KARNATAKA)") + ylab("Confidence-Interval(Days to Decease)") + ggtitle("Confidence Interval for days to decease(District Wise)") +theme_light()+ theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_df_ord, aes(label = mean)) + coord_flip()
cong1=ggplotly(con1)

#save con1
###NAME OF PNGFILE
name1 = paste("ci_decease","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=con1 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("ci_decease","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(cong1, file=path, selfcontained = FALSE, libdir = "plotly.html")

#plot of Days to Report overall
df2=positive2[,c(3,2,10,11,14)]
names(df2)=c("Patient ID","District","D.O.D","MB date","Days")
g2=ggplot(df2,aes(x=Days))+geom_histogram(bins=88,colour="#0072B2",fill="white",size=1)+labs(title="Karnataka-Histogram of Days to Report",x="Days to Report",y="Decease count")+theme_light()+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 40), axis.title = element_text(color = '#D55E00', size = 30), axis.text.y = element_text(size = 24), axis.text.x = element_text(size = 24))
gp2=ggplotly(g2)
#gp2
#save csv days to report
dfsave2=df2[order(df2[,2],df2[,4]),]
write.csv(x=dfsave2,file = "../csv/Days_to_reportcount.csv",row.names = FALSE)
#save gp2
###NAME OF PNGFILE
name1 = paste("daystoreport","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=g2 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("daystoreport","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(gp2, file=path, selfcontained = FALSE, libdir = "plotly.html")

#confidence interval total for days to report

unique_district_names2 <- unique(positive2$District)
unique_district_names2 <- sort(unique_district_names2)
for(i in seq(length(unique_district_names2)))
{
    sub_data2 <- subset(positive2, positive2$District==unique_district_names2[i])
    m1 <- round(mean(sub_data2$Difference2),3)
    m2 <- round(var(sub_data2$Difference2),3)
    m3 <- round(sqrt(m2),3)
    temp2 <- data.frame(unique_district_names2[i],m1,m2,m3)
    conf_df2 <- rbind(conf_df2,temp2)
}
conf_df2_need=na.omit(conf_df2)
names(conf_df2_need) <- c("District", "Mean", "variance", "sd")
conf_df2_ord=conf_df2_need %>% arrange(Mean) %>% mutate(District=factor(District, levels=District)) 
con2=ggplot(conf_df2_ord,aes(x = District, y = Mean)) + geom_errorbar(aes(x = District, ymin = Mean - sd, ymax = Mean + sd),color="#0072B2") + xlab("Districts(KARNATAKA)")+ylab("Confidence-Interval(Days to Report)")+ggtitle("Confidence Interval for days to report(District Wise)") +theme_light()+ theme(legend.position = "none",plot.title = element_text(color ='#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data =conf_df2_ord, aes(label = Mean)) + coord_flip()
cong2=ggplotly(con2)
#cong2
#save con2
###NAME OF PNGFILE
name1 = paste("ci_report","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=con2 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("ci_report","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(cong2, file=path, selfcontained = FALSE, libdir = "plotly.html")

#plot of Histogram for days to decease wave wise
df1.1=data.frame(as.numeric(wave1$Difference1))
names(df1.1)=c("Days")
gg1.1=ggplot(df1.1,aes(x=Days))+geom_histogram(bins=84,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Decease(1st Wave)",x="Days to Decease",y="Decease Count")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gg1.1_p1=ggplot(df1.1,aes(x=Days))+geom_histogram(bins=84,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Decease(1st Wave vs 2nd Wave)",x="Days to Decease",y="Decease Count")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gp1.1gp1=ggplotly(gg1.1_p1)
#gp1.1
df2.1=data.frame(as.numeric(wave2$Difference1))
names(df2.1)=c("Days")
gg2.1=ggplot(df2.1,aes(x=Days))+geom_histogram(bins=118,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Decease(2nd Wave)",x="Days to Decease",y="")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gg2.1_p2=ggplot(df2.1,aes(x=Days))+geom_histogram(bins=118,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Decease(1st Wave vs 2nd Wave)",x="Days to Decease",y="")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gp2.1gp2=ggplotly(gg2.1_p2)
#gp2.1
dwave=ggarrange(gg1.1,gg2.1,nrow = 1,ncol = 2)
dwaveg=subplot(gp1.1gp1,gp2.1gp2,shareX = TRUE)
#dwave
#save dwave
###NAME OF PNGFILE
name1 = paste("daystodecease_wavewise","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=dwave ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("daystodecease_wavewise","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(dwaveg, file=path, selfcontained = FALSE, libdir = "plotly.html")

#hist dist. wise days to decease
hist_w1_days <- data.frame(District = character(), count_w1_days = double())
hist_w2_days <- data.frame(District = character(), count_w2_days = double())
unique_district_names_days <- unique(positive$District)
unique_district_names_days <- sort(unique_district_names_days)
for(i in seq(length(unique_district_names_days)))
#i=11
    {
    hist_w1_days <- data.frame(District = character(), count_w1_days = double())
    sub_data_w1_days <- subset(wave1, wave1$District==unique_district_names_days[i])
    t1 <- sub_data_w1_days$Difference1
    temp_days <- data.frame(unique_district_names_days[i],t1)
    hist_w1_days <- rbind(hist_w1_days,temp_days)
names(hist_w1_days) <- c("District", "count_w1_days")
head<- paste("Days to Decease(Wave-1)-", unique_district_names_days[i], sep = " ")
headgp<- paste("Days to Decease(Wave-1 vs Wave-2)-", unique_district_names_days[i], sep = " ")
h1=ggplot(hist_w1_days,aes(x=count_w1_days))+geom_histogram(bins=ceiling(max(as.numeric(hist_w1_days$count_w1_days))),colour="#0072B2",fill="white",size=1)+ggtitle(head)+xlab("Days to Decease")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w1_days)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
h1gp=ggplot(hist_w1_days,aes(x=count_w1_days))+geom_histogram(bins=ceiling(max(as.numeric(hist_w1_days$count_w1_days))),colour="#0072B2",fill="white",size=1)+ggtitle(headgp)+xlab("Days to Decease")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w1_days)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
hist_w2_days <- data.frame(District = character(), count_w2_days = double())
    sub_data_w2_days <- subset(wave2, wave2$District==unique_district_names_days[i])
    t1_2 <- sub_data_w2_days$Difference1
    temp_days_2 <- data.frame(unique_district_names_days[i],t1_2)
    hist_w2_days <- rbind(hist_w2_days,temp_days_2)
names(hist_w2_days) <- c("District", "count_w2_days")
head1<- paste("Days to Decease(Wave-2)-", unique_district_names_days[i], sep = " ")
headgp<- paste("Days to Decease(Wave-1 vs Wave-2)-", unique_district_names_days[i], sep = " ")
h2=ggplot(hist_w2_days,aes(x=count_w2_days))+geom_histogram(bins=ceiling(max(as.numeric(hist_w2_days$count_w2_days))),colour="#0072B2",fill="white",size=1)+ggtitle(head1)+xlab("Days to Decease")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w2_days)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
h2gp=ggplot(hist_w2_days,aes(x=count_w2_days))+geom_histogram(bins=ceiling(max(as.numeric(hist_w2_days$count_w2_days))),colour="#0072B2",fill="white",size=1)+ggtitle(headgp)+xlab("Days to Decease")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w2_days)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
hf <- ggarrange(h1, h2, ncol = 2, nrow = 1)
hf1=subplot(h1gp,h2gp)
n1 <- paste(i,"District_decease",sep="-")
name = paste(n1,"html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots//", name)
path <- file.path(getwd(), "../graphs/", name)
htmlwidgets::saveWidget(hf1, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste(n1,"png",sep=".")
#name2 <- paste0("summertime/Sandipan/plots/", name1)
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=hf ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}

#ci wave wise days to decease
#conf_w_rep <- data.frame(District = character(),w1_cnt = integer(),w2_cnt = integer(),t_w1 = double(),t_w2 = double(), Mean_w1_rep = double(), variance_w1_rep = double(), sd_w1_rep = double(), Mean_w2_rep = double(), variance_w2_rep = double(), sd_w2_rep = double())

#wave wise ci
conf_w_days <- data.frame(District = character(),w1_cnt_days = integer(),w2_cnt_days = integer(),t_w1_days = double(),t_w2_days = double(), Mean_w1_days = double(), variance_w1_days = double(), sd_w1_days = double(), Mean_w2_days = double(), variance_w2_days = double(), sd_w2_days = double())
unique_district_names_daysci <- unique(positive$District)
unique_district_names_daysci <- sort(unique_district_names_daysci)

for(i in seq(length(unique_district_names_daysci)))
{
    sub_data_w1_days <- subset(wave1,wave1$District==unique_district_names_daysci[i])
    w1_n_wd <- nrow(sub_data_w1_days)
    t_w1_wd <- round(qt(0.05/2, w1_n_wd-1,lower.tail = FALSE),3)
    t1_wd <- round(mean(sub_data_w1_days$Difference1),3)
    t2_wd <- round(var(sub_data_w1_days$Difference1),3)
    t3_wd <- round(sqrt(t2_wd),3)
    sub_data_w2_days <- subset(wave2, wave2$District==unique_district_names_daysci[i])
    w2_n_days <- nrow(sub_data_w2_days)
    t_w2_days <- round(qt(0.05/2, w2_n_days-1, lower.tail = FALSE),3)
    t1_w2 <- round(mean(sub_data_w2_days$Difference1),3)
    t2_w2 <- round(var(sub_data_w2_days$Difference1),3)
    t3_w2 <- round(sqrt(t2_w2),3)
    temp_days <- data.frame(unique_district_names_daysci[i],w1_n_wd,w2_n_days,t_w1_wd,t_w2_days,t1_wd,t2_wd,t3_wd,t1_w2,t2_w2,t3_w2)
    conf_w_days <- rbind(conf_w_days,temp_days)
}
names(conf_w_days) <- c("District","w1_cnt_days","w2_cnt_days","t_w1_days","t_w2_days","Mean_w1_days", "variance_w1_days", "sd_w1_days" , "Mean_w2_days", "variance_w2_days","sd_w2_days")

conf_w_days$category=conf_w_days$Mean_w2_days-conf_w_days$Mean_w1_days
df_pos_days<- conf_w_days[conf_w_days$category>=0,]
df_neg_days<- conf_w_days[conf_w_days$category<0,]

order<- rep("High",length(nrow(df_pos_days)))
df_pos_days$order <- order

order<- rep("low",length(nrow(df_neg_days)))
df_neg_days$order <- order


conf_w_days_ord=rbind(df_pos_days,df_neg_days)
conf_w_days_ord=conf_w_days_ord%>% arrange(Mean_w1_days) %>% mutate(District=factor(District, levels=District)) 
conf_w_days_ord[is.na(conf_w_days_ord)]=0


#plot
con_w1_days <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w1_days)) + geom_pointrange(aes(x = District, ymin = Mean_w1_days - sd_w1_days, ymax = Mean_w1_days + sd_w1_days,col=order),size=1) + xlab("Districts(KARNATAKA)") + ylab("Days to Decease") + ggtitle("Confidence Interval(Wave1)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_days_ord, aes(label = Mean_w1_days)) + coord_flip()
con_w2_days <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w2_days)) + geom_pointrange(aes(x = District, ymin = Mean_w2_days - sd_w2_days, ymax = Mean_w2_days + sd_w2_days,col=order),size=1) + xlab("") + ylab("Days to Deacease") + ggtitle("Confidence Interval(Wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_days_ord, aes(label = Mean_w2_days)) + coord_flip() 
con_d1 <- ggarrange(con_w1_days, con_w2_days, ncol = 2, nrow = 1)
con_w1_days_p1 <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w1_days)) + geom_pointrange(aes(x = District, ymin = Mean_w1_days - sd_w1_days, ymax = Mean_w1_days + sd_w1_days,col=order),size=1) + xlab("Districts(KARNATAKA)") + ylab("Days to Decease") + ggtitle("Confidence Interval(Wave1 vs Wave2)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) +geom_text(aes(label=Mean_w1_days))+ coord_flip()
con_w2_days_p2 <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w2_days)) + geom_pointrange(aes(x = District, ymin = Mean_w2_days - sd_w2_days, ymax = Mean_w2_days + sd_w2_days,col=order),size=1) + xlab("") + ylab("Days to Deacease") + ggtitle("Confidence Interval(Wave1 vs Wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) +geom_text(aes(label=Mean_w2_days)) + coord_flip() 
con_d1gp=subplot(con_w1_days_p1, con_w2_days_p2,shareX = TRUE)


#t-interval
con_w1_days_t <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w1_days)) + geom_pointrange(aes(x = District, ymin = Mean_w1_days - ((t_w1_days*sd_w1_days)/round(sqrt(w1_cnt_days))), ymax = Mean_w1_days + ((t_w1_days*sd_w1_days)/round(sqrt(w1_cnt_days))),col=order))+theme_minimal() + xlab("Districts(KARNATAKA)") + ylab("Days to Decease") + ggtitle("Confidence Interval(Wave1)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_days_ord, aes(label = Mean_w1_days)) + coord_flip()
con_w2_days_t <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w2_days)) + geom_pointrange(aes(x = District, ymin = Mean_w2_days - ((t_w2_days*sd_w2_days)/round(sqrt(w2_cnt_days))), ymax = Mean_w2_days + ((t_w2_days*sd_w2_days)/round(sqrt(w2_cnt_days))),col=order))+theme_minimal() + xlab("") + ylab("Days to Deacease") + ggtitle("Confidence Interval(Wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_days_ord, aes(label = Mean_w2_days)) + coord_flip() 
con_d1_t <- ggarrange(con_w1_days_t, con_w2_days_t, ncol = 2, nrow = 1)
con_w1_days_p1_t <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w1_days)) + geom_pointrange(aes(x = District, ymin = Mean_w1_days - ((t_w1_days*sd_w1_days)/round(sqrt(w1_cnt_days))), ymax = Mean_w1_days + ((t_w1_days*sd_w1_days)/round(sqrt(w1_cnt_days))),col=order))+theme_minimal() + xlab("Districts(KARNATAKA)") + ylab("Days to Decease") + ggtitle("Confidence Interval(Wave1 vs Wave2)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) +geom_text(aes(label=Mean_w1_days))+ coord_flip()
con_w2_days_p2_t <- ggplot(conf_w_days_ord,aes(x = District, y = Mean_w2_days)) + geom_pointrange(aes(x = District, ymin = Mean_w2_days - ((t_w2_days*sd_w2_days)/round(sqrt(w2_cnt_days))), ymax = Mean_w2_days + ((t_w2_days*sd_w2_days)/round(sqrt(w2_cnt_days))),col=order))+theme_minimal() + xlab("") + ylab("Days to Deacease") + ggtitle("Confidence Interval(Wave1 vs Wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) +geom_text(aes(label=Mean_w2_days)) + coord_flip() 
con_d1gp_t=subplot(con_w1_days_p1_t, con_w2_days_p2_t,shareX = TRUE)
##save csv for conf_w_days_ord(ci)

write.csv(x=conf_w_days_ord,file="../csv/conf_w_days_ord.csv",row.names = FALSE)

#save con_d1
###NAME OF PNGFILE
name1 = paste("ci_wavewise_decease","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=con_d1 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("ci_wavewise_decease","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(con_d1gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#save con_d1_t
###NAME OF PNGFILE
name1 = paste("ci_t_wavewise_decease","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=con_d1_t ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("ci_t_wavewise_decease","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(con_d1gp_t, file=path, selfcontained = FALSE, libdir = "plotly.html")

#Scatter mean wave-wise days to decease
wave_dec_scat=ggplot(conf_w_days_ord,aes(x=Mean_w1_days,y=Mean_w2_days,color=w1_cnt_days+w2_cnt_days,size=w1_cnt_days+w2_cnt_days))+geom_point()+geom_abline(intercept=0, slope=1)+theme_minimal()+xlab("Wave 1-Mean")+ylab("Wave 2-Mean")+ggtitle("Mean Days to Decease-Karnataka") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00"))+scale_colour_viridis_c(option = "H")+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+ggrepel::geom_text_repel(data=conf_w_days_ord,aes(label=District),size=4)+coord_fixed()
wave_dec_scat_p=ggplot(conf_w_days_ord,aes(x=Mean_w1_days,y=Mean_w2_days,color=w1_cnt_days+w2_cnt_days,size=w1_cnt_days+w2_cnt_days))+geom_point()+geom_abline(intercept=0, slope=1)+theme_minimal()+xlab("Wave 1-Mean")+ylab("Wave 2-Mean")+ggtitle("Mean Days to Decease-Karnataka") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00"))+scale_colour_viridis_c(option = "H")+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+geom_text(data=conf_w_days_ord,aes(label=District),size=4)+coord_fixed()
wave_dec_scat_gp<- ggplotly(wave_dec_scat_p, tooltip = c("x","y","size","label"))

#save wave_dec_scat
###NAME OF PNGFILE
name1 = paste("wavewise_decease_mean","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=wave_dec_scat ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("wavewise_decease_mean","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(wave_dec_scat_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#ci wave report
#wave wise ci
conf_w_rep <- data.frame(District = character(),w1_cnt = integer(),w2_cnt = integer(),t_w1 = double(),t_w2 = double(), Mean_w1_rep = double(), variance_w1_rep = double(), sd_w1_rep = double(), Mean_w2_rep = double(), variance_w2_rep = double(), sd_w2_rep = double())
unique_district_names_rep <- unique(positive$District)
unique_district_names_rep <- sort(unique_district_names_rep)

for(i in seq(length(unique_district_names_rep)))
{
    sub_data_w1_rep <- subset(wave1,wave1$District==unique_district_names_rep[i])
    w1_n <- nrow(sub_data_w1_rep)
    t_w1 <- round(qt(0.05/2, w1_n-1,lower.tail = FALSE),3)
    t1_w1 <- round(mean(sub_data_w1_rep$Difference2),3)
    t2_w1 <- round(var(sub_data_w1_rep$Difference2),3)
    t3_w1 <- round(sqrt(t2_w1),3)
    sub_data_w2_rep <- subset(wave2, wave2$District==unique_district_names_rep[i])
    w2_n <- nrow(sub_data_w2_rep)
    t_w2 <- round(qt(0.05/2, w2_n-1, lower.tail = FALSE),3)
    t1 <- round(mean(sub_data_w2_rep$Difference2),3)
    t2 <- round(var(sub_data_w2_rep$Difference2),3)
    t3 <- round(sqrt(t2),3)
    temp <- data.frame(unique_district_names_rep[i],w1_n,w2_n,t_w1,t_w2,t1_w1,t2_w1,t3_w1,t1,t2,t3)
    conf_w_rep <- rbind(conf_w_rep,temp)
}
names(conf_w_rep) <- c("District","w1_cnt","w2_cnt","t_w1","t_w2", "Mean_w1_rep", "variance_w1_rep", "sd_w1_rep" , "Mean_w2_rep", "variance_w2_rep","sd_w2_rep")

conf_w_rep$category=conf_w_rep$Mean_w2_rep-conf_w_rep$Mean_w1_rep
df_pos_rep<- conf_w_rep[conf_w_rep$category>=0,]
df_neg_rep<- conf_w_rep[conf_w_rep$category<0,]

order<- rep("High",length(nrow(df_pos_rep)))
df_pos_rep$order <- order

order<- rep("low",length(nrow(df_neg_rep)))
df_neg_rep$order <- order


conf_w_rep_ord=rbind(df_pos_rep,df_neg_rep)
conf_w_rep_ord=conf_w_rep_ord %>% arrange(Mean_w1_rep) %>% mutate(District=factor(District, levels=District)) 
conf_w_rep_ord[is.na(conf_w_rep_ord)]=0

con_w1_rep <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w1_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w1_rep - sd_w1_rep, ymax = Mean_w1_rep + sd_w1_rep,col=order),size=1) + xlab("Districts(KARNATAKA)") + ylab("Days to Report") + ggtitle("Confidence Interval(Wave1)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_rep_ord, aes(label = Mean_w1_rep)) + coord_flip()
con_w2_rep <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w2_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w2_rep - sd_w2_rep, ymax = Mean_w2_rep + sd_w2_rep,col=order),size=1) + xlab("") + ylab("Days to Report") + ggtitle("Confidence Interval(wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_rep_ord, aes(label = Mean_w2_rep)) + coord_flip() 
con_d2 <- ggarrange(con_w1_rep, con_w2_rep, ncol = 2, nrow = 1)
con_w1_rep_p1 <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w1_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w1_rep - sd_w1_rep, ymax = Mean_w1_rep + sd_w1_rep,col=order),size=1) + xlab("Districts(KARNATAKA)") + ylab("Days to Report") + ggtitle("Confidence Interval(Wave1 vs Wave2)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE)+geom_text(aes(label =Mean_w1_rep))+ coord_flip()
con_w2_rep_p2 <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w2_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w2_rep - sd_w2_rep, ymax = Mean_w2_rep + sd_w2_rep,col=order),size=1) + xlab("") + ylab("Days to Report") + ggtitle("Confidence Interval(wave1 vs wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) +geom_text(aes(label =Mean_w2_rep)) + coord_flip() 
con_d2gp=subplot(con_w1_rep_p1, con_w2_rep_p2,shareX = TRUE)
#t-interval
con_w1_rep_t <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w1_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w1_rep -((t_w1*sd_w1_rep)/round(sqrt(w1_cnt))), ymax = Mean_w1_rep + ((t_w1*sd_w1_rep)/round(sqrt(w1_cnt))),col=order))+theme_minimal() + xlab("Districts(KARNATAKA)") + ylab("Days to Report") + ggtitle("Confidence Interval(Wave1)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_rep_ord, aes(label = Mean_w1_rep))+coord_flip()
con_w2_rep_t <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w2_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w2_rep - ((t_w2*sd_w2_rep)/round(sqrt(w2_cnt))), ymax = Mean_w2_rep + ((t_w2*sd_w2_rep)/round(sqrt(w2_cnt))),col=order))+theme_minimal() + xlab("") + ylab("Days to Report") + ggtitle("Confidence Interval(wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = conf_w_rep_ord, aes(label = Mean_w2_rep)) + coord_flip() 
con_d2_t <- ggarrange(con_w1_rep_t, con_w2_rep_t, ncol = 2, nrow = 1)
con_w1_rep_p1_t <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w1_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w1_rep -((t_w1*sd_w1_rep)/round(sqrt(w1_cnt))), ymax = Mean_w1_rep + ((t_w1*sd_w1_rep)/round(sqrt(w1_cnt))),col=order))+theme_minimal() + xlab("Districts(KARNATAKA)") + ylab("Days to Report") + ggtitle("Confidence Interval(Wave1 vs Wave2)") + theme(legend.position = "none", axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=15,color = '#D55E00'),axis.title.y = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE)+geom_text(aes(label =Mean_w1_rep))+coord_flip()
con_w2_rep_p2_t <- ggplot(conf_w_rep_ord,aes(x = District, y = Mean_w2_rep)) + geom_pointrange(aes(x = District, ymin = Mean_w2_rep -((t_w2*sd_w2_rep)/round(sqrt(w2_cnt))), ymax = Mean_w2_rep +((t_w2*sd_w2_rep)/round(sqrt(w2_cnt))),col=order))+theme_minimal() + xlab("") + ylab("Days to Report") + ggtitle("Confidence Interval(wave1 vs wave2)") + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.title.x = element_text(size=15,color = '#D55E00'),plot.title = element_text(face="bold",size=18,color = '#D55E00')) + geom_point(show.legend = FALSE) +geom_text(aes(label =Mean_w2_rep)) + coord_flip() 
con_d2gp_t=subplot(con_w1_rep_p1_t, con_w2_rep_p2_t,shareX = TRUE)
##save csv for conf_w_rep_ord(ci)
write.csv(x=conf_w_rep_ord,file="../csv/conf_w_rep_ord.csv",row.names = FALSE)

#save con_d2
###NAME OF PNGFILE
name1 = paste("ci_report_wave","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=con_d2 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("ci_report_wave","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(con_d2gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#save con_d2_t
###NAME OF PNGFILE
name1 = paste("ci_t_report_wave","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=con_d2_t ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("ci_t_report_wave","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(con_d2gp_t, file=path, selfcontained = FALSE, libdir = "plotly.html")

#scatter wave rep
wave_rep_scat=ggplot(conf_w_rep_ord,aes(x=Mean_w1_rep,y=Mean_w2_rep,size=w1_cnt+w2_cnt,color=w1_cnt+w2_cnt))+geom_point()+geom_abline(intercept=0, slope=1)+theme_minimal()+xlab("Wave 1-Mean")+ylab("Wave 2-Mean")+ggtitle("Mean Days to Report-Karnataka") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00"))+scale_colour_viridis_c(option = "H")+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+ggrepel::geom_text_repel(data=conf_w_rep_ord,aes(label=District),size=4)
wave_rep_scat_p=ggplot(conf_w_rep_ord,aes(x=Mean_w1_rep,y=Mean_w2_rep,size=w1_cnt+w2_cnt,color=w1_cnt+w2_cnt))+geom_point()+geom_abline(intercept=0, slope=1)+theme_minimal()+xlab("Wave 1-Mean")+ylab("Wave 2-Mean")+ggtitle("Mean Days to Report-Karnataka") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00"))+scale_colour_viridis_c(option = "H")+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+geom_text(data=conf_w_rep_ord,aes(label=District),size=4)
wave_rep_scat_gp<- ggplotly(wave_rep_scat_p, tooltip = c("x","y","size","label"))

#save scatter wave rep
###NAME OF PNGFILE
name1 = paste("mean_report_wave","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=wave_rep_scat ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("mean_report_wave","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(wave_rep_scat_gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#testing for means
#creating data drame for testing means
wave1=subset(positive,as.numeric(positive$Difference3)>0)
wave1=wave1 %>%
    mutate(WaveName = case_when(
               wave1$Difference3 %in% as.numeric(wave1$Difference3)>0 ~ "1st Wave",
               ))
wave2=subset(positive,as.numeric(positive$Difference4)>0 & as.numeric(positive$Difference4)<155)
wave2=wave2 %>%
    mutate(WaveName = case_when(
               wave2$Difference4 %in% as.numeric(wave2$Difference4)>0 ~ "2nd Wave",
               ))
testdata=rbind(wave1,wave2)
#Ho=mean wave1=mean wave2
t.test(testdata$Difference1~testdata$WaveName,mu=0,alt="two.sided",conf=.95,var.eq=F,Paired=F)
                                       
#for middle diff 1
df1.5.1=data.frame(as.numeric(wave_1.5$Difference1))
names(df1.5.1)=c("Days")
gg1.5.1=ggplot(df1.5.1,aes(x=Days))+geom_histogram(bins=47,colour="#E69F00",fill="white",size=1) +
    labs(title="Histogram of Days to Decease(Middle Wave)",x="Days to Decease",y="Count of Deaths")+theme_light()+theme(plot.title = element_text(size = 15))+geom_vline(aes(xintercept = mean(Days)),col='#0072B2',size=.25)
gp1.5.1=ggplotly(gg1.5.1)

#plot of days to report wave wise
df1.2=data.frame(as.numeric(wave1$Difference2))
names(df1.2)=c("Days")
gg1.2=ggplot(df1.2,aes(x=Days))+geom_histogram(bins=88,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Report(1st Wave)",x="Days to Report",y="Count of Deceased")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gg1.2_p1=ggplot(df1.2,aes(x=Days))+geom_histogram(bins=88,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Report(1st Wave vs 2nd Wave)",x="Days to Report",y="Count of Deceased")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gp1.2gp1=ggplotly(gg1.2_p1)
#gp1.2
df2.2=data.frame(as.numeric(wave2$Difference2))
names(df2.2)=c("Days")
gg2.2=ggplot(df2.2,aes(x=Days))+geom_histogram(bins=77,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Report(2nd Wave)",x="Days to Report",y="Count of Deceased")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gg2.2_p2=ggplot(df2.2,aes(x=Days))+geom_histogram(bins=77,colour="#0072B2",fill="white",size=1) +
    labs(title="Histogram of Days to Report(1st Wave vs 2nd Wave)",x="Days to Report",y="Count of Deceased")+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 24), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))+geom_vline(aes(xintercept = mean(Days)),col='#D55E00',size=.25)
gp2.2gp2=ggplotly(gg2.2_p2)
#gp2.2
drepg=subplot(gp1.2gp1,gp2.2gp2,shareX = TRUE)
drep=ggarrange(gg1.2,gg2.2,nrow = 1,ncol = 2)
#drep
#save drep
###NAME OF PNGFILE
name1 = paste("daystoreport_wave","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=drep ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("daystoreport_wave","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(drepg, file=path, selfcontained = FALSE, libdir = "plotly.html")

#hist dist. wise days to report
hist_w1_rep <- data.frame(District = character(), count_w1_rep = double())
hist_w2_rep <- data.frame(District = character(), count_w2_rep = double())
unique_district_names_rep <- unique(positive$District)
unique_district_names_rep <- sort(unique_district_names_rep)
for(i in seq(length(unique_district_names_rep)))
#i=11
    {
    hist_w1_rep <- data.frame(District = character(), count_w1_rep = double())
    sub_data_w1_rep <- subset(wave1, wave1$District==unique_district_names_rep[i])
    t1_rep <- sub_data_w1_rep$Difference2
    temp_rep <- data.frame(unique_district_names_rep[i],t1_rep)
    hist_w1_rep <- rbind(hist_w1_rep,temp_rep)
    names(hist_w1_rep) <- c("District", "count_w1_rep")
    headr<- paste("Days to Report(Wave-1)-", unique_district_names_rep[i], sep = " ")
    headrgp<- paste("Days to Report(Wave-1 vs Wave-2)-", unique_district_names_rep[i], sep = " ")
    h1r=ggplot(hist_w1_rep,aes(x=count_w1_rep))+geom_histogram(bins=ceiling(max(as.numeric(hist_w1_rep$count_w1_rep))),colour="#0072B2",fill="white",size=1)+ggtitle(headr)+xlab("Days to Report")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w1_rep)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
    h1rgp=ggplot(hist_w1_rep,aes(x=count_w1_rep))+geom_histogram(bins=ceiling(max(as.numeric(hist_w1_rep$count_w1_rep))),colour="#0072B2",fill="white",size=1)+ggtitle(headrgp)+xlab("Days to Report")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w1_rep)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
    hist_w2_rep <- data.frame(District = character(), count_w2_rep = double())
    sub_data_w2_rep <- subset(wave2, wave2$District==unique_district_names_rep[i])
    t1_rep2 <- sub_data_w2_rep$Difference2
    temp_rep_2 <- data.frame(unique_district_names_rep[i],t1_rep2)
    hist_w2_rep <- rbind(hist_w2_rep,temp_rep_2)
    names(hist_w2_rep) <- c("District", "count_w2_rep")
    head1r<- paste("Days to Report(Wave-2)-", unique_district_names_rep[i], sep = " ")
    headrgp<- paste("Days to Report(Wave-1 vs Wave-2)-", unique_district_names_rep[i], sep = " ")
    h2r=ggplot(hist_w2_rep,aes(x=count_w2_rep))+geom_histogram(bins=ceiling(max(as.numeric(hist_w2_rep$count_w2_rep))),colour="#0072B2",fill="white",size=1)+ggtitle(head1r)+xlab("Days to Report")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w2_rep)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
    h2rgp=ggplot(hist_w2_rep,aes(x=count_w2_rep))+geom_histogram(bins=ceiling(max(as.numeric(hist_w2_rep$count_w2_rep))),colour="#0072B2",fill="white",size=1)+ggtitle(headrgp)+xlab("Days to Report")+ylab("Count of Deceased")+geom_vline(aes(xintercept = mean(count_w2_rep)),col='#D55E00',size=.25)+theme_light()+theme(legend.position = "none",plot.title = element_text(color = '#D55E00',face = "bold", size = 20), axis.title = element_text(color = '#D55E00', size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
    hfr <- ggarrange(h1r, h2r, ncol = 2, nrow = 1)
    hfr1=subplot(h1rgp,h2rgp)
n1 <- paste(i,"District_rep",sep="-")
name = paste(n1,"html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
htmlwidgets::saveWidget(hfr1, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste(n1,"png",sep=".")
#name2 <- paste0("summertime/Sandipan/plots/", name1)
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=hfr ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}


#testing for means
#creating data drame for testing means
wave1=subset(positive,as.numeric(positive$Difference3)>0)
wave1=wave1 %>%
    mutate(WaveName = case_when(
               wave1$Difference3 %in% as.numeric(wave1$Difference3)>0 ~ "1st Wave",
               ))
wave2=subset(positive,as.numeric(positive$Difference4)>0&as.numeric(positive$Difference4)<155)
wave2=wave2 %>%
    mutate(WaveName = case_when(
               wave2$Difference4 %in% as.numeric(wave2$Difference4)>0 ~ "2nd Wave",
               ))
testdata=rbind(wave1,wave2)
#Ho=mean wave1=mean wave2
t.test(testdata$Difference2~testdata$WaveName,mu=0,alt="two.sided",conf=.95,var.eq=F,Paired=F)
                                    

df1.5.2=data.frame(as.numeric(wave_1.5$Difference2))
names(df1.5.2)=c("Days")
gg1.5.2=ggplot(df1.5.2,aes(x=Days))+geom_histogram(bins=65,colour="#E69F00",fill="white") +
    labs(title="Histogram of Days to Report(Middle Wave)",x="Days to Report",y="Count of Deaths")+theme_light()+theme(plot.title = element_text(size = 15))+geom_vline(aes(xintercept = mean(Days)),col='#0072B2',size=.25)
gp1.5.2=ggplotly(gg1.5.2)
#gp1.5.2


#Analyse no. of deaths wrt notes column
req=req %>%
    mutate(Deathnum = case_when(
               req$Notes %in% "Brought dead" ~ "2",
               req$Notes %in% "Brought Dead" ~ "2",
               req$Notes %in% "Died at her residence" ~ "3",
               req$Notes %in% "Died at his residence" ~ "3",
               req$Notes %in% "Died at his residence on" ~ "3",
               req$Notes %in% "Died at residence" ~ "3",
               req$Notes %in% "Not hospitalized" ~ "3",
               req$Notes %in% "01-08-2020" ~ "3",
               req$Notes %in% "NA" ~ "1",
               req$Notes %in% NA ~ "1",
               ))
req=req %>%
    mutate(Death = case_when(
               req$Notes %in% "Brought dead" ~ "BROUGHT DEAD",
               req$Notes %in% "Brought Dead" ~ "BROUGHT DEAD",
               req$Notes %in% "Died at her residence" ~ "DIED AT RESIDENCE",
               req$Notes %in% "Died at his residence" ~ "DIED AT RESIDENCE",
               req$Notes %in% "Died at his residence on" ~ "DIED AT RESIDENCE",
               req$Notes %in% "Died at residence" ~ "DIED AT RESIDENCE",
               req$Notes %in% "Not hospitalized" ~ "DIED AT RESIDENCE",
               req$Notes %in% "01-08-2020" ~ "DIED AT RESIDENCE",
               req$Notes %in% "NA" ~ "HOSPITALISED",
               req$Notes %in% NA ~ "HOSPITALISED",
               ))
#plotting district wise
ddist=ggplot(req,aes(x = District, fill = Death)) +geom_bar(color = "black", position = "dodge") + scale_fill_viridis_d(option = "plasma") + ggtitle("Barplot of Place of Death(District Wise)") + xlab("Place of Death") + ylab("Count of Deaths")+theme_light()+theme(axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))
ddistg=ggplotly(ddist)
#ddistg
#save ddist
###NAME OF PNGFILE
name1 = paste("dist.wise_place","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=ddist ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("dist.wise_place","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(ddistg, file=path, selfcontained = FALSE, libdir = "plotly.html")
#place of death district wise.


req_dist_bar <- data.frame(District = character(), Total_Death = integer(), Hospitalised = integer(),Brought_dead = integer(),Died_at_Residence=integer(),percentage_Hospitalised=double(),percentage_Brought_dead=double(),percentage_Died_at_Residence=double())
unique_district_names_bar <- unique(req$District)
unique_district_names_bar <- sort(unique_district_names_bar)
for(i in seq(length(unique_district_names_bar)))
#i=5
{
    sub_data_bar <- subset(req, req$District==unique_district_names_bar[i])
    m1 <- sum(table(sub_data_bar$Deathnum))
    m2 <- table(sub_data_bar$Deathnum)[1]
    m3 <- table(sub_data_bar$Deathnum)[2]
    m4=table(sub_data_bar$Deathnum)[3]
    m5=round((m2/m1)*100,3)
    m6=round((m3/m1)*100,3)
    m7=round((m4/m1)*100,3)
    temp_bar <- data.frame(unique_district_names_bar[i],m1,m2,m3,m4,m5,m6,m7)
    req_dist_bar <- rbind(req_dist_bar,temp_bar)
}
names(req_dist_bar) <- c("District", "Total_Death", "Hospitalised", "Brought Dead","Died at Residence","percentage_Hospitalised","percentage_Brought_Dead","percentage_Died_at_Residence")
req_dist_bar_ord=req_dist_bar %>% arrange(Total_Death) %>% mutate(District=factor(District, levels=District))
req_dist_bar_ord[is.na(req_dist_bar_ord)]=0
#dbar=ggplot(req_dist_bar_ord,aes(x = District)) +geom_bar(color = "black", position = "dodge",) + scale_fill_viridis_d(option = "plasma") + ggtitle("Barplot of Place of Death(District Wise)") + xlab("Place of Death") + ylab("Count of Deaths") + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))
#save csv for death district wise
write.csv(x=req_dist_bar_ord,file="../csv/req_dist_bar_ord.csv",row.names = FALSE)

##District wise place of death
death_dist=data.frame(District = character(),Place_of_Death=character())
unique_district_names_bar <- unique(req$District)
unique_district_names_bar <- sort(unique_district_names_bar)
for(i in seq(length(unique_district_names_bar)))
#i=9
{
    death_dist=data.frame(District = character(),Place_of_Death=character())
    sub_data_bar_dist <- subset(req, req$District==unique_district_names_bar[i])  
    k1=sub_data_bar_dist$Death
    temp_bar_dist <- data.frame(unique_district_names_bar[i],k1)
    death_dist <- rbind(death_dist,temp_bar_dist)
    names(death_dist) <- c("District", "Place_of_Death")
    #death_dist[is.na(death_dist)]=0
    headdist<- paste("", unique_district_names_bar[i], sep = " ")
    distplace=ggplot(death_dist,aes(x = Place_of_Death, fill = Place_of_Death)) +geom_bar(color = "black",position = position_dodge(width = .8), width = 0.4) + scale_fill_viridis_d(option = "plasma") + ggtitle(headdist) + xlab("Place of Death") + ylab("Count of Deceased") +theme_light()+theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=15), axis.title.x = element_text(size=30,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=30,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=40,color = "#D55E00")) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5,size =18,face = "bold"))
distplacegp=ggplotly(distplace)
n1 <- paste(i,"place_district",sep="-")
name = paste(n1,"html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
htmlwidgets::saveWidget(distplacegp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste(n1,"png",sep=".")
#name2 <- paste0("summertime/Sandipan/plots/", name1)
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=distplace ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}    

#Scatter plot for death(place) wrt District
req_dist=subset(data,as.numeric(data$Difference2)>0)
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
req_dist_scat <- data.frame(District = character(), Total_Death = double(), Hospitalised = double(),Not_Hospitalised = double(),Ratio_of_Hospitalised=double(),Ratio_of_Not_Hospitalised=double())
unique_district_names_place <- unique(req_dist$District)
unique_district_names_place <- sort(unique_district_names_place)
for(i in seq(length(unique_district_names_place)))
{
    sub_data_place <- subset(req_dist, req_dist$District==unique_district_names_place[i])
    m1 <- sum(table(sub_data_place$Death))
    m2 <- table(sub_data_place$Death)[1]
    m3 <- table(sub_data_place$Death)[2]
    m4=round(m2/m1,3)
    m5=round(m3/m1,3)
    temp_place <- data.frame(unique_district_names_place[i],m1,m2,m3,m4,m5)
    req_dist_scat <- rbind(req_dist_scat,temp_place)
}
names(req_dist_scat) <- c("District", "Total_Death", "Hospitalised", "Not_Hospitalised","Ratio_of_Hospitalised","Ratio_of_Not_Hospitalised")

req_dist_scat_ord_new1=req_dist_scat %>% arrange(Total_Death) %>% mutate(District=factor(District, levels=District)) 
#save csv req_dist_scat_ord
write.csv(x=req_dist_scat_ord_new1,file="../csv/req_dist_scat_ord.csv",row.names = FALSE)

#Scatter plot for death(place) wrt District all
dist_dscat <- ggplot(req_dist_scat_ord_new1,aes(x =Total_Death,y=Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("All Districts") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+geom_text(aes(label = District))+geom_abline(intercept = 0.95,slope=0)
dist_dscatplot <- ggplot(req_dist_scat_ord_new1,aes(x =Total_Death,y=Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("All Districts") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+ggrepel::geom_text_repel(data = req_dist_scat_ord_new1,aes(label=District)) +geom_abline(intercept = 0.95,slope=0)
dist_dscatgp=ggplotly(dist_dscat)

###save dist_dscat
name1 = paste("scatter_place","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=dist_dscatplot,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scatter_place","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(dist_dscatgp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#Scatter plot for death(place) wrt District all(<500)
dist_dscat2 <- ggplot(req_dist_scat_ord_new1,aes(x = Total_Death, y = Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("District(Total Death<500)") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) +geom_text(aes(label = District))+xlim(0,500) +geom_abline(intercept = 0.95,slope=0)
dist_dscatplot2 <- ggplot(req_dist_scat_ord_new1,aes(x =Total_Death,y=Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("District(Total Death<500)") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+ggrepel::geom_text_repel(data = req_dist_scat_ord_new1,aes(label=District))+xlim(0,500)+geom_abline(intercept = 0.95,slope=0)
dist_dscat2gp=ggplotly(dist_dscat2)

###save dist_dscat
name1 = paste("scatter_place_500","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=dist_dscatplot2 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scatter_place_500","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(dist_dscat2gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#Scatter plot for death(place) wrt District all(500<td<1500)
dist_dscat3<- ggplot(req_dist_scat_ord_new1,aes(x = Total_Death, y = Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("Districts(500<Total Death<1500)") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) +geom_text(aes(label = District))+xlim(500,1500)+geom_abline(intercept = 0.95,slope=0)
dist_dscatplot3 <- ggplot(req_dist_scat_ord_new1,aes(x =Total_Death,y=Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("Districts(500<Total Death<1500)") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+ggrepel::geom_text_repel(data = req_dist_scat_ord_new1,aes(label=District))+xlim(500,1500)+geom_abline(intercept = 0.95,slope=0)
dist_dscat3gp=ggplotly(dist_dscat3)

###save dist_dscat3
name1 = paste("scatter_place_1500","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=dist_dscatplot3 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scatter_place_1500","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(dist_dscat3gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#Scatter plot for death(place) wrt District all(1500<td<15000)
dist_dscat4<- ggplot(req_dist_scat_ord_new1,aes(x = Total_Death, y = Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("Districts(1500<Total Death<25000)") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5)) +geom_text(aes(label = District))+xlim(1500,25000) + geom_abline(intercept = 0.95,slope=0)
dist_dscatplot4 <- ggplot(req_dist_scat_ord_new1,aes(x =Total_Death,y=Ratio_of_Hospitalised))+xlab("Total Deceased") + ylab("Ratio of Hospitalised patients") + ggtitle("Districts(1500<Total Death<25000)") +theme_light()+ theme(legend.position = "none",axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + geom_point(aes(size=Total_Death,color=Ratio_of_Hospitalised))+guides(size=F)+scale_colour_viridis_c(option = "C")+scale_size_continuous(range = c(2,10))+theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))+ggrepel::geom_text_repel(data = req_dist_scat_ord_new1,aes(label=District))+xlim(1500,25000) + geom_abline(intercept = 0.95,slope=0)
dist_dscat4gp=ggplotly(dist_dscat4)

###save dist_dscat4
name1 = paste("scatter_placebig","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=dist_dscatplot4,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("scatter_placebig","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(dist_dscat4gp, file=path, selfcontained = FALSE, libdir = "plotly.html")

#separating waves wrt dates for MB date wise analysis of notes column

req$Difference3=difftime("2020-11-01",req$`MB.Date`,units = "days")
req$Difference4=difftime(req$`MB.Date`,"2021-02-27",units = "days")
wave_1_new=subset(req,as.numeric(req$Difference3)>0)
wave_2_new=subset(req,as.numeric(req$Difference4)>0&as.numeric(req$Difference4)<155)
wave_1.5_new=subset(req,as.numeric(req$Difference4)<0&as.numeric(req$Difference4>-118))
# plot of notes wrt mb date
Deathplot=ggplot(req,aes(x=Death,fill=Death))+geom_bar(color = "black", position = "dodge") + scale_fill_viridis_d(option = "plasma")+labs(title="Barplot of Place of Death",x="Place of Death",y="Count of Deceased")+theme_light()+theme(axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5,size = 18,face = "bold"))
gpDeathplot=ggplotly(Deathplot)
#gpDeathplot
#save gpdeathplot
###NAME OF PNGFILE
name1 = paste("Deathplot","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots/", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=Deathplot ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("Deathplot","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(gpDeathplot, file=path, selfcontained = FALSE, libdir = "plotly.html")

#creating data frame for barplot
wave_1_new=subset(req,as.numeric(req$Difference3)>0)
wave_1_new=wave_1_new %>%
    mutate(WaveName = case_when(
               wave_1_new$Difference3 %in% as.numeric(wave_1_new$Difference3)>0 ~ "1st Wave",
               ))
wave_2_new=subset(req,as.numeric(req$Difference4)>0&as.numeric(req$Difference4)<155)
wave_2_new=wave_2_new %>%
    mutate(WaveName = case_when(
               wave_2_new$Difference4 %in% as.numeric(wave_2_new$Difference4)>0 ~ "2nd Wave",
               ))
death.frame=rbind(wave_1_new,wave_2_new)
dp=ggplot(death.frame,aes(x = Death, fill = WaveName)) +geom_bar(color = "black", position = "dodge") + scale_fill_viridis_d(option = "plasma") + ggtitle("Barplot of Place of Death(Wave Wise)") + xlab("Place of Death") + ylab("Count of Deaths")+theme_light()+theme(axis.text.y = element_text(hjust = 1, size=10), axis.title.x = element_text(size=15,face = "bold",color = "#D55E00"),axis.title.y = element_text(size=15,face = "bold",color = "#D55E00"),plot.title = element_text(face="bold",size=24,color = "#D55E00")) + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5))
dplace=ggplotly(dp)
#save dplace
###NAME OF PNGFILE
name1 = paste("placeofdeath_wave","png", sep=".")
###NAME OF PNGFILE with DIRECTORY path
#name2 = paste0("summertime/Sandipan/plots//", name1)
name2 = paste0("../graphs/", name1)
##SAVING GGPLOT IN THAT DIRECTORY
ggsave(name2, plot=dp ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
###NAME OF PNGFILE with DIRECTORY path
name = paste("placeofdeath_wave","html", sep=".")
#path <- file.path(getwd(), "summertime/Sandipan/plots/", name)
path <- file.path(getwd(), "../graphs/", name)
##CREATE HTML PLOTLY GRAPH
htmlwidgets::saveWidget(dplace, file=path, selfcontained = FALSE, libdir = "plotly.html")

#data.frame1=cbind.data.frame(death.frame[,c(17,20)])
#t=t(table(data.frame1))
#View(t)
#percent_wave1=prop.table(t[1,])*100
#percent_wave2=prop.table(t[2,])*100
#percent=cbind.data.frame(a*100,b*100)






                                        
                                       













