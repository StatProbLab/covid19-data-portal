###############################################################################
## Title: Plots for multiple R file                                          ##
## Input: File requirements                                                  ##
## Output: Plots for each file                                               ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/programs/")

source("KA(LAMDA).R")
print("Done for Karnataka plots")

source("KAcritical.R")
print("Done for Karnataka critical")

source("kaactivetrans.R")
print("Done for file transpose")

source("dist_wise_lamda(t).R")
print("Done for Karnataka District plots")

source("distwisecritical.R")
print("Done for Karnataka-District days")

source("plotcritical.R")
print("Done graphs")