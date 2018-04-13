# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 1. Weather

# import necessary libraries ----
list.of.packages <- c("sqldf", "magrittr")
new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages, quiet = TRUE)

library(sqldf, quietly = TRUE)
library(magrittr, quietly = TRUE)

# retrieve the data set ------------
lpoRawData <- "Environmental_Data_Deep_Moor_2015.txt" # this is a local subset for development purposes

# get the date and time
startDateTime <-
  readline(prompt = "Start date and time? (YYYY-MM-DD HH:MM:SS) " ) %>%
  strptime(format = "%Y-%m-%d %H:%M:%S") %>%
  format("%Y_%m_%d %H:%M:%S")
  
endDateTime <-
  readline(prompt = "End date and time? (YYYY-MM-DD HH:MM:SS) ") %>%
  strptime(format = "%Y-%m-%d %H:%M:%S") %>%
  format("%Y_%m_%d %H:%M:%S")


# Challenge: Write a function that
# ... accepts a beginning date and time
# ... and an ending date and time
# ... inclusive of those dates and times,
# ... return the coefficient of the slope of barometric pressure.
lpoBaroPressure <- function(startDateTime, endDateTime) {
  doThisSQL <- sprintf(
    'SELECT "date.......time", Barometric_Press
    FROM file
    WHERE `date.......time` >= "%s"
    AND `date.......time` <= "%s"
    ',
    startDateTime,
    endDateTime 
  )
  
  lpo_weather_data <- read.csv.sql(lpoRawData,
                                   doThisSQL,
                                   sep = "\t")
  lmTerms <- 1:nrow(lpo_weather_data)
  BP_linearModel <- lm(Barometric_Press ~ lmTerms,
                       data = lpo_weather_data)
  coef(BP_linearModel)
  
  # generate a graph of the results
  putFileHere <- make.names(c("barPressure_", beginDateTime, endDateTime, ".jpg"))
  jpeg(putFileHere)
  plot(BP_linearModel)
  dev.off()
}

lpoBaroPressure(startDateTime, endDateTime)
