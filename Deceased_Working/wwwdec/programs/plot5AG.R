###############################################################################
## Title: Wave wise age distribution                                         ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 21st May 2024                                              ##
###############################################################################


##Wave wise age distribution

g_4_p <- ggplot(df, aes(x = `Age In Years`, fill = categ)) + geom_histogram(bins = 10, position = "dodge") + scale_fill_viridis_d(option = "plasma") + labs(x = "Age", y = "Number of deceased", title = "Age distribution across waves", fill = "Waves") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g_4_h <- ggplot(df, aes(x = `Age In Years`, fill = categ)) + geom_histogram(bins = 10, position = "dodge") + scale_fill_viridis_d(option = "plasma") + labs(x = "Age", y = "Number of deceased", title = "Age distribution across waves", fill = "Waves") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
gp_2 <- ggplotly(g_4_h)
name = paste("ageAcrossWaves","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_2, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("ageAcrossWaves","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_4_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##Total deaths across waves

names <- c("Wave 1", "Middle wave", "Wave 2")
deaths <- c(length(wave_1_no_na$District),length(mid_wave_no_na$District),length(wave_2_no_na$District))
df1 <- data.frame(names,deaths)

g_5_p <- ggplot(df1) + geom_bar(aes(x = names,y = deaths, fill = as.factor(names)), stat = "identity", width = 0.5) + scale_fill_viridis_d(option = "plasma") + labs(x = "Wave", y = "Number of deceased", title = "Death count across waves", fill = "Waves") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28),legend.justification = c("right", "top"),legend.position = c(.99, .95))
g_5_h <- ggplot(df1) + geom_bar(aes(x = names,y = deaths, fill = as.factor(names)), stat = "identity", width = 0.5) + scale_fill_viridis_d(option = "plasma") + labs(x = "Wave", y = "Number of deceased", title = "Death count across waves", fill = "Waves") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
gp_3 <- ggplotly(g_5_h, tooltip = c("x","y"))
name = paste("totalDeathsAcrossWaves","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_3, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("totalDeathsAcrossWaves","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_5_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
