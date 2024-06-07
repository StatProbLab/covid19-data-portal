###############################################################################
## Title: Daily Trends of COVID-19 Cases in Karnataka                        ##
## Input: mediadata/kaHospSrinidi.xlsx                                       ##
## Output: csv/KarnatakaActiveDeceasedCateg.csv                              ##
## Date Modified: 21st May 2024                                              ##
###############################################################################

##Required Libraries
library(readxl)
library(ggplot2)
library(plotly)

##Read data
#data <- read.csv("../mediadata/kaHospSrinidi.csv")
data <- read_excel("mediadata/kaHospSrinidi.xlsx")

##Formatting data
names(data) = c("Date", "totalActiveWithoutICU", "totalDischarged", "totalDeceased", "totalICU")

data$Date <- as.Date(data$Date, format = "%d-%m-%Y")

for(i in seq(length(data$totalICU)))
{
  if(is.na(data$totalICU[i]))
  {
    data$totalICU[i] = 0
  }
}

##Creating total active cases
data$totalActive = data$totalActiveWithoutICU + data$totalICU

##New dataframe
df1 = data.frame(matrix(0,nrow = length(data$totalActive), ncol = 2))
df2 = data.frame(matrix(0,nrow = length(data$totalDeceased), ncol = 2))

df1$case <- data$totalActive
df2$case <- data$totalDeceased

temp <- rep('Total active cases',length(data$totalActive))
df1$categ <- temp
temp <- rep('Total deceased',length(data$totalDeceased))
df2$categ <- temp

df <- rbind(df1, df2)
df <- df[,-c(1,2)]
df$Date <- data$Date

##PLOTS

#Line plot of active cases and deceased
g1_p <- ggplot(data = df, aes(x = Date, y = case, group = categ, color = categ)) + geom_line() + scale_color_viridis_d() + ggtitle("Line plot of total active cases and deceased") + xlab("Date") + ylab("Count") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g1_h <- ggplot(data = df, aes(x = Date, y = case, group = categ, color = categ)) + geom_line() + scale_color_viridis_d() + ggtitle("Line plot of total active cases and deceased") + xlab("Date") + ylab("Count") + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18),legend.justification = c("right", "top"),legend.position = c(.95, .95))

gp1 <- ggplotly(g1_h, tooltip = c("x","y","group"))
name = paste("kaActiveDeceased","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp1, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("kaActiveDeceased","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')


#Line plot of discharged cases
g2_p <- ggplot(data, aes(x = Date, y = totalDischarged)) + geom_line() + ggtitle("Line plot total discharged cases") + xlab("Date") + ylab("Count") + scale_color_viridis_d() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g2_h <- ggplot(data, aes(x = Date, y = totalDischarged)) + geom_line() + ggtitle("Line plot total discharged cases") + xlab("Date") + ylab("Count") + scale_color_viridis_d() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18),legend.justification = c("right", "top"),legend.position = c(.95, .95))

gp2 <- ggplotly(g2_h, tooltip = c("x","y"))
name = paste("kaDischarged","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp2, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("kaDischarged","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g2_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#Writing files
write.csv(df, file = "csv/KarnatakaActiveDeceasedCateg.csv", row.names = FALSE)
