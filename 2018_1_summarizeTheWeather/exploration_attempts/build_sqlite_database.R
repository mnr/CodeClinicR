# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 1. build an SQLite collection of weather data

# Libraries ---------------------------------------------------------------
library(DBI)
library(RSQLite)


# create the SQLite database ----------------------------------------------
putSQLiteHere <- "myRsqlite.sqlite" # could also be ":memory:"
mySQLiteDB <- dbConnect(RSQLite::SQLite(),putSQLiteHere)

# grab the weather data from github/lyndadotcom/LPO_weatherdata -----------
mytempfile <- tempfile()

for (dataYear in 2012:2015) {
  dataPath <- paste0("https://raw.githubusercontent.com/lyndadotcom/LPO_weatherdata/master/Environmental_Data_Deep_Moor_",
                     dataYear,
                     ".txt")
  mytempfile <- read.csv(dataPath)
  dbWriteTable(conn = mySQLiteDB, name = "LPO_weather_data", value = mytempfile, append = TRUE)
}

dbDisconnect(mySQLiteDB)
