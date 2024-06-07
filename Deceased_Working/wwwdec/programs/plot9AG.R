###############################################################################
## Title: Dataframes required                                                ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


##Dataframes required

death_500_df <- age_not_na_data[age_not_na_data$District %in% death_500,]
death_1000_df <- age_not_na_data[age_not_na_data$District %in% death_1000,]
death_more_than_1000_df <- age_not_na_data[age_not_na_data$District %in% death_more_than_1000,]

##Scatterplot of Age distribution

g_9_p <- ggplot(data,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE) + ggtitle("Age Distribution District wise") + xlab("Age") + theme_minimal() + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34)) + scale_y_continuous(name = "Number of deceased",breaks = seq(0,120,10),limits = c(0,120))
g_9_h <- ggplot(data,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_fill_viridis(discrete = TRUE) + ggtitle("Age Distribution District wise") + xlab("Age") + theme_minimal() + theme(axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, angle = 45, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20)) + scale_y_continuous(name = "Number of deceased",breaks = seq(0,120,10),limits = c(0,120))
#legend.position = "none",
gp_8 <- ggplotly(g_9_h)
name <- paste("ageScatter","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_8, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("ageScatter","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_9_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##Scatterplot of Age distribution over districts with death count within 500

g_10_p <- ggplot(death_500_df,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_color_viridis_d(option = "plasma") + ggtitle("Death count within 500") + xlab("Age") + theme_minimal() + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34))
g_10_h <- ggplot(death_500_df,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_color_viridis_d(option = "plasma") + ggtitle("Death count within 500") + xlab("Age") + theme_minimal() + theme(axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20))
gp_9 <- ggplotly(g_10_h)
name <- paste("ageScatterCntLessThan500","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_9, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("ageScatterCntLessThan500","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_10_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##Scatterplot of Age distribution over districts with death count within 500 and 1000

g_11_p <- ggplot(death_1000_df,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_color_viridis_d(option = "plasma") + theme_minimal() + ggtitle("Death count within 500 and 1000") + xlab("Age") + ylab("Number of deceased") + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34))
g_11_h <- ggplot(death_1000_df,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_color_viridis_d(option = "plasma") + theme_minimal() + ggtitle("Death count within 500 and 1000") + xlab("Age") + ylab("Number of deceased") + theme(axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20))
gp_10 <- ggplotly(g_11_h)
name <- paste("ageScatterCnt500And1000","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_10, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("ageScatterCnt500And1000","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_11_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##Scatterplot of Age distribution over districts with death count above 1000

g_12_p <- ggplot(death_more_than_1000_df,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_color_viridis_d(option = "plasma") + ggtitle("Death count above 1000") + xlab("Age") + ylab("Number of deceased") + theme_minimal() + theme(axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, size = 28), plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34))
g_12_h <- ggplot(death_more_than_1000_df,aes(x=`Age In Years`,color=District)) + geom_point(stat="count") + scale_color_viridis_d(option = "plasma") + ggtitle("Death count above 1000") + xlab("Age") + ylab("Number of deceased") + theme_minimal() + theme(axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, size = 18), plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20))
gp_11 <- ggplotly(g_12_h)
name <- paste("ageScatterCntAbove1000","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_11, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("ageScatterCntAbove1000","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_12_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
