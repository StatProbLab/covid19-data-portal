# Importing libraries
library(plotly)
library(lubridate)
library(reticulate)

# Defining Python Path
use_python("/home/rashi/anaconda3/bin/python3")

# Reading CSV files
pred = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/predictions.csv")
pred = pred[,2:length(pred[1,])]
pred2 = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/Karnataka_forecasts2.csv")
pred3 = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/predictions3.csv")
pred3 = pred3[,2:length(pred3[1,])]
pred4 = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/karnataka_projections4.csv")
pred5 = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/csirforecast.csv")
kadist = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/Distdata.csv")
kadist = kadist[,2:length(kadist[1,])]
dates1 = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/dates1.csv")
stder1 = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/std_error_1.csv")
stder1 = stder1[,2:length(stder1[1,])]
stder3 = read.csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/std_error_3.csv")
stder3 = stder3[,2:length(stder3[1,])]

# Converting extracted dates to required format
d = as.Date(pred2$Date,"%Y-%m-%d")
pred2$d = d
d4 = as.Date(pred4$Date,"%Y-%m-%d")
pred4$d4 = d4
d5 = as.Date(pred5$Date,"%Y-%m-%d")
pred5$d5 = d5

dist_names = c("Bagalakote","Ballari","Belagavi","Bengaluru Rural","Bengaluru Urban","Bidar","Chamarajanagara","Chikkaballapura","Chikkamagaluru","Chitradurga","Dakshina Kannada","Davanagere","Dharwad","Gadag","Hassan","Haveri","Kalaburagi","Kodagu","Kolar","Koppal","Mandya","Mysuru","Raichur","Ramanagara","Shivamogga","Tumakuru","Udupi","Uttara Kannada","Vijayapura","Yadgiri")
f <- list(family = "serif",size = 18,color = "black")
f2 <- list(family = "serif", size = 18, color = "green3", font=2)
f3 <- list( family="serif",size=13)
colors1 = c("#0072B2","#000000","#009E73","#D55E00","#CC79A7","#f0e442")

# Defining District Functions
district1 = function(i) {

# Finding index of missing values
na1 = which(is.na(pred[i,])) 
na2 = which(is.na(kadist[i,]))

if(length(na1)>0){
  pred_data = pred[i,1:(min(na1)-1)]
  pred3_data = pred3[i,1:(min(na1)-1)]
} else {
  pred_data = pred[i,]
  pred3_data = pred3[i,]}
  
if(length(na2)>0){
  dist_data = kadist[i,1:(min(na2)-1)]
} else {dist_data = kadist[i,]}
  
# Initializing a vector
l = 1:length(pred_data) 

# Converting data in required format
dist_data = log10(as.numeric(dist_data))
pred_data_lin = as.numeric(pred_data)
pred_data = log10(as.numeric(pred_data))
pred3_data_lin = as.numeric(pred3_data)
pred3_data = log10(as.numeric(pred3_data))
  
# Initializing start date for data extraction from the CSV file
start = as.Date(dates1$X1[i],"%d/%m/%y")
year(start) <- 2020
  
dist_data[(length(dist_data)+1):length(l)] = -99 # always get 7 more -99 (Placeholder for missing value)

if(i == 6){dateseq1 = seq(start,to = as.Date("27-04-20","%d-%m-%y"),by = "1 day")
dateseq2 = seq(from = as.Date("02-05-20","%d-%m-%y"), by = "1 day",length = length(l)-length(dateseq1))
l2 = c(dateseq1,dateseq2)
} else{l2 = seq(start,by = "1 day",length = length(l))}

# Converting dates in specified format
z = format(l2,"%d-%m-%y")
  
# Adding the second prediction-
whole_data2 = subset(pred2, pred2$District == dist_names[i], select = c(Rescaled.Infected,d))
k = which(whole_data2$d == start)
pred2_data = whole_data2$Rescaled.Infected[k:(k+length(l2)-1)]
pred2_data_lin = pred2_data
pred2_data = log10(pred2_data)

# Adding the fourth prediction-
if(i == 7) {pred4_data = rep(NA,length(pred2_data))
  pred4_data_lin = rep(NA,length(pred2_data_lin))
} else {
if(i == 6) {whole_data4 = subset(pred4,pred4$District == dist_names[i] & pred4$d4 %in% l2, select = c(Predicted.Infected, d4))
} else {whole_data4 = subset(pred4,pred4$District == dist_names[i],select = c(Predicted.Infected,d4))}

k = which(whole_data4$d4 == start)
pred4_data = whole_data4$Predicted.Infected[k:(k+length(l2)-1)]
pred4_data_lin = pred4_data
pred4_data = log10(pred4_data)}
  
# Adding the fifth prediction-
# if(i==7){pred5_data=rep(NA,length(pred2_data))
# pred5_data_lin=rep(NA,length(pred2_data_lin))
# }
  
{
if(i == 6){whole_data5=subset(pred5,pred5$District == dist_names[i] & pred5$d5 %in% l2,select = c(Infected,d5))
} else {whole_data5 = subset(pred5,pred5$District == dist_names[i], select = c(Infected,d5))}
k = which(whole_data5$d5 == start)
pred5_data = whole_data5$Infected[k:(k+length(l2)-1)]
pred5_data_lin = pred5_data
pred5_data = log10(pred5_data)}
  
# Creating dataframe with required columns and data.  
df = data.frame(z, dist_data, pred_data, pred_data_lin, pred2_data, pred2_data_lin, pred3_data, pred3_data_lin, pred4_data, pred4_data_lin, pred5_data, pred5_data_lin)
  
# df$z=factor(df$z,levels=unique(df$z))

# Constructing the plot object 
fig=plot_ly(df) # Initializes a plot with data frame df

fig=fig%>%add_trace(x=df$z,y=df$dist_data,mode='markers',type="scatter",name='Observed Data')%>%layout(yaxis=list(range=c(0,ceiling(max(pred_data,dist_data,pred2_data)))))

fig=fig%>%add_trace(x=df$z,y=df$pred2_data,mode='lines',type="scatter",name='INDSCI-SIM Prediction',hoverinfo='text',text=~paste('</br> INDSCI-SIM Fit','</br> Date: ',df$z,'</br> Log Scale: ',round(df$pred2_data,3),'</br> Linear Scale: ',round(df$pred2_data_lin)))

fig=fig%>%add_trace(x=df$z,y=df$pred_data,mode='lines',type="scatter",name='IISC-ISI Prediction 1',hoverinfo='text',text=~paste('</br> IISC-ISI Fit 1','</br> Date: ',df$z,'</br> Log Scale: ',round(df$pred_data,3),'</br> Linear Scale: ',round(df$pred_data_lin)))

fig=fig%>%add_trace(x=df$z,y=df$pred3_data,mode='lines',type="scatter",name='IISC-ISI Prediction 2',hoverinfo='text',text=~paste('</br> IISC-ISI Fit 2','</br> Date: ',df$z,'</br> Log Scale: ',round(df$pred3_data,3),'</br> Linear Scale: ',round(df$pred3_data_lin)))

fig=fig%>%add_trace(x=df$z,y=df$pred4_data,mode='lines',type="scatter",name='SAIR Prediction',hoverinfo='text',text=~paste('</br> SAIR Model','</br> Date: ',df$z,'</br> Log Scale: ',round(df$pred4_data,3),'</br> Linear Scale: ',round(df$pred4_data_lin)))%>%layout(title=dist_names[i],titlefont=f2,yaxis=list(title='Infected Cases-Log Scale',titlefont=f),xaxis=list(title='Dates',titlefont=f,tickangle=-45,tickfont=f3),colorway=colors1)
  
fig=fig%>%add_trace(x=df$z,y=df$pred5_data,mode='lines',type="scatter",name='CSIR Prediction',hoverinfo='text',text=~paste('</br> CSIR Model','</br> Date: ',df$z,'</br> Log Scale: ',round(df$pred5_data,3),'</br> Linear Scale: ',round(df$pred5_data_lin)))%>%layout(title=dist_names[i],titlefont=f2,yaxis=list(title='Infected Cases-Log Scale',titlefont=f),xaxis=list(title='Dates',titlefont=f,tickangle=-45,tickfont=f3),colorway=colors1)
fig
}


# Calling the district function and plotting graphs
for(i in 1:30){
  
  #i = 1
  print(i)
  name = paste(i,"predinf.html", sep = "-")
  name2 = paste0("/opt/lampp/htdocs/covid19-data-portal/Data/Output/plotlyfigures/",i,"-predinf.svg")
  kaleido(district1(i),name2)
  path <- file.path('/opt/lampp/htdocs/covid19-data-portal/Data/Output/', "plotlyfigures", name)
  htmlwidgets::saveWidget(district1(i), file=path, selfcontained = FALSE, libdir = "plotly.html")
  #i = i + 1
  
}


# Defining function for District 3

district3 = function(i){
    
na1 = which(is.na(pred[i,]))
na2 = which(is.na(kadist[i,]))

if(length(na1) > 0){
  pred_data = pred[i,1:(min(na1)-1)]
  pred3_data = pred3[i,1:(min(na1)-1)]
} else {pred_data = pred[i,]
  pred3_data = pred3[i,]}

if(length(na2) > 0){
  dist_data = kadist[i,1:(min(na2)-1)]
} else {dist_data = kadist[i,]}
  
l=1:length(pred_data)

dist_data = as.numeric(dist_data)
pred_data = round(as.numeric(pred_data))
pred3_data = round(as.numeric(pred3_data))

start = as.Date(dates1$X1[i],"%d/%m/%y")
year(start) <- 2020
  
dist_data[(length(dist_data)+1):length(l)] = NA #always get 7 more NAs

if(i == 6){dateseq1 = seq(start,to = as.Date("27-04-20","%d-%m-%y"),by = "1 day")
dateseq2 = seq(from = as.Date("02-05-20","%d-%m-%y"),by = "1 day",length = length(l)-length(dateseq1))
l2 = c(dateseq1, dateseq2)
} else{l2 = seq(start, by = "1 day",length = length(l))}
  
z = format(l2,"%d-%m-%y")
  
# Adding the second prediction-
whole_data2 = subset(pred2,pred2$District == dist_names[i],select = c(Rescaled.Infected,d))
k = which(whole_data2$d == start)
pred2_data = whole_data2$Rescaled.Infected[k:(k+length(l2)-1)]
pred2_data = round(pred2_data)
  
# Adding the fourth prediction-
if(i == 7) {pred4_data = rep(NA,length(pred2_data))
} else {
if(i == 6) {whole_data4 = subset(pred4, pred4$District == dist_names[i] & pred4$d4 %in% l2, select = c(Predicted.Infected, d4))
} else {whole_data4 = subset(pred4, pred4$District == dist_names[i], select = c(Predicted.Infected, d4))}
k = which(whole_data4$d4 == start)
pred4_data = whole_data4$Predicted.Infected[k:(k+length(l2)-1)]
pred4_data = round(pred4_data)}
  
#adding the fifth prediction-
#if(i==7){pred5_data=rep(NA,length(pred2_data))
#}

{
if(i == 6){whole_data5 = subset(pred5,pred5$District == dist_names[i] & pred5$d5 %in% l2, select = c(Infected,d5))
} else {whole_data5 = subset(pred5,pred5$District == dist_names[i], select = c(Infected,d5))}
k = which(whole_data5$d5 == start)
pred5_data = whole_data5$Infected[k:(k+length(l2)-1)]
pred5_data = round(pred5_data)}

# Creating dataframe
df = data.frame(z, dist_data, pred_data, pred2_data, pred3_data, pred4_data, pred5_data)
df$z = factor(df$z, levels = unique(df$z))

# Generating plot object
fig = plot_ly(df)

fig=fig%>%add_trace(x=df$z,y=df$dist_data,mode='markers',type="scatter",name='Observed Data')%>%layout(yaxis=list(range=c(0,round(max(pred_data,dist_data,pred2_data),-2))))

fig=fig%>%add_trace(x=df$z,y=df$pred2_data,mode='lines',type="scatter",name='INDSCI-SIM Prediction')

fig=fig%>%add_trace(x=df$z,y=df$pred_data,mode='lines',type="scatter",name='IISC-ISI Prediction 1')

fig=fig%>%add_trace(x=df$z,y=df$pred3_data,mode='lines',type="scatter",name='IISC-ISI Prediction 2')

fig=fig%>%add_trace(x=df$z,y=df$pred4_data,mode='lines',type="scatter",name='SAIR Prediction')%>%layout(title=dist_names[i],titlefont=f2,yaxis=list(title='Infected Cases-Linear Scale',titlefont=f),xaxis=list(title='Dates',titlefont=f,tickangle=-45,tickfont=f3),colorway=colors1)

fig=fig%>%add_trace(x=df$z,y=df$pred5_data,mode='lines',type="scatter",name='CSIR Prediction')%>%layout(title=dist_names[i],titlefont=f2,yaxis=list(title='Infected Cases-Linear Scale',titlefont=f),xaxis=list(title='Dates',titlefont=f,tickangle=-45,tickfont=f3),colorway=colors1)

fig
}

i = 1

for(i in 1:30){
  
  #i = 1
  name = paste(i,"predlin.html", sep="-")
  name2=paste0("/opt/lampp/htdocs/covid19-data-portal/Data/Output/plotlyfigures/",i,"-predlin.svg")
  kaleido(district3(i),name2)
  path <- file.path('/opt/lampp/htdocs/covid19-data-portal/Data/Output/', "plotlyfigures", name)
  htmlwidgets::saveWidget(district3(i), file=path, selfcontained = FALSE, libdir = "plotly.html")
  #i = i + 1
  
}

errband = function(i){

na1 = which(is.na(pred[i,]))
na2 = which(is.na(kadist[i,]))

if(length(na1) > 0){
  pred_data = pred[i,1:(min(na1)-1)]
  pred3_data = pred3[i,1:(min(na1)-1)]
} else {pred_data = pred[i,]
pred3_data = pred3[i,]}

if(length(na2) > 0){
  dist_data = kadist[i,1:(min(na2)-1)]
} else {dist_data = kadist[i,]}
  
tempdate = as.Date(dates1$X1[i],"%d/%m/%y")
year(tempdate) <- 2020
  
start = tempdate + (length(pred_data)-14)

if(i == 6){l2 = seq(Sys.Date()-6,by = "1 day", length = 14)
} else {l2 = seq(start,by = "1 day", length = 14)}
  
z = format(l2,"%d-%m-%y")
  
l = length(pred_data)

pred_data = as.numeric(pred_data[(l-13):l])
pred3_data = as.numeric(pred3_data[(l-13):l])
  
l = length(pred_data)

dist_data = as.numeric(dist_data[(length(dist_data)-6):length(dist_data)])
dist_data[(length(dist_data)+1):l]=NA #always get 7 more NAs
  
error1_high = rep(NA,14)
error1_high[8:l] = pred_data[8:l] + as.numeric(stder1[i,])
error1_low = rep(NA,14)
error1_low[8:l] = pred_data[8:l] - as.numeric(stder1[i,])
error3_high = rep(NA,14)
error3_high[8:l] = pred3_data[8:l] + as.numeric(stder3[i,])
error3_low = rep(NA,14)
error3_low[8:l] = pred3_data[8:l] - as.numeric(stder3[i,])
  
df = data.frame(z, dist_data, pred_data, pred3_data, error1_high, error1_low, error3_high, error3_low)
  
df$z = factor(df$z, levels=unique(df$z))
  
fig = plot_ly(df)
  
fig = fig %>% add_trace(x=~z,y=~dist_data,mode='markers',type='scatter',name="Observed Data",marker=list(color='rgba(0, 114, 178,1)'))

fig = fig %>% add_trace(x=~z,y=~error1_high,mode='lines',type='scatter',line = list(color = 'rgba(0, 158, 115,0)'),name="Error-1",showlegend=F)

fig <- fig %>% add_trace(x=~z,y = ~error1_low, type = 'scatter', mode = 'lines',fill = 'tonexty', fillcolor='rgba(0, 158, 115,0.2)', line = list(color = 'rgba(0, 158, 115,0)'),name="Error-1",showlegend=F)
  
fig = fig %>% add_trace(x=~z,y=~error3_high,mode='lines',type='scatter',line = list(color = 'rgba(213, 94, 0,0)'),name="Error-3",showlegend=F)

fig <- fig %>% add_trace(x=~z,y = ~error3_low, type = 'scatter', mode = 'lines',fill = 'tonexty', fillcolor='rgba(213, 94, 0,0.2)', line = list(color = 'rgba(213, 94, 0,0)'),name="Error-3",showlegend=F)

fig = fig %>% add_trace(x=~z,y=~pred_data,mode='lines',type='scatter',name="IISC-ISI Prediction 1",line=list(color='rgba(0,158,115,1)'))

fig = fig %>% add_trace(x=~z,y=~pred3_data,mode='lines',type='scatter',name="IISC-ISI Prediction 2",line=list(color='rgba(213, 94, 0,1)'))%>%layout(title=dist_names[i],titlefont=f2,yaxis=list(title='Infected Cases-Linear Scale',titlefont=f),xaxis=list(title='Dates',titlefont=f,tickangle=-45,tickfont=f3),legend=list(traceorder="normal"))

fig
}

i = 1

for(i in 1:30){
  
  #i = 1
  name = paste(i,"errband.html", sep="-")
  name2=paste0("/opt/lampp/htdocs/covid19-data-portal/Data/Output/plotlyfigures/",i,"-errband.svg")
  kaleido(errband(i),name2)
  path <- file.path('/opt/lampp/htdocs/covid19-data-portal/Data/Output/', "plotlyfigures", name)
  htmlwidgets::saveWidget(errband(i), file=path, selfcontained = FALSE, libdir = "plotly.html")
  #i = i + 1
  
}

