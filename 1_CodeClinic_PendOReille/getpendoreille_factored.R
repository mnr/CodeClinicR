GetPendOreille <- function(startDate,endDate) {
  # startDate and endDate are in the format YYYYMMDD
  # Uses lubridate package for assistance with dates
  # lubridate documentation at http://cran.r-project.org/web/packages/lubridate/lubridate.pdf
  
  # check input for validity
  the.start.date <- ymd_hms(paste(ymd(startDate),"00:00:01"))
  the.end.date <- ymd_hms(paste(ymd(endDate),"00:00:01"))
  
  if (the.start.date > the.end.date) {
    # Error: the end date is earlier than the start date
    stop("Invalid input: start date is after end date")
  }
  
  # check to see if LakePendOreilleData class is available
  # be sure to setwd() to the directory containing the source
  if (!exists("LakePendOreilleData")) source("LakePendOreilleData.R")
  
  # Open up a connection to the data
  # or stops if the connection is not available
  lakePORData <- LakePendOreilleData()
  
  # Is there data for this range?
  # assemble a list of requested years
  requestedYears <- as.character(c(year(the.start.date):year(the.end.date)))
  if(length(intersect(lakePORData$listAvailableYears(),requestedYears)) < 1) {
    # one or more of these years are not available
    stop (paste("Sorry. Data is not available for this range of dates"))
  }
  
  if (the.end.date > now()) {
    # Error: input is asking for data for tomorrow
    stop("End Date is later than today")
  }
  
  # Now I'm confident the input is usable.
  # Based on the input, I'm going to grab the data I need
  por.weather.data <- lakePORData$getPORDataRange(the.start.date,the.end.date)
  
  # calculate the mean and median of the 
  # wind speed, air temperature and barometric pressure 
  # recorded at the deep moor station 
  # for a given range of dates

  Mean <- colMeans(por.weather.data[2:8], na.rm=TRUE)
  Median <- sapply(por.weather.data[2:8], median, na.rm = TRUE)
  rbind(Mean,Median)
  
}
