###############################################################
## Title: Total Infected Covid19 Cases in Karnataka          ##
##          (Log Scale)                                      ##
## Input: IRDD_allka.csv                                     ##  
## Output: Plot of Date Vs Infected Cases                    ##
## Date Modified: 30-04-2024                                 ##
###############################################################

## Required Libraries
library(plotly)
allka <- read.csv('./data/IRDD_allka.csv')

## variables to store custom fonts and colors
f <- list(family = "serif", size = 17, color = 'maroon',face="bold")
f2<- list(family = "serif", size = 13, color = 'maroon',face="bold")
f3<-list( family="serif",size=13,color='black')
colnum=c("#4169e1","#414ee1","#00cd00","#458b00","#eeb422","#cd9b1d","#9370db","#7870db","#ee6aa7","#cd6090")

district_names = unique(allka$District)

grp3=function(i){
  
  df_s = filter(allka,allka$District == district_names[i])
  df_s$Date = format(as.Date(df_s$Date,"%d-%m-%Y"),"%b-%d-%y")
  df=data.frame("Date"=df_s$Date,"Total Cases"=log(df_s[,3],10),"Total Cases2"=df_s[,3])
  df$Date=factor(df$Date, level=unique(df$Date))
  total_text=round(df$Total.Cases, digits=3) ## rounding off log value
  
  ## Plotly graph of Log Timeline of Total cases for each District
  fig <- plot_ly(df, x = ~Date, y = ~Total.Cases, type="scatter" ,mode = 'lines',line= list(color=colnum[7]),hoverinfo = 'text', text = ~paste('</br> Date: ',Date,'</br> Total cases (Log Scale): ', total_text, '</br> Total cases (Linear Scale): ', Total.Cases2))
  fig  %>% add_trace(df, x=~Date, y=~Total.Cases, type="scatter", mode="markers", marker=list(color=colnum[8]),textposition='center',showlegend=FALSE) %>% layout(title= district_names[i],font=f2, yaxis=list(title="Total Infected Cases (Log Scale)", titlefont=f,tickfont=f3,showgrid=F,showline=T,zeroline=F),xaxis= list(title=" ",tickangle=-45,tickfont=f3,showgrid=F,showline=T))
} 

## calling the function grp3 for each district and saving each graph
for(i in 1:30){
  name=paste(i,"log.html",sep="-")
  name2=paste0("./plotlyfigures/",i,"-log.svg")
  save_image(grp3(i),name2)
  path<-file.path(getwd(),"plotlyfigures",name)
  htmlwidgets::saveWidget(grp3(i), file=path, selfcontained = FALSE, libdir ="plotly.html")
}