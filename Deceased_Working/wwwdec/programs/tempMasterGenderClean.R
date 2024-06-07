###############################################################################
## Title: Data Cleaning and Sex Variable Standardization                     ##
## Input: "mediadata/Master.csv"                      	                     ##
## Output: NA                                                                ##
## Date Modified: 21st May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")


#Reading data
#data <- read.csv("C:/Users/srini/Dropbox/summertime/Files/FinalMASTERfileclean.csv", header = TRUE)
data <- read.csv("mediadata/Master.csv")

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

