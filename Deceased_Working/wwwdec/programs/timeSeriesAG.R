###############################################################################
## Title: Analyzing Deceased Patients in India by Age and Month              ##
## Input: NA                                          	                     ##
## Output: Plots                                                             ##
## Date Modified: 21st May 2024                                              ##
###############################################################################


##Creating dataframes

df_less_than_45 <- data[data$`Age In Years` < 45,]
df_45_to_60 <- data[data$`Age In Years` >= 45 & data$`Age In Years` < 60,]
df_60_above <- data[data$`Age In Years` >= 60,]

month_wise_1 <- as.data.frame(table(format(df_less_than_45$DOD,"%Y-%m")))
month_wise_2 <- as.data.frame(table(format(df_45_to_60$DOD,"%Y-%m")))
month_wise_3 <- as.data.frame(table(format(df_60_above$DOD,"%Y-%m")))

##Renaming the column names

names(month_wise_1) <- c("Month","Count")
names(month_wise_2) <- c("Month","Count")
names(month_wise_3) <- c("Month","Count")

##Calculating percentage contribution

month_wise_1$Percentage <- round(((month_wise_1$Count/sum(month_wise_1$Count))*100),2)
month_wise_2$Percentage <- round(((month_wise_2$Count/sum(month_wise_2$Count))*100),2)
month_wise_3$Percentage <- round(((month_wise_3$Count/sum(month_wise_3$Count))*100),2)

##Creating new columns to add category feature

categ <- rep("0 - 45",length(month_wise_1$Month))
month_wise_1$categ <- categ
categ <- rep("45 - 60",length(month_wise_2$Month))
month_wise_2$categ <- categ
categ <- rep("above 60",length(month_wise_3$Month))
month_wise_3$categ <- categ

##Combining the three dataframes

df_new = rbind(month_wise_1, month_wise_2, month_wise_3)

##Line Plots

##All three count based plots together

g_p <- ggplot(df_new,aes(x=Month,y=Count,group=categ,color=categ)) + geom_line(size=3) + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients monthwise distribution") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g_h <- ggplot(df_new,aes(x=Month,y=Count,group=categ,color=categ)) + geom_line(size=3) + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients monthwise distribution") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))

gp <- ggplotly(g_h, tooltip = c("x","y","group"))

name = paste("linePlotAgeDistr","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("linePlotAgeDistr","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##All three percentage based plots together

g_p <- ggplot(df_new,aes(x=Month,y=Percentage,group=categ,color=categ)) + geom_line(size=2) + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Percentage of deceased") + ggtitle("Deceased patients monthwise distribution") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g_h <- ggplot(df_new,aes(x=Month,y=Percentage,group=categ,color=categ)) + geom_line(size=2) + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Percentage of deceased") + ggtitle("Deceased patients monthwise distribution") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))

gp <- ggplotly(g_h, tooltip = c("x","y","group"))

name = paste("linePlotAgeDistrPercent","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("linePlotAgeDistrPercent","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##Individual plots for each age subgroup

g1_p <- ggplot(month_wise_1,aes(x=Month,y=Count,group=1)) + geom_line() + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients under age 45") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g1_h <- ggplot(month_wise_1,aes(x=Month,y=Count,group=1)) + geom_line() + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients under age 45") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
g2_p <- ggplot(month_wise_2,aes(x=Month,y=Count,group=1)) + geom_line() + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients between age 45 and 60") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g2_h <- ggplot(month_wise_2,aes(x=Month,y=Count,group=1)) + geom_line() + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients between age 45 and 60") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
g3_p <- ggplot(month_wise_3,aes(x=Month,y=Count,group=1)) + geom_line() + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients above age 60") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g3_h <- ggplot(month_wise_3,aes(x=Month,y=Count,group=1)) + geom_line() + xlab("Months") + ylab("Number of deceased") + ggtitle("Deceased patients above age 60") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))

gp <- ggplotly(g1_h, tooltip = c("x","y"))
name = paste("linePlotAgeLessThan45","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("linePlotAgeLessThan45","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

gp <- ggplotly(g2_h, tooltip = c("x","y"))
name = paste("linePlotAge45To60","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("linePlotAge45To60","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g2_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

gp <- ggplotly(g3_h, tooltip = c("x","y"))
name = paste("linePlotAgeMoreThan60","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("linePlotAgeMoreThan60","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g3_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
