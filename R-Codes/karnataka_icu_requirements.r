###############################################################
## Title: ICU Requirements in Karnataka                      ##
## Input: KAhospital_consolidated.csv                        ##
## Output: Plot of Date Vs Number of Cases                   ##
## Date Modified: 02-05-2024                                 ##
###############################################################

library(ggplot2)
library(plotly)

lol = read.csv("../Data/KAhospital_consolidated.csv")

Discharged = lol$Total.discharged
Deceased = lol$Total.deceased
ICU = lol$Total.ICU

Active_Cases = lol$Total.Active.without.ICU..ICUV..ICVO. + lol$Total.ICU

dates=seq(as.Date('2020-03-09'),by='days',length=length(ICU))
dates=format(as.Date(dates,"%y-%m-%d"),"%b-%d-%Y")

Active_Cases = as.numeric(Active_Cases)
ICU = as.numeric(ICU)

Percentage_of_infected = 100*ICU/(Active_Cases)

df_icu = data.frame(Date = dates,Condition = rep("In ICU",length(dates)),Count = ICU,Percentage_of_infected)
df_icu$Date<- factor(df_icu$Date,levels=unique(df_icu$Date))

k=ggplot(df_icu,aes(x=Date,y=Count,label=Percentage_of_infected))+geom_line(aes(group=1),color="darkred")+geom_point(color="darkred")+theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle("ICU requirements among COVID-19 Patients in Karnataka")+ theme(legend.title = element_blank())+theme(axis.ticks = element_blank())+scale_x_discrete(breaks = df_icu$Date[c(T,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F)])

name1 = paste("ka","icu.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=k)

kp=ggplotly(k,tooltip = c("x","y","group","label"))
name = paste("ka","icu.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(kp, file=path, selfcontained = FALSE, libdir = "plotly.html")