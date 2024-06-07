###############################################################################
## Title: Preprocessing and Cleaning Deceased Patient Data for Karnataka     ##
## Input: mediadata/Master.csv                                               ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")


#Libraries required
library(readxl)
library(plotly)
library(ggplot2)
library(ggrepel)
library(ggpubr)
library(viridis)
library(htmlwidgets)
library(plyr)

#Reading data
#data <- read.csv("C:/Users/srini/Dropbox/summertime/Files/FinalMASTERfileclean.csv", header = TRUE)
data <- read.csv("mediadata/Master.csv")

#Selecting and Formatting
data <- data[data$District != "Others",]
data <- data[data$District != "NA",]
data <- data[!is.na(data$Sex),]
data <- data[data$Sex != "NA",]
data <- data[data$Sex != "TG",]
data <- data[data$Sex != "O",]
data <- data[data$Sex != "N",]

names(data)[3] = "State P No"
names(data)[4] = "Age In Years"
names(data)[11] = "MB Date"

data$`Age In Years` <- as.numeric(data$`Age In Years`)
data$`Age In Years` <- round(data$`Age In Years`,2)
data$`MB Date` <- as.Date(data$`MB Date`, format = "%Y-%m-%d")
data$DOA <- as.Date(data$DOA, format = "%Y-%m-%d")
data$DOD <- as.Date(data$DOD, format = "%Y-%m-%d")
