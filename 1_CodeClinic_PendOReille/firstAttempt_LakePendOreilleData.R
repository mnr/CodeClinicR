# Lake Pend Oreille S3 class to abstract the website data from the program
# Author: Mark Niemann-Ross, Spring 2015
# recommended reading: http://www.cyclismo.org/tutorial/R/s3Classes.html

LakePendOreilleData <- function() {
  # this will be used to stash the years of data  
  setupyearsOfData <- data.frame(datetime = character(),
                                 Air_Temp = numeric(),
                                 Barometric_Press = numeric(),
                                 Dew_Point = numeric(),
                                 Relative_Humidity = numeric(), 
                                 Wind_Dir = numeric(), 
                                 Wind_Gust = numeric(),
                                 Wind_Speed = numeric()
  )
  setupyearsOfData$datetime <- as.POSIXct(setupyearsOfData$datetime)
  
  classProperties <- list(
    yearsOfData = setupyearsOfData,
    kPORDeepMoorPath = "http://lpo.dt.navy.mil/data/"
    
  )
  
  # set the name of the class
  class(classProperties) <- append(class(classProperties),"LakePendOreilleData")
   
  # make sure the site is live
  checkURL <- file(kPORDeepMoorPath,"r")
  if (!isOpen(checkURL)) {
    stop(paste("There's a problem with the data:",geterrmessage()))
  } else {
    return(classProperties)
  }
  
}

# define a method for get a years worth of data
getThisYear <- function(theObject,theYear) {
  UseMethod("getThisYear",theObject)
}
getThisYear.default <- function(theObject,theYear) {
  print("accidentally called getThisYear.default")
  return(theObject)
}
getThisYear.LakePendOreilleData <- function(theObject,theYear) {
  print("in getThisYear.LakePendOreilleData")
  thisyearofdata <- read.delim("/var/folders/nn/sxyfpt_97mxbw613fxytvn4w0000gn/T//RtmpJ2vk5N/data190bc408ca0", stringsAsFactors=FALSE)
}
# 
# listAvailableYears.LakePendOreilleData <- function() {}
# 
# LakePendOreilleData <- function(x) UseMethod("LakePendOreilleData")
# 
# default.LakePendOreilleData <- function(x) "unknown request"