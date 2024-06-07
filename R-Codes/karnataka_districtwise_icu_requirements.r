###############################################################
## Title: ICU Utilization Timeline graph for all Districts   ##
##        in Karnataka                                       ##
## Input: district-codes.csv and icutimelineka.csv           ##
## Output: Plot of Date Vs ICU requirements                  ##
## Date Modified: 01-05-2024                                 ##
###############################################################

# Required Libraries
library(plotly)
library(anytime)

# Data has different formats: check
addFormats(c("%d/%m/%y", "%d-%m-%y", "%d-%m-%Y", "%d/%m/%Y"))

FILENAME2 <- "./data/district-codes.csv"
FILENAME3 <- "./data/icutimelineka.csv"
GRAPHSAVEPATH <- "./graphs/"

# Reading CSV files into dataframes
district.data  <- read.csv(file=FILENAME2)
icu.data       <- read.csv(file=FILENAME3)

NROW <- nrow(icu.data)

# New date function "anydate", works with all date formats
ICU_DATES <- anydate(as.character(icu.data[seq(1, NROW, by=30), 2]))

# District indices as in the dataset
DISTRICTINDICES <- 2:31

# Function to generate plotly plots
makePlots <- function(df, TITLE, COLOR, YLAB) {
  # Required settings/formats for text on plots
  f1 <- list(family = "serif", size = 17, color = 'maroon',face="bold")
  f2 <- list(family = "serif", size = 13, color = 'maroon',face="bold")
  f3 <- list(family = "serif", size = 14, color = 'black')
  
  date_months <- seq(as.Date("2020-06-01"), tail(df$dates, 1), "months")
  
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

lastweekcsv <- NULL
lastweek <- length(ICU_DATES) - 7
rbind(lastweekcsv, c("Dates", as.character(ICU_DATES[lastweek:(lastweek + 7)]))) -> lastweekcsv
colnames(lastweekcsv) <- c("", as.character(1 : (ncol(lastweekcsv) - 1)))

for (index in DISTRICTINDICES) {
  
    district_code <- index - 1
    district_name <- as.character(district.data[290 + district_code, 2])
    
    icu_district_count <- as.integer(icu.data[seq(district_code, NROW, by=30), 3])
    
    icudf <- data.frame(dates = ICU_DATES, count = icu_district_count)
    icuplot <- makePlots(icudf, district_name, "#cc79a7", "ICU requirements")
    
    lastweek <- length(icu_district_count) - 7
    rbind(lastweekcsv, c(district_name,
                         icu_district_count[lastweek:(lastweek + 7)])) -> lastweekcsv
    
    # Saving icu svg and plotly
    name1 = paste(district_code, "kar-icu.svg", sep="-")
    name2 = paste0(GRAPHSAVEPATH, name1)
    save_image(icuplot, file = name2)
    name = paste(district_code ,"kar-icu.html", sep="-")
    path <- file.path(getwd(), GRAPHSAVEPATH, name)
    htmlwidgets::saveWidget(icuplot, file=path, selfcontained = FALSE, libdir = "plotly.html")
  
}

write.csv(x = lastweekcsv, file = "./csv/karlastweekicu.csv", row.names = FALSE, quote = FALSE)
