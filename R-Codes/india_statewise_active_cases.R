############################################################
## Title: Statewise Active Coronavirus Cases in India     ##
## Input: IRDD_allindia.csv                               ##  
## Output: Plot of State Vs Number of Active Cases        ##
## Date Modified: 23-04-2024                              ##
############################################################

library(dplyr)
library(ggplot2)
library(tidyr)
library(gganimate)
library(viridis)
library(hrbrthemes)
library(plotly)
library(anim.plots)


allindia = read.csv('./data/IRDD_allindia.csv')
allindia = na.omit(allindia)
df_i = allindia[,c(1,2,3)]
df_i$Date = as.Date(df_i$Date,'%d-%m-%Y')

df_r = allindia[,c(1,2,4)]
df_r$Date = as.Date(df_r$Date,'%d-%m-%Y')

df_d = allindia[,c(1,2,5)]
df_d$Date = as.Date(df_d$Date,'%d-%m-%Y')


dataasi = pivot_wider(df_i, names_from = State, values_from = Infected)
dataasi$Date = as.Date(dataasi$Date,'%d-%m-%Y')
dataasr = pivot_wider(df_r, names_from = State, values_from = Recovered)
dataasr$Date = as.Date(dataasr$Date,'%d-%m-%Y')
dataasd = pivot_wider(df_d, names_from = State, values_from = Deceased)
dataasd$Date = as.Date(dataasd$Date,'%d-%m-%Y')


df_add=df_d
df_add$Deceased=df_i$Infected-df_r$Recovered-df_d$Deceased
colnames(df_add)[3]='Active'
df_add$Daily_Deaths=NA
for (i in 2:nrow(df_add)){if (df_d[i,2]==df_d[i-1,2]){df_add$Daily_Deaths[i]=df_d[i,3]-df_d[i-1,3]}}

asadd = ggplot(df_add, aes(x = State, y = Active, size = Daily_Deaths, color = State)) + 
  labs(title="Satet wise Active Coronavirus Cases in India") +
  scale_y_continuous(n.breaks=7,labels=scales::comma) +
  geom_point(alpha=0.5) + 
  scale_size(range = c(1, 5)) + 
  scale_color_viridis(discrete = TRUE) + 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  theme(axis.text.x = element_text(angle = 45, size=7, face=7, hjust=1)) +
  theme(plot.title = element_text(color="maroon", size=14, face="bold"), axis.title.x = element_text(color="maroon", size=14),axis.title.y = element_text(color="maroon", size=14))
animate(asadd+transition_time(Date), renderer = gifski_renderer('./graphs/India_States_Deceased.gif'),width = 2560, height = 1450, res = 300, fps = 10)
