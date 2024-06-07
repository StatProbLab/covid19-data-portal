###############################################################################
## Title: Inconsistencies in Early Warning District Data - Karnataka         ##
## Input: earlywarning/DISTRICTINF HR.xlsx                                   ##
## Output: csv/HRerror/[j]-data.csv                                          ##
## Date Modified: 22nd May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)
library(viridis)

#Read data
data<- read_excel("earlywarning/DISTRICTINF HR.xlsx")

#Format date correctly
data$Date<- as.Date(data$Date, format = "%d/%m/%Y")
data=data[,c(1,2,3,4,5)]

#district wise formation
df <- data[order(data$DISTRICTCODE), ]

#subsetting district wise
unique_district<- unique(df$DISTRICTCODE)
unique_district<- sort(unique_district)

for(j in seq(length(unique_district)))
{
  #j=5
  df_new<- data.frame(District=character(),Date=character(),total_infected=integer(),total_recovered=integer(),total_death=integer(),diff_TINF=integer(),diff_TREC=integer(),diff_TDEC=integer())
  
  sub_data <- subset(df,df$DISTRICTCODE==unique_district[j])
  
  {for (i in seq(unique(nrow(sub_data)-1))) 
  {
    m1=sub_data$Date[i]
    m2=sub_data$TINF[i]
    m3=sub_data$TREC[i]
    m4=sub_data$TDEC[i]
    m5=sub_data$TINF[i+1]-sub_data$TINF[i]
    m6=sub_data$TREC[i+1]-sub_data$TREC[i]
    m7=sub_data$TDEC[i+1]-sub_data$TDEC[i]
    temp<- data.frame(j,i,m1,m2,m3,m4,m5,m6,m7)
    df_new<- rbind(df_new,temp)
}
}
  
  names(df_new) <- c("District","No.","Date","Total infected","Total Recovered","Total deceased","diff_TINF","diff_TREC","diff_TDEC")
  
  #problematic data
  df_neg=subset(df_new,df_new$diff_TINF<0|df_new$diff_TREC<0|df_new$diff_TDEC<0)
  
  #Writing district data
  my_name_1 <- paste(j,"data",sep="-")
  my_name_2 <- paste(my_name_1,"csv",sep=".")
  my_name <- paste0("csv/HRerror/", my_name_2)
  write.csv(df_neg, file = my_name, row.names=FALSE)
}

