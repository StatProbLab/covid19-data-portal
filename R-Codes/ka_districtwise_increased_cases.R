###################################################################
## Title: Districtwise Infected Coronavirus Cases in Karnataka   ##
## Input: IRDD_allka.csv                                         ##  
## Output: Plot of Date Vs Number of Infected Cases              ##
##         (With and Without Total Cases in Karnataka)           ##
## Date Modified: 24-04-2024                                     ##
###################################################################

library(dplyr)
library(ggplot2)
library(tidyr)
library(gganimate)
library(viridis)
library(hrbrthemes)
library(plotly)
library(anim.plots)

allka = read.csv('./data/IRDD_allka.csv')
df_ = allka[,c(1,2,3)]
df_$Date = as.Date(df_$Date,'%d-%m-%Y')
df_ = na.omit(df_)

#With Total Cases in Karnataka
adi=ggplot(df_, aes(x = Date, y = Infected, color=District)) + 
  geom_line() +
  labs(title="District wise Increase in Cases",
       x="Date", y="Total Infected") +
  scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +scale_y_continuous(n.breaks=7,labels=scales::comma)+
  scale_color_viridis(discrete = TRUE)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, size=7, face=7),
                                             plot.title = element_text(color="maroon", size=14, face="bold"),
                                             axis.title.x = element_text(color="maroon", size=14),
                                             axis.title.y = element_text(color="maroon", size=14)) +
  theme(plot.title = element_text(hjust = 0.5))

# animate for .gif image
animate(adi+transition_reveal(Date), renderer = gifski_renderer('./graphs/ka_increase_in_cases_districtwise.gif'),
        width = 2560, height = 1440, res = 300, fps = 10)

# Converting to a Plotly graph
adi_p = ggplotly(adi, tooltip =c("label","x", "y","District"))

# Saving Output as .html
name = "ka_increase_in_cases_districtwise.html"
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(adi_p, file=path, selfcontained = FALSE, libdir = "plotly.html")



#Without Total Cases in Karnataka
df_ = filter(df_, df_$District!= 'Karnataka')
adi=ggplot(df_, aes(x = Date, y = Infected, color=District)) + 
  geom_line() +
  labs(title="District wise Increase in Cases",
       x="Date", y="Total Infected") +
  scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +scale_y_continuous(n.breaks=7,labels=scales::comma)+
  scale_color_viridis(discrete = TRUE)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, size=7, face=7),
        plot.title = element_text(color="maroon", size=14, face="bold"),
        axis.title.x = element_text(color="maroon", size=14),
        axis.title.y = element_text(color="maroon", size=14)) +
  theme(plot.title = element_text(hjust = 0.5))

# animate for .gif image
animate(adi+transition_reveal(Date), renderer = gifski_renderer('./graphs/ka_increase_in_cases_districtwise_wt.gif'),
        width = 2560, height = 1440, res = 300, fps = 10)

# Converting to a Plotly graph
adi_p = ggplotly(adi, tooltip =c("label","x", "y","District"))

# Saving Output as .html
name = "ka_increase_in_cases_districtwise_wt.html"
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(adi_p, file=path, selfcontained = FALSE, libdir = "plotly.html")
