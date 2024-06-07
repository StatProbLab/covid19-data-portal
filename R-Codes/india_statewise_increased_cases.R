############################################################
## Title: Statewise Infected Coronavirus Cases in India   ##
## Input: IRDD_allindia.csv                               ##  
## Output: Plot of Date Vs Number of Infected Cases       ##
##         (With and Without Total Cases in India)        ##
## Date Modified: 24-04-2024                              ##
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
df_ = allindia[,c(1,2,3)]
df_$Date = as.Date(df_$Date,'%d-%m-%Y')
df_ = na.omit(df_)

#With Total Infected Cases in India
asi=ggplot(df_, aes(x = Date, y = Infected, color=State)) + 
  geom_line() +
  labs(title="State wise Increase in Cases",
       x="Date", y="Total Infected") +
  scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +scale_y_continuous(n.breaks=7,labels=scales::comma)+
  scale_color_viridis(discrete = TRUE)+
  theme_minimal() +   
  theme(axis.text.x = element_text(angle = 90, size=7, face=7),
        plot.title = element_text(color="maroon", size=14, face="bold"),
        axis.title.x = element_text(color="maroon", size=14),
        axis.title.y = element_text(color="maroon", size=14)) +
  theme(plot.title = element_text(hjust = 0.5))

# animate for .gif image
animate(asi+transition_reveal(Date), renderer = gifski_renderer('./graphs/india_increase_in_cases_stateswise.gif'),
        width = 2560, height = 1440, res = 300, fps = 10)


# Converting to a Plotly graph
asi_p = ggplotly(asi, tooltip =c("label","x", "y","State"))

# Saving Output as .html
name = "india_increase_in_cases_stateswise.html"
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(asi_p, file=path, selfcontained = FALSE, libdir = "plotly.html")



#Without Total Infecedted Cases in India
df_ = filter(df_,df_$State != 'India')
asi=ggplot(df_, aes(x = Date, y = Infected, color=State)) + 
  geom_line() +
  labs(title="State wise Increase in Cases",
       x="Date", y="Total Infected") +
  scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +scale_y_continuous(n.breaks=7,labels=scales::comma)+
  scale_color_viridis(discrete = TRUE)+
  theme_minimal() +   
  theme(axis.text.x = element_text(angle = 90, size=7, face=7),
        plot.title = element_text(color="maroon", size=14, face="bold"),
        axis.title.x = element_text(color="maroon", size=14),
        axis.title.y = element_text(color="maroon", size=14)) +
  theme(plot.title = element_text(hjust = 0.5))

# animate for .gif image
animate(asi+transition_reveal(Date), renderer = gifski_renderer('./graphs/india_increase_in_cases_stateswise_wt.gif'),
        width = 2560, height = 1440, res = 300, fps = 10)


# Converting to a Plotly graph
asi_p = ggplotly(asi, tooltip =c("label","x", "y","State"))

# Saving Output as .html
name = "india_increase_in_cases_stateswise_wt.html"
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(asi_p, file=path, selfcontained = FALSE, libdir = "plotly.html")
