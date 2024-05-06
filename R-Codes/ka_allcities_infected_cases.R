###############################################################
## Title: Cities timeline stacked graph with cutoff          ##
## Input: KAtrace26June.csv                                  ##
## Output: Plot of Date Vs Number of Childeren               ##
## Date Modified: 06-05-2024                                 ##
###############################################################


# Libraries Required
library(stringr)
library(plyr)
library(ggplot2)
library(plotly)
library(RColorBrewer)

# Reading data of list of Karnataka patients
KAtrace = read.csv("../Data/KAtrace26June.csv",header=TRUE)

# Extracting dataframe with city information
City_df=subset(KAtrace,select=c("Date","City"))
City_df<- subset(City_df,Date!="",select=c("Date","City"))
City_df<- subset(City_df,City!="",select=c("Date","City"))
City_df$Date<- droplevels(factor(City_df$Date))

# Ensures that the order of the dates on the x-axis is correct.
d=as.character(unique(City_df$Date)[8:length(unique(City_df$Date))])
Dates = c("9-Mar","10-Mar","11-Mar","12-Mar","13-Mar","14-Mar","15-Mar","16-Mar","17-Mar","18-Mar","19-Mar","20-Mar",d)
Dates <- factor(Dates,levels = Dates)

# Creates dataframe of counts from the earlier linelist and extracts city names from the phrase
City_df$City <- word(City_df$City,1)
City_df = ddply(City_df,.(Date,City),nrow)
levels(City_df)<- Dates

# Adds zeros for cities added later and sort dataframe
df_ka = data.frame()
for(i in unique(City_df$City)){
  df_c = data.frame()
  for(k in Dates){
    if(nrow((subset(City_df,City == i & Date == k)))>0){
      df_c=rbind(df_c,subset(City_df,City == i & Date == k))
    }else{
      df = data.frame(Date = k,City = i,V1=c(0))
      df_c=rbind(df_c,df)
    }
  }
  df_c$V1 <- cumsum(df_c$V1)
  df_ka = rbind(df_ka,df_c)
}
df_ka$Date = factor(df_ka$Date,levels=Dates)
names(df_ka)<- c("Date","City","Count")

# Indentify cutoff, create list of states that clear the cutoff and don't clear the cutoff, merge.
cutoff=15
today = subset(df_ka,Date == tail(Date,n=1))
keep<- subset(today, Count>=cutoff, select= c(City,Count))
keep<- keep[order(-keep$Count),]
keepcols<- subset(df_ka,City %in% keep$City,select=c("Date", "City", "Count"))
chuckcols<- subset(df_ka,!(City %in% keep$City),select=c("Date", "City", "Count"))
df<- data.frame()
for(i in levels(chuckcols$Date)){
  Table_i = subset(chuckcols,Date==i, select=c("Date", "City", "Count"))
  dfi<- data.frame(i,"Cities with less than 15 cases",sum(Table_i[3]))
  names(dfi)<- c("Date", "City", "Count")
  df<- rbind(df,dfi)
}

# Add and order the labels for the plot
df_ka<- rbind(keepcols,df)
df_ka$City <- factor(df_ka$City, levels =append(as.character(keep$City),"Cities with less than 15 cases",after=length(keep$City)))

# Define the number of colors you want
nb.cols <- length(keep$City)+1
mycolors <- colorRampPalette(brewer.pal(8, "Paired"))(nb.cols)

# Stacked area plot using ggplot 
h= ggplot(df_ka,aes(x=Date,y=Count,group=City,fill=City))+geom_area(position="stack")+ theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle("Citywise Coronavirus cases in Karnataka")+labs(y=" ", x = " ") +scale_fill_manual(values = mycolors)+ theme(plot.title = element_text(hjust = 0.5))+scale_x_discrete(breaks = unique(df_ka$Date)[c(T,F)])

# Save output as .png and .html
name1 = paste("ka","cities.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=h)
hp=ggplotly(h, tooltip = c("x","y","group"))
name = paste("ka","cities.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(hp, file=path, selfcontained = FALSE, libdir = "plotly.html")
