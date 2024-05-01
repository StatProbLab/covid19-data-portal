############################################################
## Title: Districtwise Active Cases of Coronavirus        ##
##        in Karnataka                                    ##
## Input: IRDD_allka.csv                                  ##  
## Output: Plot of Date Vs Number of Active Cases         ##
## Date Modified: 25-04-2024                              ##
############################################################

# Required Libraries
library(plotly)
library(anytime)


addFormats(c("%d/%m/%y", "%d-%m-%y", "%d-%m-%Y", "%d/%m/%Y"))
FILENAME1 <- "./data/kacleaned.csv"
FILENAME2 <- "./data/district-codes.csv"
GRAPHSAVEPATH <- "./graphs/"

# Reading CSV files into dataframes
allka = read.csv('./data/IRDD_allka.csv')
#kacleaned.data <- read.csv(file=FILENAME1)
#district.data  <- read.csv(file=FILENAME2)

DATES <- DATES <- as.Date(unique(allka$Date),'%d-%m-%Y')
DISTRICTINDICES <- 1:32
DISTRICT_NAMES = unique(allka$District)

# Function to generate plotly graphs
makePlots <- function(df, TITLE, COLOR, YLAB) {
  # Required settings/formats for text on plots
  f1 <- list(family = "serif", size = 17, color = 'maroon',face="bold")
  f2 <- list(family = "serif", size = 13, color = 'maroon',face="bold")
  f3 <- list(family = "serif", size = 14, color = 'black')
  
  date_months <- seq(as.Date("2020-04-01"), tail(df$dates, 1), "months")
  
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

# To save active case data as a new csv
activedfcsv <- NULL
rbind(activedfcsv, c("", as.character(DATES))) -> activedfcsv
colnames(activedfcsv) <- c("", as.character(1 : (ncol(activedfcsv) - 1)))

lastweekcsv <- NULL
lastweek <- length(DATES) - 7
rbind(lastweekcsv, c("Dates", as.character(DATES[lastweek:(lastweek + 7)]))) -> lastweekcsv
colnames(lastweekcsv) <- c("", as.character(1 : (ncol(lastweekcsv) - 1)))

for (index in DISTRICTINDICES) {
  
  district_name <- DISTRICT_NAMES[index]
  district_code <- index
  
  activedf <- filter(allka,allka$District==district_name) 
  activedf <- mutate(activedf, count = activedf$Infected-activedf$Recovered-activedf$Deceased)
  activedf <- activedf[,c(1,6)]
  colnames(activedf)[1] = 'dates'
  activedf$dates = as.Date(activedf$dates,'%d-%m-%Y')

  activeplot  <- makePlots(activedf, district_name, "#0072b2", "Total Active cases")
  
  rbind(activedfcsv, c(district_name, activedf$count)) -> activedfcsv
  
  lastweek <- length(activedf$count) - 7
  rbind(lastweekcsv, c(district_name,
                       activedf$count[lastweek:(lastweek + 7)])) -> lastweekcsv
  
  # Saving active svg and plotly
  name1 = paste(district_code, "kar-active.svg", sep="-")
  name2 = paste0(GRAPHSAVEPATH, name1)
  save_image(activeplot, file = name2)
  name = paste(district_code , "kar-active.html", sep="-")
  path <- file.path(getwd(), GRAPHSAVEPATH, name)
  htmlwidgets::saveWidget(activeplot, file=path, selfcontained = FALSE, libdir = "plotly.html")
  
}

# Saving active cases csv
write.csv(x = activedfcsv, "./csv/kadistactive.csv" , row.names = FALSE, quote = FALSE)
write.csv(x = lastweekcsv, file = "./csv/karlastweekactive.csv", row.names = FALSE, quote = FALSE)
