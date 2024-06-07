###############################################################################
## Title: WAVE WISE ANALYSIS                                                 ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################

##WAVE WISE ANALYSIS

##Wave 1 age distribution and total population
Age_w1 = na.omit(as.numeric(as.character(subset(wave_1,`Age In Years`!="")$`Age In Years`)))
Age_df_w1 = data.frame(Age_w1)
names(Age_df_w1) = c("Age In Years")

mean_val_1 <- round(mean(wave_1$`Age In Years`,na.rm = TRUE),2)

g_p <- ggplot(Age_df_w1, aes(x=`Age In Years`))+ geom_histogram(data = Age_df_w1,aes(y=stat(count)/sum(count),fill="#37ffd9"), binwidth = 5) + geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="red",alpha=0.15) + geom_vline(xintercept = mean_val_1, color = "yellow") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Relative Frequency") + ggtitle("Wave 1- age distribution of deceased") + scale_fill_viridis_d(option = "plasma") + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28))
g_h <- ggplot(Age_df_w1, aes(x=`Age In Years`))+ geom_histogram(data = Age_df_w1,aes(y=stat(count)/sum(count),fill="#37ffd9"), binwidth = 5) + geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="red",alpha=0.15) + geom_vline(xintercept = mean_val_1, color = "yellow") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Relative Frequency") + ggtitle("Wave 1- age distribution of deceased") + scale_fill_viridis_d(option = "plasma") + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
gp <- ggplotly(g_h, tooltip = c("x","y","xintercept"))
name = paste("wave1AgePop","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("wave1AgePop","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##Wave 2 age distribution and total population
Age_w2 = na.omit(as.numeric(as.character(subset(wave_2,`Age In Years`!="")$`Age In Years`)))
Age_df_w2 = data.frame(Age_w2)
names(Age_df_w2) = c("Age In Years")

mean_val_2 <- round(mean(wave_2$`Age In Years`,na.rm = TRUE),2)

g_p <- ggplot(Age_df_w2, aes(x=`Age In Years`))+ geom_histogram(data = Age_df_w2,aes(y=stat(count)/sum(count),fill="#f0e442"), binwidth = 5) + geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="red",alpha=0.15) + geom_vline(xintercept = mean_val_2, color = "blue") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Relative Frequency") + ggtitle("Wave 2- age distribution of deceased") + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28))
g_h <- ggplot(Age_df_w2, aes(x=`Age In Years`))+ geom_histogram(data = Age_df_w2,aes(y=stat(count)/sum(count),fill="#f0e442"), binwidth = 5) + geom_histogram(data = Cen,aes(y=stat(count)/sum(count)),binwidth = 5,fill="white",col="red",alpha=0.15) + geom_vline(xintercept = mean_val_2, color = "blue") + scale_x_continuous(name = "Age",breaks = seq(0,120,10),limits = c(0,120))+ scale_y_continuous(name ="Relative Frequency") + ggtitle("Wave 2- age distribution of deceased") + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
gp <- ggplotly(g_h,tooltip = c("x","y","xintercept"))
name = paste("wave2AgePop","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("wave2AgePop","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

