###############################################################
## Title: Vaccination Data for Districts of Karnataka        ##
## Input: finalPopulationData.xlsx                           ##
##        VaccinationData.csv                                ##                                
##        karnatakaPop.csv                                   ##
## Output: Various Plots on Vaccination Data                 ##
## Date Modified: 02-05-2024                                 ##
###############################################################


#Libraries required
library(ggplot2)
library(plotly)
library(viridis)
library(htmlwidgets)
library(readxl)
library(forcats)
library(plyr)
library(ggrepel)
library(gganimate)
library(Rcpp)
library(gifski)
library(png)
library(magick)
library(dplyr)
library(tidyr)

#Read data
pop_data <- read_excel("../csv/finalPopulationData.xlsx")
vac_data <- read.csv("../csv/VaccinationData.csv", as.is = T)
kar_pop_data <- read.csv("../csv/karnatakaPop.csv")

#Initializing variable
num_col <- ncol(vac_data) - 1

#Creating dataframes required
dose1_df <- data.frame(date = character(), district = character(), cnt = integer(), percent = double())
dose2_df <- data.frame(date = character(), district = character(), cnt = integer(), percent = double())
prec_df <- data.frame(date = character(), district = character(), cnt = integer(), percent = double())

#Unique district names gathered
unique_district_names <- pop_data$district

#Getting unique dates present in the vaccination data
unique_dates <- colnames(vac_data)
unique_dates <- unique_dates[2:length(unique_dates)]

for(i in seq(length(unique_dates)))
{
  unique_dates[i] <- gsub("X","",unique_dates[i])
  unique_dates[i] <- gsub("[.]","-",unique_dates[i])
  unique_dates[i] <- substr(unique_dates[i], 1, 8)
}

unique_dates <- unique(unique_dates)
pc_date_ind <- which(unique_dates=="10-01-22")
pc_dates <- unique_dates[(pc_date_ind):(length(unique_dates))]

#Dose 1, Dose 2 and prec dose count and percentage calculation

for(i in seq(length(unique_district_names)))
{
  subdata <- subset(vac_data, vac_data$district == unique_district_names[i])
  subdata <- subdata[,2:ncol(subdata)]
  val <- as.numeric(subset(pop_data,pop_data$district == unique_district_names[i])$data, digits = 2)
  #d1 <- seq(1,ncol(subdata),2)
  #d2 <- seq(2,ncol(subdata),2)
  
  #Generating column numbers to be extracted
  
  d1 <- vector()
  d2 <- vector()
  pc <- vector()
  cnt_ <- 1
  ind <- 1
  
  for(k in seq(length(unique_dates)))
  {
    if(unique_dates[k] == "10-01-22")
    {
      break
    }
    
    else
    {
      d1[ind] <- cnt_
      cnt_ <- cnt_ + 2
      ind <- ind + 1
    }
  }
  
  ind_sub <- ind
  
  for(k in ind_sub:(length(unique_dates)))
  {
    d1[ind] <- cnt_
    cnt_ <- cnt_ + 3
    ind <- ind + 1
  }
  
  cnt_ <- 2
  ind <- 1
  
  for(k in seq(length(unique_dates)))
  {
    if(unique_dates[k] == "10-01-22")
    {
      break
    }
    
    else
    {
      d2[ind] <- cnt_
      cnt_ <- cnt_ + 2
      ind <- ind + 1
    }
  }
  
  ind_sub <- ind
  pc_cnt <- cnt_ + 1
  
  for(k in ind_sub:(length(unique_dates)))
  {
    d2[ind] <- cnt_
    cnt_ <- cnt_ + 3
    ind <- ind + 1
  }
  
  ind <- 1
  
  for(k in ind_sub:(length(unique_dates)))
  {
    pc[ind] <- pc_cnt
    pc_cnt <- pc_cnt + 3
    ind <- ind + 1
  }
  
  #Extracting values
  
  for(j in seq(length(d1)))
  {
    temp <- round(subdata[,d1[j]]/val,5)
    temp <- temp * 100
    new_entry <- c(unique_dates[j], unique_district_names[i], subdata[,d1[j]], temp)
    dose1_df <- rbind(dose1_df, new_entry)
  }
  
  for(j in seq(length(d2)))
  {
    temp <- round(subdata[,d2[j]]/val,5)
    temp <- temp * 100
    new_entry <- c(unique_dates[j], unique_district_names[i], subdata[,d2[j]], temp)
    dose2_df <- rbind(dose2_df, new_entry)
  }
  
  for(j in seq(length(pc)))
  {
    temp <- round(subdata[,pc[j]]/val,5)
    temp <- temp * 100
    new_entry <- c(pc_dates[j], unique_district_names[i], subdata[,pc[j]], temp)
    prec_df <- rbind(prec_df, new_entry)
  }
}

#Renaming columns of dataframes
names(dose1_df) <- c("date","district","count","percentage")
names(dose2_df) <- c("date","district","count","percentage")
names(prec_df) <- c("date","district","count","percentage")

#Merging them into single dataframe
categ <- rep("Dose 1", nrow(dose1_df))
dummy_d1 <- cbind(dose1_df, categ)
categ <- rep("Dose 2", nrow(dose2_df))
dummy_d2 <- cbind(dose2_df, categ)
categ <- rep("Prec Dose", nrow(prec_df))
dummy_d3 <- cbind(prec_df, categ)
dose1_and_dose2 <- rbind(dummy_d1, dummy_d2, dummy_d3)

#Karnataka data
tot_percent_kar <- kar_pop_data$data
karnataka_data <- data.frame(matrix("NA", ncol = 4))
names(karnataka_data) <- c("date","count", "percentage", "categ")

for(i in seq(length(unique_dates)))
{
  subdata1 <- subset(dose1_df, dose1_df$date == unique_dates[i])
  subdata2 <- subset(dose2_df, dose2_df$date == unique_dates[i])
  subdata3 <- subset(prec_df, prec_df$date == unique_dates[i])
  d1_cnt <- sum(as.numeric(subdata1$count))
  d2_cnt <- sum(as.numeric(subdata2$count))
  pc_cnt <- sum(as.numeric(subdata3$count))
  d1_perc <- round(((d1_cnt / tot_percent_kar)*100),3)
  d2_perc <- round(((d2_cnt / tot_percent_kar)*100),3)
  pc_perc <- round(((pc_cnt / tot_percent_kar)*100),3)
  karnataka_data <- rbind(karnataka_data, c(unique_dates[i],d1_cnt,d1_perc,"Dose 1"))
  karnataka_data <- rbind(karnataka_data, c(unique_dates[i],d2_cnt,d2_perc,"Dose 2"))
  karnataka_data <- rbind(karnataka_data, c(unique_dates[i],pc_cnt,pc_perc,"Prec Dose"))
}

karnataka_data <- karnataka_data[2:nrow(karnataka_data),]
#karnataka_data$date <- format(as.Date(karnataka_data$date, format = "%d-%m-%y"),format = "%d-%m-%y")
karnataka_data <- karnataka_data[order(as.Date(karnataka_data$date, format="%d-%m-%Y")),]
karnataka_data$date <- as.Date(karnataka_data$date, format = "%d-%m-%y")
karnataka_data$percentage <- as.numeric(karnataka_data$percentage)

##PLOTS

#Karnataka plot
p1_p <- ggplot(karnataka_data, aes(x=date, y=percentage, group=categ, color=categ)) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,100,10)) + scale_color_viridis_d(option = "turbo", name = "Vaccine") + xlab("Dates") + ylab("Percentage of adult population") + ggtitle("Karnataka - Vaccination") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(size = 28))
p1_h <- ggplot(karnataka_data, aes(x=date, y=percentage, group=categ, color=categ)) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,100,10)) + scale_color_viridis_d(option = "turbo", name = "Vaccine") + xlab("Dates") + ylab("Percentage of adult population") + ggtitle("Karnataka - Vaccination") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(size = 18))
gp <- ggplotly(p1_h, tooltip = c("x","y","group"))
name = paste("Karnataka-vac","html", sep=".")
path <- file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("Karnataka-vac","png",sep=".")
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=p1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#District wise dose-1 and dose-2 vaccination graphs
for(i in seq(length(unique_district_names)))
{
  subdata <- subset(dose1_and_dose2, dose1_and_dose2$district == unique_district_names[i])
  subdata$percentage <- as.numeric(subdata$percentage)
  subdata$date <- as.Date(subdata$date, format = "%d-%m-%y")
  p1_p <- ggplot(subdata, aes(x=date, y=percentage, group=categ, color=categ)) + geom_point(size=3) + scale_color_viridis_d(option = "turbo", name = "Vaccine") + xlab("Dates") + ylab("Percentage of adult population") + ggtitle(unique_district_names[i]) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(size = 28),legend.title=element_text(size=16),legend.text=element_text(size=15))
  p1_h <- ggplot(subdata, aes(x=date, y=percentage, group=categ, color=categ)) + geom_point(size=3) + scale_color_viridis_d(option = "turbo", name = "Vaccine") + xlab("Dates") + ylab("Percentage of adult population") + ggtitle(unique_district_names[i]) + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 28), axis.title = element_text(color = "#D55E00", size = 24), axis.text.y = element_text(size = 18),axis.text.x = element_text(size = 18))
  gp <- ggplotly(p1_h, tooltip = c("x","y","group"))
  temp_n <- paste(i,"vac", sep="-")
  name = paste(temp_n,"html", sep=".")
  path <- file.path(getwd(), "../graphs", name)
  htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
  name1 <- paste(temp_n,"png",sep=".")
  name2 <- paste0("../graphs/", name1)
  ggsave(name2, plot=p1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}

#Districts and latest cumulative dose percentage
district_order_perc_df <- data.frame(district = character(), d1_perc = double(), d2_perc = double(), pc_perc = double(), d1_cnt = integer(), d2_cnt = integer(), pc_cnt = integer())

for(i in seq(length(unique_district_names)))
{
  tempdata1 <- subset(dose1_df, dose1_df$district == unique_district_names[i])
  tempdata2 <- subset(dose2_df, dose2_df$district == unique_district_names[i])
  tempdata3 <- subset(prec_df, prec_df$district == unique_district_names[i])
  d1p <- tempdata1$percentage[nrow(tempdata1)]
  d2p <- tempdata2$percentage[nrow(tempdata2)]
  pcp <- tempdata3$percentage[nrow(tempdata3)]
  d1c <- tempdata1$count[nrow(tempdata1)]
  d2c <- tempdata2$count[nrow(tempdata2)]
  pcc <- tempdata3$count[nrow(tempdata3)]
  district_order_perc_df <- rbind(district_order_perc_df, c(unique_district_names[i], d1p, d2p, pcp, d1c, d2c, pcc))
}

names(district_order_perc_df) <- c("district", "dose1_perc", "dose2_perc", "prec_perc", "dose1_count", "dose2_count", "prec_count")
district_order_perc_df$dose1_perc <- as.numeric(district_order_perc_df$dose1_perc)
district_order_perc_df$dose2_perc <- as.numeric(district_order_perc_df$dose2_perc)
district_order_perc_df$prec_perc <- as.numeric(district_order_perc_df$prec_perc)
district_order_perc_df$dose1_count <- as.numeric(district_order_perc_df$dose1_count)
district_order_perc_df$dose2_count <- as.numeric(district_order_perc_df$dose2_count)
district_order_perc_df$prec_count <- as.numeric(district_order_perc_df$prec_count)

#Ordering districts by dose 1 percentage
p1_p <- district_order_perc_df %>% mutate(district = fct_reorder(district, dose1_perc)) %>% ggplot(aes(x=district, y=dose1_perc, group=1, color = "blue")) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,150,10), limits = c(0,150)) + xlab("Districts") + ylab("Percentage of dose1") + ggtitle("Dose 1 vaccination across districts") + theme_minimal() + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle = 45,hjust = 1,size = 28))
p1_h <- district_order_perc_df %>% mutate(district = fct_reorder(district, dose1_perc)) %>% ggplot(aes(x=district, y=dose1_perc, group=1, color = "blue")) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,150,10), limits = c(0,150)) + xlab("Districts") + ylab("Percentage of dose1") + ggtitle("Dose 1 vaccination across districts") + theme_minimal() + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 28), axis.title = element_text(color = "#D55E00", size = 24), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle = 45,hjust = 1,size = 18))
gp <- ggplotly(p1_h, tooltip = c("x","y"))
name = paste("vacDistrDose1","html", sep=".")
path <- file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("vacDistrDose1","png",sep=".")
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=p1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#Ordering districts by dose 2 percentage
p1_p <- district_order_perc_df %>% mutate(district = fct_reorder(district, dose2_perc)) %>% ggplot(aes(x=district, y=dose2_perc, group=1, color = "red")) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,150,10), limits = c(0,150)) + xlab("Districts") + ylab("Percentage of dose2") + ggtitle("Dose 2 vaccination across districts") + theme_minimal() + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle = 45,hjust = 1,size = 28))
p1_h <- district_order_perc_df %>% mutate(district = fct_reorder(district, dose2_perc)) %>% ggplot(aes(x=district, y=dose2_perc, group=1, color = "red")) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,150,10), limits = c(0,150)) + xlab("Districts") + ylab("Percentage of dose2") + ggtitle("Dose 2 vaccination across districts") + theme_minimal() + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 28), axis.title = element_text(color = "#D55E00", size = 24), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle = 45,hjust = 1,size = 18))
gp <- ggplotly(p1_h, tooltip = c("x","y"))
name = paste("vacDistrDose2","html", sep=".")
path <- file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("vacDistrDose2","png",sep=".")
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=p1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#Ordering districts by prec dose percentage
p1_p <- district_order_perc_df %>% mutate(district = fct_reorder(district, prec_perc)) %>% ggplot(aes(x=district, y=prec_perc, group=1, color = "red")) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,50,10), limits = c(0,50)) + xlab("Districts") + ylab("Percentage of dose2") + ggtitle("Dose 2 vaccination across districts") + theme_minimal() + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle = 45,hjust = 1,size = 28))
p1_h <- district_order_perc_df %>% mutate(district = fct_reorder(district, prec_perc)) %>% ggplot(aes(x=district, y=prec_perc, group=1, color = "red")) + geom_line(size=2) + scale_y_continuous(breaks = seq(0,50,10), limits = c(0,50)) + xlab("Districts") + ylab("Percentage of dose2") + ggtitle("Dose 2 vaccination across districts") + theme_minimal() + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 28), axis.title = element_text(color = "#D55E00", size = 24), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle = 45,hjust = 1,size = 18))
gp <- ggplotly(p1_h, tooltip = c("x","y"))
name = paste("vacDistrPrecDose","html", sep=".")
path <- file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("vacDistrPrecDose","png",sep=".")
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=p1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

# Dose 1 vs Dose 2 percentage
p1_p <- ggplot(district_order_perc_df, aes(x=dose1_perc, y=dose2_perc, color = district, size = dose1_count + dose2_count, label = district)) + geom_point() + scale_color_viridis_d(option = "plasma") + xlab("Dose 1 percentage") + ylab("Dose 2 percentage") + ggtitle("Vaccination - Dose 1 vs Dose 2 percentage") + theme_minimal() + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(size = 28),legend.title=element_text(size=16),legend.text=element_text(size=15)) + geom_text_repel(color = "black", size=3.5)
p1_h <- ggplot(district_order_perc_df, aes(x=dose1_perc, y=dose2_perc, color = district, size = dose1_count + dose2_count, label = district)) + geom_point() + scale_color_viridis_d(option = "plasma") + xlab("Dose 1 percentage") + ylab("Dose 2 percentage") + ggtitle("Vaccination - Dose 1 vs Dose 2 percentage") + theme_minimal() + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 28), axis.title = element_text(color = "#D55E00", size = 24), axis.text.y = element_text(size = 18),axis.text.x = element_text(size = 18))
gp <- ggplotly(p1_h, tooltip = c("x","y","label","size"))
name = paste("dose1VsDose2","html", sep=".")
path <- file.path(getwd(), "../graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("dose1VsDose2","png",sep=".")
name2 <- paste0("../graphs/", name1)
ggsave(name2, plot=p1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#Creating final dataframe
df <- join(district_order_perc_df, pop_data, by = "district")
names(df) <- c("District","Dose1-%","Dose2-%","PrecDose-%","Dose1-count","Dose2-count","PrecDose-count","Population-2020","Population-2011-census","Factor-used", "Cowin-Population")
cd_1 <- rep(0, nrow(df))
cd_2 <- rep(0, nrow(df))
cd_3 <- rep(0, nrow(df))

#Calculating percentages of dose1, dose2 and prec dose using Cowin pop

for(i in seq(length(df$District)))
{
  cd_1[i] <- round(((df$`Dose1-count`[i] / df$`Cowin-Population`[i])*100),3)
  cd_2[i] <- round(((df$`Dose2-count`[i] / df$`Cowin-Population`[i])*100),3)
  cd_3[i] <- round(((df$`PrecDose-count`[i] / df$`Cowin-Population`[i])*100),3)
}

df$`Cow-Dose1` <- cd_1
df$`Cow-Dose2` <- cd_2
df$`Cow-PrecDose` <- cd_3
df$Date <- dose1_df$date[nrow(dose1_df)]
#df = df[-c(nrow(df)),]

#Writing data
write.csv(df, file = "../csv/finalData.csv", row.names = FALSE)
