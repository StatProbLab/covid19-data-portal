#Set your current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec")

print("Starting to read data..")
source("programs/readAndFormatDataAG.R")
print("Finished reading data..")

print("Starting to create required dataframes..")
source("programs/dataFramesReqAG.R")
print("Finished creating required dataframes..")

print("Starting plot1..")
source("programs/plot1AG.R")
print("Finished plot1..")

print("Starting plot2..")
source("programs/plot2AG.R")
print("Finished plot2..")

print("Starting plot3..")
source("programs/plot3AG.R")
print("Finished plot3..")

print("Starting plot4..")
source("programs/plot4AG.R")
print("Finished plot4..")

print("Starting plot5..")
source("programs/plot5AG.R")
print("Finished plot5..")

print("Starting plot6..")
source("programs/plot6AG.R")
print("Finished plot6..")

print("Starting plot7..")
source("programs/plot7AG.R")
print("Finished plot7..")

print("Starting plot8..")
source("programs/plot8AG.R")
print("Finished plot8..")

print("Starting plot9..")
source("programs/plot9AG.R")
print("Finished plot9..")

print("Starting Line plot..")
source("programs/timeSeriesAG.R")
print("Finished Line plot..")

print("Starting plot10..")
source("programs/plot10AG.R")
print("Finished plot10..")

print("Starting to write files..")
source("programs/writeFileAG.R")
print("Finished writing files..")

print("Starting kaHospPlot graphs..")
source("programs/kaHospLinePlots.R")
print("Finished kaHospPlot graphs..")
