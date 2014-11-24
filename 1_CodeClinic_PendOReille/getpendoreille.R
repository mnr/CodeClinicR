GetPendOreille <- function(startDate,endDate) {
  # startDate and endDate are in the format YYYYMMDD
  
  # check input for validity
  the.start.date <- strptime(startDate,"%Y%m%d")
  the.end.date <- strptime(endDate,"%Y%m%d")
  if (the.start.date > the.end.date) {
    # Error: the end date is earlier than the start date
    stop("Invalid input: start date is after end date")
  }
  
  if (the.start.date < strptime("20010101","%Y%m%d")) {
    # Error: Lake Pend Oreille didn't record any data prior to 2001
    stop("No Data available prior to 2001")
  }
  if (the.end.date > as.POSIXlt(Sys.Date())) {
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
  kPORDeepMoorPath <- "http://lpo.dt.navy.mil/data/DM/"
  
  # date.pointer keeps track of what dates have been read
  date.pointer <- the.start.date 
    
  for (grab.this.year in (the.start.date$year +1900):(the.end.date$year +1900)) {
    if (grab.this.year < 2011) {
      # prior to 2011, data was stored in one file per year
      file.to.read <- paste(kPORDeepMoorPath,"Environmental_Data_",grab.this.year,".txt",sep="")
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
      
      # increment date.pointer
      date.pointer$year <- grab.this.year + 1
      
    } else {
      # after 2010, data is stored in separate files in a directory

      while (date.pointer <= the.end.date ) {
        while (grab.this.day) {
          
        }
      }
     # /2011/2011_01_02/Wind_Speed
     # file.to.read <- paste(kPORDeepMoorPath,grab.this.year,"/",grab.this.year,"_",,".txt",sep="")
      
    }
  }
  
  
  # return
  # calculate the mean and median of the 
  # wind speed, air temperature and barometric pressure 
  # recorded at the deep moor station 
  # for a given range of dates
}
