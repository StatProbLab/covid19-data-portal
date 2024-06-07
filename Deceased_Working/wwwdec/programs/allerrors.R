###############################################################################
## Title: Concatenating Covid-19 Data for Karnataka Districts                ##
## Input: csv/MBerror/large1.csv | csv/MBerror/large2.csv |                  ##
## csv/MBerror/negative.csv | csv/MBerror/negative1.csv                      ##
## Output: csv/MBerror/Allerror.csv                                          ##
## Date Modified: 2nd May 2024                                               ##
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
library(data.table)

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

#Read data
large1 <- read_csv("csv/MBerror/large1.csv")
large2 <- read_csv("csv/MBerror/large2.csv")
negative <- read_csv("csv/MBerror/negative.csv")
negative1 <- read_csv("csv/MBerror/negative1.csv")

#bind together
df=rbind(large1,large2,negative,negative1)

#save file all error
write.csv(x=df,file="csv/MBerror/Allerror.csv",row.names = FALSE)


