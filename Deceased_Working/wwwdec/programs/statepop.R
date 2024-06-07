##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)
library(viridis)

#Read data
data<- read_csv("~/Dropbox/summertime/wwwdec/csv/indiaactivetrans.csv")
df<- read_csv("~/Dropbox/summertime/wwwdec/mediadata/states.csv")

df=df[,c(2,3)]
df$Pop2020=df$Population*1.15
df$pop50million=(df$Pop2020*50)/1000000
df$pop1000million=df$pop50million*20
df$pop1500million=df$pop50million*30
df$pop0.2percent=df$Pop2020*(0.002)

names(df)=c("State","Population-2011","Population-2020","Target-1","Target-2","Target-3","Target-4")

my_name_1 <- paste("statepop",sep="-")
my_name_2 <- paste(my_name_1,"csv",sep=".")
my_name <- paste0("../csv/", my_name_2)
write.csv(df, file = my_name, row.names=FALSE)