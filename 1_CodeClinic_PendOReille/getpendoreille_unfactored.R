GetPendOreille <- function(startDate,endDate) {
  # startDate and endDate are in the format YYYYMMDD
  # Uses lubridate package for assistance with dates
  # lubridate documentation at http://cran.r-project.org/web/packages/lubridate/lubridate.pdf
  
    
  # check input for validity
  the.start.date <- ymd(startDate)
  the.end.date <- ymd(endDate)
  if (the.start.date > the.end.date) {
    # Error: the end date is earlier than the start date
    stop("Invalid input: start date is after end date")
  }
  
  if (the.start.date < ymd("20010112")) {
    # Error: Lake Pend Oreille didn't record any data prior to 2001_01_12
    stop("No Data available prior to 2001")
  }
  if (the.end.date > now()) {
    # Error: input is asking for data for tomorrow
    stop("End Date is later than today")
  }
  
  # Now I'm confident the input is usable.
  # Based on the input, I'm going to grab the data I need
  por.weather.data <- data.frame(theDateTime=as.numeric(),
                                 Wind_Speed=as.numeric(),
                                 Air_Temp=as.numeric(),
                                 Barometric_Press=as.numeric()
  )
  
  # raw data for deep moor is found at http://lpo.dt.navy.mil/data/DM/
  kPORDeepMoorPath <- "https://lpo.dt.navy.mil/data/DM/"
  
  # date.pointer keeps track of what dates have been read
  date.pointer <- the.start.date 
  
  while (date.pointer <= the.end.date) {
    if (year(date.pointer) < 2010) {
      # prior to 2010, data was stored in one file per year
      file.to.read <- paste(kPORDeepMoorPath,"Environmental_Data_",year(date.pointer),".txt",sep="")
      # date,time,Wind_Speed,Air_Temp,Barometric_Press
      tmp.wd <- read.table(file.to.read,sep="\t",header=TRUE)
      
      # drop unneeded columns
      tmp.wd[c("Wind_Gust","Wind_Dir","Relative_Humidity",
               "Water_Temp","Water_Temp_50","Water_Temp_100",
               "Water_Temp_200","Water_Temp_400")] <- list(NULL)
      
      # clean up date time column
      colnames(tmp.wd)[1] <- "theDateTime" 
      
      # merge the two data.frames
      por.weather.data <- rbind(por.weather.data,tmp.wd)
      
    } else {
      # after and including 2010, data is stored in separate files in a directory
      
      # requires this external function
      if(!exists("GetPORDataFor",mode="function")) source("GetPORDataFor.R")
      
      # get the three data tables and combine into creating.weather.df
      get.these.weathers <- c("Wind_Speed","Air_Temp","Barometric_Press")
      
      for(aWeather in get.these.weathers) {
        temp.weather.data <- GetPORDataFor(aWeather,date.pointer)
        temp.weather.data <- data.frame(paste(temp.weather.data$V1,temp.weather.data$V2),
                                        temp.weather.data$V3)
        colnames(temp.weather.data) <- c("theDateTime",aWeather)
        
        if(!exists("creating.weather.df")) {
          creating.weather.df <- temp.weather.data
        } else {
          creating.weather.df <- merge(creating.weather.df,temp.weather.data,by="theDateTime")
        }
      }
      
      # append creating.weather.df to por.weather.data 
      por.weather.data <- rbind(por.weather.data,creating.weather.df)
      
      # clear creating.weather.df
      rm(creating.weather.df)      
    }
    
    # increment date.pointer
    # if the.end.date < 2009 then it is ok to increment by a year
    # else, increment by a day
    
    if (year(the.end.date) < 2009) {
      year(date.pointer) <- year(date.pointer) + 1
    } else {
      # set the date pointer to do the next day
      date.pointer <- date.pointer + days(1)
    }
    
  }
  
  # in some cases there will be unwanted data rows at top and/or bottom. 
  # Need to trim them out
  por.weather.data <- por.weather.data[as.POSIXlt(ymd_hms(por.weather.data$theDateTime)) >= the.start.date,]
  por.weather.data <- por.weather.data[as.POSIXlt(ymd_hms(por.weather.data$theDateTime)) <= the.end.date,]
  
  # calculate the mean and median of the 
  # wind speed, air temperature and barometric pressure 
  # recorded at the deep moor station 
  # for a given range of dates

  Mean <- colMeans(por.weather.data[2:4], na.rm=TRUE)
  Median <- sapply(por.weather.data[2:4], median, na.rm = TRUE)
  rbind(Mean,Median)
}
