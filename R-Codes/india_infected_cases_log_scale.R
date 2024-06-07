#######################################################################
## Title: Number of Infected Cases in India (Log Scale)              ##
## Input: IRDD_allindia.csv                                          ##  
## Output: Plot of Date Vs Number of Infected Cases                  ##
## Date Modified: 29-04-2024                                         ##
#######################################################################

allindia = read.csv("./data/IRDD_allindia.csv")
df = filter(allindia,State=="India") 
df = mutate(df,Infected_Log_Scale = log(Infected))
df$Date=factor(df$Date, level=unique(df$Date))
total_text=round(df$Infected_Log_Scale, digits=3)  ## rounding off log value

## Plotly graph of Log Timeline of Total cases for all of India
fig <- plot_ly(df, x = ~Date, y = ~Infected_Log_Scale, type="scatter" ,mode = 'lines',line= list(color=colnum[7]),hoverinfo = 'text', text = ~paste('</br> Date: ',Date,'</br> Total cases (Log Scale): ', total_text, '</br> Total cases (Linear Scale): ', Infected))
fig <- fig  %>% add_trace(df, x=~Date, y=~Infected_Log_Scale, type="scatter", mode="markers", marker=list(color=colnum[8]),textposition='center',showlegend=FALSE)
fig <- fig %>% layout(title= "All India",font=f2, yaxis=list(title="Total Infected Cases (Log Scale)", titlefont=f,tickfont=f3,showgrid=F,showline=T,zeroline=F),xaxis= list(title=" ",tickangle=-45,tickfont=f3,showgrid=F,showline=T))

## saving the graph
save_image(fig, "./plotlyfigures/allindia-log.svg")
name = paste("allindia","log.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")