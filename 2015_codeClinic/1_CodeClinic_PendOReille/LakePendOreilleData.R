# Lake Pend Oreille S3 class to abstract the website data from the program
# Author: Mark Niemann-Ross, Spring 2015
# uses the local environment approach
# http://cran.r-project.org/doc/manuals/r-release/R-lang.html#Argument-evaluation
# recommended reading: http://www.cyclismo.org/tutorial/R/s3Classes.html
# recommended reading: http://adv-r.had.co.nz/OO-essentials.html
# assumes presence of lubridate for date conversion

LakePendOreilleData <- function() {
  kPORDeepMoorPath <- "https://lpo.dt.navy.mil/data/"
  
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
  this.yearsOfDataAlreadyLoaded <- c("")
  
  # get a list of available years of data
  # stubbing this out for now until navy.mil stabilizes their naming conventions
  availableYearsOfData <- c("2011","2012","2013","2014","2015")
  
  buildPathToData <- function(theYear) {
    paste0(kPORDeepMoorPath,"DM/Environmental_Data_Deep_Moor_",theYear,".txt")
  }
  
  # private function to load a year of data
  this.loadAYearOfData <- function(theYear) {
    if (!is.element(theYear,this.yearsOfDataAlreadyLoaded)) {  
      this.yearsOfDataAlreadyLoaded <<- c(this.yearsOfDataAlreadyLoaded,theYear)
      dataPathName <- buildPathToData(theYear)
      thisyearofdata <- read.delim(dataPathName, stringsAsFactors=FALSE)
      names(thisyearofdata)[1] <- "datetime"
      thisyearofdata$datetime <- ymd_hms(thisyearofdata$datetime)
      # <<- is used to assign a value to a variable located in the parent environment
      YearsOfData <<- rbind(YearsOfData,thisyearofdata)
    }
    return(YearsOfData)
  }
  
  # create a list of public functions for this object
  publicFunctions <- list (
    # define the environment where this list is defined for later reference
    thisEnv = thisEnv,
    
    getEnv = function() return(get("thisEnv",thisEnv)),
    
    YearsOfData = function() {
      return(get("YearsOfData",thisEnv))
    },
    
    # this will return a range of data from the Lake POR data site
    getPORDataRange = function (the.start.date,the.end.date) {
      requestedYears <- as.character(c(year(the.start.date):year(the.end.date)))
      tmp.null <- lapply(requestedYears,this.loadAYearOfData)
      por.weather.data <- YearsOfData
      por.weather.data <- por.weather.data[por.weather.data$datetime >= the.start.date,]
      por.weather.data <- por.weather.data[por.weather.data$datetime <= (the.end.date + days(1)),]
      return(por.weather.data)
    },
    
    # This appends a year of data into YearsOfData
    loadAYearOfData = function(theYear) {
      this.loadAYearOfData(theYear)
      return(assign("YearsOfData",YearsOfData,thisEnv))
    },
    
    # this returns a list of available years
    listAvailableYears = function() {
      return(get("availableYearsOfData",thisEnv))
    }
    
  )
  
  # set the name of the class
  class(publicFunctions) <- append(class(publicFunctions),"LakePendOreilleData")
  return(publicFunctions)
  
  
}

