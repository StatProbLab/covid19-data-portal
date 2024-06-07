###############################################################################
## Title: age distribution data of deceased patients in Karnataka            ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")


##PLOTS
#KARNATAKA AGE DISTRIBUTION PLOT
Age = na.omit(as.numeric(as.character(subset(data,`Age In Years`!="")$`Age In Years`)))
Age_df = data.frame(Age)
names(Age_df) = c("Age In Years")
names(Cen) = c("Age In Years")

mean_val <- round(mean(data$`Age In Years`,na.rm = TRUE),2)

g_0_1_p <- ggplot(data) + geom_histogram(aes(x=`Age In Years`, fill=Sex),binwidth = 5, position = "dodge") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Count") + geom_vline(xintercept = mean_val, color = "red") + ggtitle("Stacked age gender plot") + scale_fill_viridis_d(option = "plasma") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g_0_1_h <- ggplot(data) + geom_histogram(aes(x=`Age In Years`, fill=Sex),binwidth = 5, position = "dodge") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Count") + geom_vline(xintercept = mean_val, color = "red") + ggtitle("Stacked age gender plot") + scale_fill_viridis_d(option = "plasma") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g_0_p <- ggplot(Age_df, aes(x=`Age In Years`))+ geom_histogram(data = Age_df,aes(y=stat(count)/sum(count),fill="#37ffd9"), binwidth = 5) + geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="red",alpha=0.15) + geom_vline(xintercept = mean_val, color = "yellow") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Relative Frequency") + ggtitle("Karnataka age distribution of deceased") + scale_fill_viridis_d(option = "plasma") + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28))
g_0_h <- ggplot(Age_df, aes(x=`Age In Years`))+ geom_histogram(data = Age_df,aes(y=stat(count)/sum(count),fill="#37ffd9"), binwidth = 5) + geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="red",alpha=0.15) + geom_vline(xintercept = mean_val, color = "yellow") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Relative Frequency") + ggtitle("Karnataka age distribution of deceased") + scale_fill_viridis_d(option = "plasma") + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
#g_0 <- ggplot(data, aes(x=`Age In Years`))+ geom_histogram(aes(y = ..count.., fill = as.factor(`Age In Years`)), bins = 20) + geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="red",alpha=0.15) + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Number of deceased") + ggtitle("Karnataka age distribution of covid patients") + scale_fill_viridis_d(option = "plasma") + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
gp_0 <- ggplotly(g_0_1_h, tooltip = c("x","y","xintercept"))
name = paste("kaAge","html", sep=".")
path <- file.path(getwd(), "/graphs", name)
htmlwidgets::saveWidget(gp_0, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("kaAge","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_0_1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

gp_0 <- ggplotly(g_0_h,tooltip = c("x","y","xintercept"))
name = paste("kaAgePop","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_0, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("kaAgePop","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_0_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
