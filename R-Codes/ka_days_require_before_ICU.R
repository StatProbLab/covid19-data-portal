###############################################################
## Title: Distribution of time taken before patient was      ##
##        Admitted to ICU                                    ##
## Input: KAhospital.csv                                     ##
## Output: Plot of Days between Testing Positive Vs Number   ## 
##         Of patients                                       ##
## Date Modified: 03-05-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly) 

# Reading data of hospitalization status of patients in Karnataka
KAhospital = read.csv("../Data/KAhospital.csv",header=TRUE)

# Extract rows for which patient has been in ICU
df_icu=data.frame()
for(i in KAhospital$Case){
  col = KAhospital[i,]
  a=length(which(col == "ICUV"))
  b=length(which(col == "ICUO"))
  c=length(which(col == "ICU"))
  if (a+b+c >0){
    df_icu=rbind(df_icu,KAhospital[i,])
  }else{next}
}

# To find the number of days before they were in ICU/on ventilator/oxygen and create dataframe
dticu = rep(0,length(df_icu$Case))
for(i in 1:length(df_icu$Case)){
  col = df_icu[i,]
  col<- (col[3:length(col)])
  start = min(which(as.character(col)!="NA"))
  end=100000000000000
  if(length(which(col == "ICU") )>0){end=min(which(col == "ICU"))}
  if(length(which(col == "ICUV") )>0){end=min(end,which(col == "ICUV"))}
  if(length(which(col == "ICUO") )>0){end=min(end,which(col == "ICUO"))}
  dticu[i] = (end-start)
}
DTICU = data.frame(days=dticu)

# Histogram using ggplot
dtig=ggplot(DTICU,aes(x=days))+geom_histogram(binwidth=1,fill="darkolivegreen3")+labs(x="Days between testing positive and ICU",y="Number of Patients")+scale_x_continuous(breaks = min(dticu):max(dticu))+ggtitle("Distribution of days taken to require ICU")+ theme(plot.title = element_text(hjust = 0.5))

# Saving output as .png
name1 = paste("days","toicu.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=dtig)

# Converting to a plotly graph
dtigp= ggplotly(dtig)

# Saving output as .html
name = paste("days","toICU.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(dtigp, file=path, selfcontained = FALSE, libdir = "plotly.html")
