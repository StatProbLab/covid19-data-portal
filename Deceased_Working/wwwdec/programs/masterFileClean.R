###############################################################################
## Title: Clean and Format Deceased Data                                     ##
## Input: "mediadata/plusNew1.xlsx, mediadata/district_map.xlsx"             ##
## Output: "mediadata/uniqueDistricts.csv, mediadata/uniqueGender.csv,       ##
##          mediadata/srinidi.csv"                                           ##
## Date Modified: 22nd May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

#Libraries required
library(readxl)
#library(xlsx)
library(plyr)
library(stringr)

#Reading data
data <- read_excel("mediadata/plusNew1.xlsx")
#data <- read.csv("../mediadata/plusNew.csv", header=TRUE)
data1 <- read_excel("mediadata/district_map.xlsx")
data$District = str_trim(data$District)

#Renaming columns
names(data1) = c("District","Transformed District","Correct District")

#Converting to required format
for (i in seq(length(data$Sex)))
{
  if(is.na(data$Sex[i]))
  {
    # No action
  }
  
  else
  {
    if (data$Sex[i] == "Male " || data$Sex[i] == "M " || data$Sex[i] == "MAL E " || data$Sex[i] == "M, " || data$Sex[i] == "m " || data$Sex[i] == "MA LE " || data$Sex[i] == "m" || data$Sex[i] == "Male" || data$Sex[i] == "male" || data$Sex[i] == "M")
    {
      data$Sex[i] <- "Male"
    }
    
    if (data$Sex[i] == "Female " || data$Sex[i] == "F " || data$Sex[i] == "Femal e " || data$Sex[i] == "FEM ALE " || data$Sex[i] == " F " || data$Sex[i] == "f " || data$Sex[i] == "FEMA LE " || data$Sex[i] == "f" || data$Sex[i] == "Female" || data$Sex[i] == "female"|| data$Sex[i] == "F")
    {
      data$Sex[i] <- "Female"
    }
    
  }
}

#Joining data to get required dataframe - join
new_data <- join(data,data1,by = "District")

data$District <- new_data$`Correct District`
#data <- data[,-c(1)]
data <- as.data.frame(data)

check_district <- as.data.frame(unique(data$District))
check_gender <- as.data.frame(unique(data$Sex))

#Writing unique district and gender into separate files for checking
write.csv(check_district, file = "mediadata/uniqueDistricts.csv", row.names = FALSE)
write.csv(check_gender, file = "mediadata/uniqueGender.csv", row.names = FALSE)

#Writing into the same file all cleaned data
write.csv(data, file = "mediadata/srinidi.csv", row.names = FALSE)
#write.csv(data, file = "../mediadata/Srinidi.csv", row.names = FALSE)

#system path - "C:/Users/srini/Dropbox/summertime/Files/district_map.xlsx"
