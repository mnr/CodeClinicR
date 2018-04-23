# remarks -----------------------------------------------------------------


# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 1. Weather



# setup and libraries -----------------------------------------------------

library(magrittr)
library(lubridate)

# Introduction
# This Code Clinic problem is about calculating statistics from a data set.
# It's easy stuff, but presents a good example of how different languages
# accomplish common tasks.


# Import the source data --------------------------------------------------
# The data set is weather data captured from Lake Pend O'Reille
# in Northern Idaho. We have almost 20 megabytes of data from the
# years 2012 thorugh 2015. That data is available in the folder with
# other exercise files. Each observation in the data includes several
# variables and the data is straightforward.

mytempfile <- tempfile()

readOneFile <- function(dataPath) {
  read.table(dataPath,
             header = TRUE,
             stringsAsFactors = FALSE)
}

myProgressBar <- txtProgressBar(min = 2012, max = 2015, style = 3)

for (dataYear in 2012:2015) {
  
  dataPath <-
    paste0(
      "https://raw.githubusercontent.com/lyndadotcom/LPO_weatherdata/master/Environmental_Data_Deep_Moor_",
      dataYear,
      ".txt"
    )
  
  if (exists("LPO_weather_data")) {
    mytempfile <- readOneFile(dataPath)
    LPO_weather_data <- rbind(LPO_weather_data, mytempfile)
  } else {
    LPO_weather_data <- readOneFile(dataPath)
  }
  setTxtProgressBar(myProgressBar, value = dataYear)
  
}

# confirm the results of the import
head(LPO_weather_data, n = 3)
tail(LPO_weather_data, n = 3)

print(paste("Number of rows imported: ", nrow(LPO_weather_data)))

# Calculate the Coefficient of Barometric Pressure --------------------------------------------
# The problem is simple: Write a function that accepts ...
# a beginning date and time
# ...and...
# an ending date and time...

startDateTime <- "2014-01-02 12:03:34"
endDateTime <- "2014-01-04 12:03:34"

# ...then...
# inclusive of those dates and times return the coefficient of the
# slope of barometric pressure.

# helper function to get a subset of LPO_weather_data
# observations are the date range
# variables are barometric pressure, date, and time
getBaromPressures <- function(dateTimeInterval) {
  subset(
    LPO_weather_data,
    ymd_hms(paste(date, time)) %within% dateTimeInterval,
    select = c(Barometric_Press, date, time)
  )
}

calculateBaroPress <- function(startDateTime, endDateTime) {
  dateTimeInterval <- interval(ymd_hms(startDateTime),
                               ymd_hms(endDateTime))
  
  baroPress <- getBaromPressures(dateTimeInterval)
  
  slope <- ymd_hms(paste(baroPress$date, baroPress$time))
  
  lm(Barometric_Press ~ slope, data = baroPress)

}

calculateBaroPress(startDateTime, endDateTime)

# A rising slope indicates an increasing barometric pressure,
# which typically means fair and sunny weather. A falling slope
# indicates a decreasing barometric pressure, which typically means
# stormy weather.

# We're only asking for the coefficient – but some may choose
# to generate a graph of the results as well.


# Graph Barometric Pressure -----------------------------------------------
graphBaroPressure <- function(startDateTime, endDateTime ) {
  
  dateTimeInterval <- interval(ymd_hms(startDateTime),
                               ymd_hms(endDateTime))
  
  baroPress <- getBaromPressures(dateTimeInterval)
  
  thisDateTime <- ymd_hms(paste(baroPress$date, baroPress$time))
  
  plot(
    x = thisDateTime,
    y = baroPress$Barometric_Press,
    xlab = "Date and Time",
    ylab = "Barometric Pressure",
    main = paste(
      "Barometric Pressure from ",
      ymd_hms(startDateTime),
      "to",
      ymd_hms(endDateTime)
    )
  )
  abline(calculateBaroPress(startDateTime, endDateTime), col = "red")
}

graphBaroPressure(startDateTime, endDateTime)

