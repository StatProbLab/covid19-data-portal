############################################################
## Title: Statewise Active Cases of Coronavirus           ##
##        in India                                        ##
## Input: IRDD_allindia.csv                               ##  
## Output: Plot of Date Vs Number of Active Cases         ##
## Date Modified: 25-04-2024                              ##
############################################################

library(plotly)
library(anytime)
library(dplyr)

addFormats(c("%d/%m/%y", "%d-%m-%y", "%d-%m-%Y", "%d/%m/%Y"))

FILENAME <- "./data/IRDD_allindia.csv"
GRAPHSAVEPATH <- "./graphs/"

allindia <- read.csv(file = FILENAME, check.names = FALSE)

NCOL <- ncol(allindia)
STATE_INDICES <- 1:37
STATE_NAMES <- unique(allindia$State)
DATES <- as.Date(unique(allindia$Date),'%d-%m-%Y')

# Function to generate plotly graphs
makePlots <- function(df, TITLE, COLOR, YLAB) {
  # Required settings/formats for text on plots
  f1 <- list(family = "serif", size = 17, color = 'maroon',face="bold")
  f2 <- list(family = "serif", size = 13, color = 'maroon',face="bold")
  f3 <- list(family = "serif", size = 14, color = 'black')
  
  date_months <- seq(as.Date("2020-03-01"), tail(df$dates, 1), "months")
  
  TICKVALS <- format(as.Date(as.character(date_months)), "%Y-%m-%d")
  TICKTEXT <- as.character(format(date_months, "%b-%y"))
  
  fig <- plot_ly(df, x = ~dates, y = ~count, type="scatter" ,mode = 'lines+markers',
                 line = list(color = COLOR), hoverinfo = 'text', 
                 text = ~paste('</br> Date: ', format(dates, "%d-%b-%y"),
                               '</br> Count:', count))
  
  fig <- fig %>% add_trace(df, x = ~dates, y = ~count, type = "scatter",
                           mode = "markers+lines", marker = list(color = COLOR),
                           textposition = 'center', showlegend = FALSE)
  
  fig <- fig %>% layout(title = TITLE, font = f2,
                        yaxis = list(title = YLAB, titlefont = f1, 
                                     tickfont = f3, showgrid = T, showline = T, 
                                     zeroline = F),
                        xaxis = list(title = "", tickangle = -45, tickfont = f3, 
                                     showgrid = T, showline = T, tickvals = TICKVALS, 
                                     ticktext = TICKTEXT))
  return(fig)
  
}

activeindiadf <- NULL
rbind(activeindiadf, c("", as.character(DATES))) -> activeindiadf
colnames(activeindiadf) <- c("", as.character(1 : (ncol(activeindiadf) - 1)))
activeindiadf <- as.data.frame(activeindiadf)

lastweekcsv <- NULL
lastweek <- length(DATES) - 8
rbind(lastweekcsv, c("Dates", as.character(DATES[lastweek:(lastweek + 7)]))) -> lastweekcsv
colnames(lastweekcsv) <- c("", as.character(1 : (ncol(lastweekcsv) - 1)))
lastweekcsv <- as.data.frame(lastweekcsv)

for (index in STATE_INDICES) {
  
  state_name <- STATE_NAMES[index]
  state_code <- index
  activedf <- filter(allindia,allindia$State==state_name) 
  activedf <- mutate(activedf, count = activedf$Infected-activedf$Recovered-activedf$Deceased)
  activedf <- activedf[,c(1,6)]
  colnames(activedf)[1] = 'dates'
  activedf$dates = as.Date(activedf$dates,'%d-%m-%Y')
  
  activeplot <- makePlots(activedf, state_name, "#0072b2", "Total Active Cases")
  rbind(activeindiadf, c(state_name, activedf$count)) -> activeindiadf
  
  lastweek <- length(activedf$count) - 7
  rbind(lastweekcsv, c(state_name,
                       activedf$count[lastweek:(lastweek + 7)])) -> lastweekcsv
  
  # Saving svg and plotly
  name1 = paste(state_code, "india-active.svg", sep="-")
  name2 = paste0(GRAPHSAVEPATH, name1)
  save_image(activeplot, file = name2)
  name = paste(state_code , "india-active.html", sep="-")
  path <- file.path(getwd(), GRAPHSAVEPATH, name)
  htmlwidgets::saveWidget(activeplot, file=path, selfcontained = FALSE, libdir = "plotly.html")
  
}

# Saving CSV files
write.csv(x = activeindiadf, "./csv/indiaactive.csv" , row.names = FALSE, quote = FALSE)
write.csv(x = lastweekcsv, file = "./csv/indialastweekactive.csv", row.names = FALSE, quote = FALSE)

