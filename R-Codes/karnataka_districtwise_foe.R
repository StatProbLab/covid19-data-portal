########################################################################
## Title: Trajectory to test exponential growth for each district     ##
##        in Karnataka                                                ##                            
## Input: IRDD_allka.csv                                              ##  
## Output: Plot of Date Vs Number of Infected Cases                   ##
## Date Modified: 30-04-2024                                          ##
######################################################################## 

# Libraries Required
library(ggplot2)
library(plotly)


KA = read.csv('./data/IRDD_allka.csv')[,c(1,2,3)]
KA = na.omit(KA)
names(KA)<- c("Date","District","Count")
KA$Date = format(as.Date(KA$Date,"%d-%m-%Y"),"%d/%m/%y")

# The vector "Restriction" is a list of the restrictions/lockdown status on each day. The points in the graph will be grouped and colored based on this.
Dato = KA$Date
Restriction = rep("No restrictions",length(Dato))
Restriction[which(Dato == "22/03/20")] = "Janta Curfew (22-Mar)"
Restriction[which(Dato == "26/03/20"):which(Dato == "14/04/20")] = "Phase 1 (25-Mar to 14-Apr)"
Restriction[which(Dato == "15/04/20"):which(Dato == "03/05/20")] = "Phase 2 (15-Apr to 3-May)"
Restriction[which(Dato == "04/05/20"):which(Dato == "17/05/20")] = "Phase 3 (4-May to 17-May)"
Restriction[which(Dato == "18/05/20"):which(Dato == "31/05/20")] = "Phase 4 (18-May to 31-May)"
Restriction[which(Dato == "01/06/20"):which(Dato == "30/06/20")] = "Unlock 1 (1-June to 30-June)"
Restriction[which(Dato == "01/07/20"):which(Dato == "31/07/20")] = "Unlock 2 (1-July to 31-July)"
Restriction[which(Dato == "01/08/20"):which(Dato == "31/08/20")] = "Unlock 3 (1-Aug to 31-Aug)"
Restriction[which(Dato == "01/09/20"):length(Restriction)] = "Unlock 4 (1-Sep to 30-Sep)"

# Compute Scaled Moving average over 2k+1 days and create plot for the same.
k=3 # Moving average window 3 days before to 3 days after.
trajgraph=function(j){
  # Compute Scaled Moving average over 2k+1 days for district with index j
  i=(unique(KA$District))[j]
  D <- subset(KA,District == i)
  to = D$Count
  tot<- to[to>20]     # Specify the cutoff to be 20 cases
  n=length(tot)
  if(n==0){cat(as.character(i), "doesn't have enough cases to make this graph meaningful. 1")
    end
  }else{
    Increase = (tot[(2*k+1):n]-tot[1:(n-2*k)])
    Total = tot[(k+1):(n-k)]
    Date = D$Date[to>20][(k+1):(n-k)]
    District = rep(i,n-2*k)
    if(max(Total)<50){cat(as.character(i),"doesn't have enough cases to make this graph meaningful. 3")
      end
    }else{
      Restrictions = Restriction[which(Dato==Date[1]):which(Dato==tail(Date,n=1))]
      dfi = data.frame(District,Increase,Total,Date,Restrictions)
      dfi$Restrictions <- factor(dfi$Restrictions ,levels = unique(dfi$Restrictions))
      
      # The plot of the moving average of the increase vs the total number of cases, colored based on the lockdown
      graph= ggplot(dfi,aes(x=Total,y=Increase,color=Restrictions,label=Date))+geom_point()+geom_line(aes(group=1))+scale_x_log10()+scale_y_log10()+ggtitle(as.character(i))+theme(plot.title = element_text(hjust = 0.5))+scale_color_manual(breaks = c("No restrictions","Janta Curfew (22-Mar)","Phase 1 (25-Mar to 14-Apr)","Phase 2 (15-Apr to 3-May)","Phase 3 (4-May to 17-May)","Phase 4 (18-May to 31-May)","Unlock 1 (1-June to 30-June)","Unlock 2 (1-July to 31-July)","Unlock 3 (1-Aug to 31-Aug)","Unlock 4 (1-Sep to 30-Sep)"), values=c("#ffd633","#ff471a", "#ff4da6", "#8c1aff","#3385ff","#00cc66","#3333ff","#156B3C","#ACC400","#CF771D"))
      graph
    }
  }
}

# Plots for districts that qualify the cutoff criteria
k=3
for(j in 1:30){
  i=(unique(KA$District))[j]
  D <- subset(KA,District == i)
  to = D$Count
  tot<- to[to>20]
  n=length(tot)
  if (n>5){
    Increase = (tot[(2*k+1):n]-tot[1:(n-2*k)])
    Total = tot[(k+1):(n-k)]
    if(max(Total)>50){
      # Saving the output as .html and .png
      name1 = paste(j,"agdist.png", sep="-")
      name2 = paste0("./plotlyfigures/", name1)
      ggsave(name2, plot=trajgraph(j))
      agdist = ggplotly(trajgraph(j), tooltip =c("label","x", "y"))
      name = paste(j,"agdist.html", sep="-")
      path <- file.path(getwd(), "plotlyfigures", name)
      htmlwidgets::saveWidget(agdist, file=path, selfcontained = FALSE, libdir =  "plotly.html")
    }
  }
}
