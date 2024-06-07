###############################################################
## Title: Active, Recovered and Deceased Coronavirus Cases   ##
##        in Karnataka                                       ##
## Input: KAhospital_consolidated.csv                        ##
## Output: Plot of Date Vs Number of Cases                   ##
## Date Modified: 02-05-2024                                 ##
###############################################################

##Karnataka- Infected (Active), Deceased, Recovered

karc=read.csv("../Data/KAhospital_consolidated.csv")
library(plotly)
karc[,1]<-as.Date(karc[,1],"%d-%m-%y")
karc[,1]=format(karc[,1],"%b-%d-%Y") #%b gives Mar instead of 03

f <- list(family = "serif",size = 18,color = "black")
f2<- list(family = "serif", size = 15, color = "green3", font=2)
f3<-list( family="serif",size=13)
names(karc)[2]<-c("Active")
karc[,2]<-karc[,2]+karc[,5]
karc$Date=factor(karc$Date, level=unique(karc$Date))
fig<-plot_ly(karc,x=~Date,y=~Total.deceased,type="scatter",mode="lines",name="Deceased",fillcolor="darkred",line=list(color="darkred"),stackgroup="one",hoverinfo='text',text=~paste('</br> Date: ',Date,'</br> Deceased: ',Total.deceased))
fig<-fig%>% add_trace(y=karc$Total.discharged,name="Recovered",fillcolor="lime",line=list(color="lime"),hoverinfo='text',text=~paste('<br> Date:',Date,'<br> Recovered: ',Total.discharged))
fig<-fig%>% add_trace(y=karc$Active,name="Active Cases",fillcolor="orange",line=list(color="orange"),hoverinfo='text',text=~paste('<br> Date:',Date,'<br> Active Cases: ',Active))
fig<-fig %>%layout(title= "Karnataka- Total Infected",font=f2, yaxis=list(title=" ", titlefont=f,tickfont=f3,showgrid=T,showline=T,zeroline=F),xaxis= list(title=" ",tickangle=-45,tickfont=f3,showgrid=T,showline=T),showlegend=F)
fig
save_image(fig, "./plotlyfigures/ka-all.svg")
name = paste("ka","all.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")