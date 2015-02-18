# Lake Pend Oreille S3 class to abstract the website data from the program
# Author: Mark Niemann-Ross, Spring 2015
# recommended reading: http://www.cyclismo.org/tutorial/R/s3Classes.html
# assumes presence of lubridate for date conversion

LakePendOreilleData <- function() {
  
  kPORDeepMoorPath <- "http://lpo.dt.navy.mil/data/"
  
  # make sure the site is live
  checkURL <- file(kPORDeepMoorPath,"r")
  if (!isOpen(checkURL)) {
    stop(paste("There's a problem with the data:",geterrmessage()))
  }
  
  # get the environment for this instance of the function
  thisEnv <- environment()
  
  # this will be used to stash the years of data  
  YearsOfData <- data.frame(datetime = character(),
                            Air_Temp = numeric(),
                            Barometric_Press = numeric(),
                            Dew_Point = numeric(),
                            Relative_Humidity = numeric(), 
                            Wind_Dir = numeric(), 
                            Wind_Gust = numeric(),
                            Wind_Speed = numeric()
  )
  YearsOfData$datetime <- as.POSIXct(YearsOfData$datetime)
  
  # get a list of available years of data
  # stubbing this out for now until navy.mil stabilizes their naming conventions
  availableYearsOfData <- c("2011","2012","2013","2014")
  
  # create a list of functions for this object
  me <- list (
    # define the environment where this list is defined for later reference
    thisEnv = thisEnv,
    
    getEnv = function() return(get("thisEnv",thisEnv)),
    
    yearsOfData = function() {
      return(get("YearsOfData",thisEnv))
    },
    
    loadAYearOfData = function(theYear) {
      dataPathName <- paste0(kPORDeepMoorPath,"DM/Environmental_Data_Deep_Moor_",theYear,".txt")
      thisyearofdata <- read.delim(dataPathName, stringsAsFactors=FALSE)
      names(thisyearofdata)[1] <- "datetime"
      thisyearofdata$datetime <- ymd_hms(thisyearofdata$datetime)
      cumulativeyearsofdata <- rbind(YearsOfData,thisyearofdata)
      return(assign("YearsOfData",cumulativeyearsofdata,thisEnv))
    },
    
    listAvailableYears = function() {
      return(get("availableYearsOfData",thisEnv))
    }
    
  )
  
  # set the name of the class
  class(me) <- append(class(me),"LakePendOreilleData")
  return(me)
  
  
}

