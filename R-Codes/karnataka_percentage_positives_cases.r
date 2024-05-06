###############################################################
## Title: Percentage of Positive Tests in Karnataka          ##
## Input: karnatakadatabriefstesting.csv                     ##
## Output: Plot of Date Vs Percentage of Positive Cases      ##
## Date Modified: 02-05-2024                                 ##
###############################################################

library(ggplot2)
library(plotly)

testing = read.csv("../Data/karnatakadatabriefstesting.csv",header=TRUE)

samples = testing[,1]

negatives = testing[,2]
positives = testing[,3]

frac = 100*cumsum(positives)/cumsum(samples)

n=length(frac)
dates=seq(as.Date('2020-03-12'),by='days',length=n)
dates=format(as.Date(dates,"%y-%m-%d"),"%d-%b-%y")

df = data.frame("Percentage positive"=frac,Date=dates, "Total tests done" = cumsum(samples),"Total positives"=cumsum(positives))
df$Date<- factor(df$Date,levels=unique(df$Date))

g=ggplot(df,aes(x=Date,y=Percentage.positive,label1=Total.tests.done,label2=Total.positives))+geom_point(color="orange")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+theme_bw()+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+labs(y="Percentage of positives")+scale_x_discrete(breaks = df$Date[c(T,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F)])

name1 = paste("cp","test.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)

cptest = ggplotly(g,tooltip=c("x","y","label1","label2"))

name = paste("cp","test.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(cptest, file=path, selfcontained = FALSE, libdir = "plotly.html")