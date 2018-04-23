# attribution -------------------------------------------------------------

# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 2. Where Am I



# setup -------------------------------------------------------------------


# create a geolocation app 
# to show the location of the computer running their code. 
# Their solution should reveal the longitude and latitude of the current location, 
# as well as an indicator of how accurate that location is, 
# expressed as a radius from the revealed longitude and latitude measured in kilometers. 

# install.packages("rjson")
# install.packages("mapdata")

library(rjson)
library(maps)
library(mapdata)

# get Geolocation -------------------------------------------------------------

myIPaddress <- readLines("http://ipv4bot.whatismyipaddress.com/", warn = FALSE)
getGeoString <- paste0("https://ipinfo.io/", myIPaddress,"/json")
myLocation <- fromJSON(file = getGeoString)
latlong <- strsplit(myLocation$loc, ",")
myLongitude <- as.numeric(latlong[[1]][2])
myLatitude <- as.numeric(unlist(latlong)[1])


# map the location --------------------------------------------------------

maprange = 5

map("worldHires", 
    xlim = c(myLongitude-maprange, myLongitude+maprange),
    ylim = c(myLatitude-maprange, myLatitude+maprange),
    col = "gray80", fill = TRUE,
    mar = c(1.1, 1.1, par("mar")[3], 2))
points(myLongitude, myLatitude, col="red", pch = 8, cex = 1)
title(paste(myLocation$city, ", ", myLocation$region, " - ", myLocation$country))
map.cities( label = TRUE, minpop = 500000)


