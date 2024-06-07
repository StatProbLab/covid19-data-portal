###############################################################################
## Title: Box plot for age                                                   ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


##Box plot for age

g_7_p <- ggplot(data,aes(x=reorder(District,`Age In Years`,na.rm = TRUE),y=`Age In Years`,col=District)) + geom_boxplot(outlier.colour = NULL) + scale_fill_viridis(discrete = TRUE) + ggtitle("District wise age box plot") + xlab("Age") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 34),plot.title = element_text(color = "#D55E00",face = "bold", size = 40),axis.text.y = element_text(hjust = 1, size=28), axis.text.x = element_text(hjust = 1, angle = 45, size = 28)) + scale_y_continuous(name = "Districts",breaks = seq(0,120,10),limits = c(0,120))
g_7_h <- ggplot(data,aes(x=reorder(District,`Age In Years`,na.rm = TRUE),y=`Age In Years`,col=District)) + geom_boxplot(outlier.colour = NULL) + scale_fill_viridis(discrete = TRUE) + ggtitle("District wise age box plot") + xlab("Age") + theme(legend.position = "none",axis.title = element_text(color = "#D55E00", size = 20),plot.title = element_text(color = "#D55E00",face = "bold", size = 24),axis.text.y = element_text(hjust = 1, size=18), axis.text.x = element_text(hjust = 1, angle = 45, size = 18)) + scale_y_continuous(name = "Districts",breaks = seq(0,120,10),limits = c(0,120))
#ggsave(g_7,file="C:/Users/srini/Dropbox/summertime/Srinidi/samp_Graph.png",width = 20, height = 10.7, dpi = 300, units = "in")
gp_6 <- ggplotly(g_7_h)
name <- paste("ageBoxPlot","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_6, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("ageBoxPlot","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_7_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
