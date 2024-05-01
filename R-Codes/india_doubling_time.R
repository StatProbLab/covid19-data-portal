###############################################################
## Title: Doubling Time for Infection Growth in India        ##
## Input: IRDD_allindia.csv                                  ##  
## Output: Plot of Date Vs Doubling Time                     ##
## Date Modified: 26-04-2024                                 ##
###############################################################


## Required Libraries
library(plotly)

allindia <- read.csv('./data/IRDD_allindia.csv')

## Preparing date headings for x-labels
a=length(allindia$Date)
d=seq(as.Date("10-03-20","%d-%m-%y"),length=a,by="1 day") #date sequence
d2=format(d,"%b-%d-%y") #%b gives Mar instead of 03

## variables to store custom fonts
f <- list(family = "serif",size = 18,color = "black")
f2<- list(family = "serif", size = 18, color = "green3", font=2)
f3<-list( family="serif",size=13)

## function that allots lockdown phase to each date. Eg: No restriction phase=0, Janta Curfew=1
lock_date=as.Date(c("22-03-20","25-03-20","14-04-20","15-04-20","03-05-20","04-05-20","17-05-20","18-05-20","31-05-20","01-06-20","30-06-20","01-07-20","31-07-20","01-08-20","31-08-20","01-09-20","30-09-20","01-10-20"),"%d-%m-%y") 
assign_cat=function(a){
  if(a==lock_date[1]){c(1)}
  else if(a>=lock_date[2]&a<=lock_date[3]){c(2)}
  else if(a>=lock_date[4]&a<=lock_date[5]){c(3)}
  else if(a>=lock_date[6]&a<=lock_date[7]){c(4)}
  else if(a>=lock_date[8]&a<=lock_date[9]){c(5)}
  else if(a>=lock_date[10]&a<=lock_date[11]){c(6)}
  else if(a>=lock_date[12]&a<=lock_date[13]){c(7)}
  else if(a>=lock_date[14]&a<=lock_date[15]){c(8)}
  else if(a>=lock_date[16]&a<=lock_date[17]){c(9)}
  else if(a>=lock_date[18]){c(10)}
  else{c(0)}}

## colors and legend labels for the function
col_pal=c("#ffd633","#ff471a", "#ff4da6", "#8c1aff","#3385ff","#00cc66","#3333ff","#156B3C","#acc400","#cf771d","#CB1809")
label_cat=c("No Restriction","Janta Curfew","Lockdown- Phase 1","Lockdown- Phase 2","Lockdown- Phase 3","Lockdown- Phase 4","Unlock 1.0","Unlock 2.0","Unlock 3.0","Unlock 4.0","Unlock 5.0")

## adding the total cases for all states to get all India totals
n = filter(allindia,allindia$State=='India')
n = na.omit(n)
n_bar=n[,3]

## calculating the doubling times
##Algorithm explained in doubling time notes at: https://www.isibang.ac.in/~athreya/incovid19/doublingnote.pdf
start=max(min(which(n_bar>50)),min(which(n_bar>2*n_bar[1])))
date1=1:length(n_bar)

yj=n_bar
y2=n_bar[start:length(n_bar)]
dtime=c()

## finding the time at which half of the count was achieved and storing them in the variable dtime
for(j in 1:length(y2)){
  ind=which(yj<=y2[j]/2)
  m=max(ind)
  if(m==1){
    dtime[j]<-((y2[j]/2-yj[m+1])/(yj[m+1]-yj[m]))+m+1
  }
  else if(yj[m]==y2[j]/2 & yj[m]==yj[m-1] ){ 
    k=m-1
    while(yj[k-1]==yj[m] & k>1){
      k<-k+1
    } 
    dtime[j]=k
  }
  else{ 
    dtime[j]<-((y2[j]/2-yj[m+1])/(yj[m+1]-yj[m]))+m+1}
}  ## close for loop

## calculating doubling time by subtracting half time
dtime<-date1[start:length(date1)]-dtime

## Code for plotly graph begins  
## calling the function assign_cat to allot lockdown phases
cat=rep(0,length(dtime))
df=data.frame("Date"=n$Date[c(1:length(dtime))],"Doubling Time"=dtime,"Cat"=cat)
df$Date=factor(df$Date, level=unique(df$Date))
for(j in 1:length(dtime)){
  df$Cat[j]<-assign_cat(d[start:length(d)][j])
}

## declaring as factors
df$Cat<-as.factor(df$Cat)
cat_num=length(levels(df$Cat))
df$Cat<-factor(df$Cat,labels=label_cat[(11-cat_num+1):11])
col_use=col_pal[(11-cat_num+1):11]

## plotly graph for doubling time for all of India- color coded according to the lockdown phase
fig <- plot_ly(df, x = ~Date, y = ~Doubling.Time, type="scatter" ,color=~df$Cat,colors=col_use,mode = 'markers',marker=list(size=10),textposition='center',showlegend=T,hoverinfo = 'text', text = ~paste('</br> Date: ',Date,'</br> Doubling Time: ', round(Doubling.Time,4)))
fig<-fig %>% layout(title= "All India",titlefont=f2, yaxis=list(title="Doubling Time", titlefont=f),xaxis= list(title="Date",tickangle=-45,tickfont=f3))
fig

## saving the graph 
name = paste("allindia","dt.html", sep="-")
path <- file.path(getwd(), "plotlyfigures", name)
htmlwidgets::saveWidget(fig, file=path, selfcontained = FALSE, libdir = "plotly.html")
