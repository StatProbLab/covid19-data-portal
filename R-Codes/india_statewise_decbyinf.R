#######################################################################
## Title: Statewise Deceased by Infected Ratio in India              ##
## Input: IRDD_allindia.csv                                          ##  
## Output: Plot of Date Vs Deceased by Infected Ratio for each State ##
## Date Modified: 24-04-2024                                         ##
#######################################################################

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

df_d = allindia[,c(1,2,5)]
df_d$Date = as.Date(df_d$Date,'%d-%m-%Y')

df_ = df_d
colnames(df_)[3] = 'Ratio'
df_[,3] = df_[,3]/df_i[,3]

dataasi = pivot_wider(df_i, names_from = State, values_from = Infected)
dataasi$Date = as.Date(dataasi$Date,'%d-%m-%Y')

dataasd = pivot_wider(df_d, names_from = State, values_from = Deceased)
dataasd$Date = as.Date(dataasd$Date,'%d-%m-%Y')

dataasdr = dataasd
dataasdr[,-1] = dataasdr[,-1]/dataasi[,-1]


asdr=ggplot(df_, aes(x = Date, y = Ratio, color=State)) + 
  geom_line() +
  labs(title="State wise Change in Deceased Ratio",
       x="Date", y="Deceased Ratio") +
  scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +scale_y_continuous(n.breaks=7,labels=scales::comma)+
  scale_color_viridis(discrete = TRUE)+
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 90, size=7, face=7, color="blue"),
                                             plot.title = element_text(color="maroon", size=14, face="bold"),
                                             axis.title.x = element_text(color="maroon", size=14),
                                             axis.title.y = element_text(color="maroon", size=14)) +
  theme(plot.title = element_text(hjust = 0.5)) 

# Converting to a Plotly graph
asdr_p = ggplotly(asdr, tooltip =c("label","x", "y","State"))

# Saving Output as .html
name = "IndiaStatesDR.html"
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(asdr_p, file=path, selfcontained = FALSE, libdir = "plotly.html")
