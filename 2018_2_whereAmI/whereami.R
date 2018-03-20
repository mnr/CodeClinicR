# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 2. Where Am I

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

myLocation <- fromJSON(readLines("http://freegeoip.net/json/"))

maprange = 5

map("worldHires", 
    xlim = c(myLocation$longitude-maprange, myLocation$longitude+maprange),
    ylim = c(myLocation$latitude-maprange, myLocation$latitude+maprange),
    col = "gray80", fill = TRUE,
    mar = c(1.1, 1.1, par("mar")[3], 2))
points(myLocation$longitude, myLocation$latitude, col="red", pch = 8, cex = 1)



