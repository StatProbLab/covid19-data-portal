###############################################################
## Title: Districtwise Infected Recovered and Deceased Cases ##
##        of Coronavirus in Karnataka                        ##
## Input: IRDD_allka.csv                                     ##  
## Output: Plot of Date Vs Number of Cases                   ##
## Date Modified: 30-04-2024                                 ##
###############################################################

## Required Libraries
library(plotly)

allka = read.csv("./Data/IRDD_allka.csv")
district_names = unique(allka$District)


## variables to store custom fonts
f <- list(family = "serif",size = 18,color = "black")
f2<- list(family = "serif", size = 18, color = "green3", font=2)
f3<-list( family="serif",size=13)


idr=function(i){
  district_name = district_names[i]
  df = filter(allka,District==district_name) |> mutate(Active=Infected-Recovered-Deceased)
  colnames(df)[4:5] = c("Rec","Dec") 
  df$Date = format(as.Date(df$Date,"%d-%m-%Y"),"%d-%b-%y")
  df$Date=factor(df$Date, level=unique(df$Date))
  
  ## plotly graph for stacked plot of active, recovered, deceased cases for district 'i'
  fig=plot_ly(df,x=~Date,y=~Dec,type='scatter',mode="lines",fillcolor="darkred",name="Deceased",line=list(color="darkred"),hoverinfo='text',text=~paste('</br> Date: ',Date,'</br> Deceased: ',Dec),stackgroup="one")
  fig=fig%>%add_trace(y=df$Rec,type='scatter',mode='lines',fillcolor="lime",name="Recovered",line=list(color="lime"),hoverinfo='text',text=~paste('</br> Date: ',Date,'</br> Recovered: ',Rec))
  fig=fig%>%add_trace(y=df$Active,type='scatter',mode='lines',fillcolor="orange",name="Active",line=list(color="orange"),hoverinfo='text',text=~paste('</br> Date: ',Date,'</br> Active: ',Active))
  fig=fig%>%layout(title= district_names[i],titlefont=f2, yaxis=list(title="Number of Cases", titlefont=f),xaxis= list(title="Date",tickangle=-45,tickfont=f3))
  fig
}

## calling the function idr for each district and saving each graph
for (i in 1:30){
  name=paste(i,"infdedrec.html",sep="-")
  name2=paste0("./plotlyfigures/",i,"-infdedrec.svg")
  save_image(idr(i),name2)
  path<-file.path(getwd(),"plotlyfigures",name)
  htmlwidgets::saveWidget(idr(i),file=path,selfcontained=FALSE,libdir="plotly.html")
}