###############################################################################
## Title:                                                                    ##
## Input: "mediadata/Master.csv |mediadata/srinidi.csv |                     ##
## mediadata/sandipanclean.csv"	                                             ##
## Output:                                                                   ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


#Libraries required
library(readxl)
#library(xlsx)

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")


#Reading files
data1 <- read.csv("mediadata/Master.csv")
data2 <- read.csv("mediadata/srinidi.csv")
data3 <- read.csv("mediadata/sandipanclean.csv")

write.csv(data1, file = "mediadata/MasterOld.csv", row.names = FALSE)

data_Srinidi <- data2[,c(2:8)]
data_Sandipan <- data3[,c(9:12)]

data_added <- data.frame()
data_added <- cbind(data_Srinidi,data_Sandipan)

names(data1)[1] = "Sno"

start_no <- as.numeric(tail(data1$Sno,n=1)) + 1
row_num <- c(start_no : (start_no + nrow(data_added) - 1))

data_added <- cbind(row_num, data_added)

#names(data_added)[1] = "Sno"

names(data_added) = names(data1)
df = rbind(data1, data_added)
df <- as.data.frame(df)

#Writing files
write.csv(df,file = "mediadata/Master.csv", row.names = FALSE)
#write.xlsx(df, file = "../mediadata/Master.xlsx",row.names = FALSE)
