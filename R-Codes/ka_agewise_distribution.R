###############################################################
## Title: Age distribution of patients along with census data##
## Input: KAtrace.csv                                        ##
## Output: Plot of Age Vs Relative Frequency                 ##
## Date Modified: 06-05-2024                                 ##
###############################################################

# Libraries Required
library(ggplot2)
library(plotly)

# Reading Data of patients in Karnataka state, extracting ages and eliminating NAs.
KAtrace = read.csv("../Data/KAtrace.csv",header=TRUE)
Age = na.omit(as.numeric(as.character(subset(KAtrace,Age!="")$Age)))
Age_df = data.frame(Age)

# Creating dataframe for population of KA based on 2001 census
cen = c(8.26,8.58,9.39,9.54,9.91,9.45,7.69,7.69,6.26,5.76,4.42,3.51,3.37,2.49,1.74,0.86,1.02)
cen <- floor(100*cen/sum(cen))
cen = replace(cen,cen==0,1)
Pop = c()
for (i in 1:17){
  A = rep(i*5-2.5,cen[i])
  Pop <- c(Pop,A)
}
Cen = data.frame(Age = Pop)

# Overlapping histograms using ggplot
g = ggplot(Age_df,aes(x=Age))+
  geom_histogram(data = Age_df,aes(y=stat(count)/sum(count)),binwidth=5,fill="orange",col="orange")+
  geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="navy",alpha=0.15)+
  scale_y_continuous(labels = scales::percent)+labs(y="Relative frequency")+ggtitle("Age Distribution of COVID-19 patients in Karnataka")+theme_minimal()+ theme(plot.title = element_text(hjust = 0.5))

# Saving the output as .png and .html
name1 = paste("ageka","hist.png", sep="-")
name2 = paste0("./plotlyfigures/", name1)
ggsave(name2, plot=g)
gp = ggplotly(g)
name = paste("ageka","hist.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
