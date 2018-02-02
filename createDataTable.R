# create the data table used for code clinic dash board

dataTimeStamp <- seq(from = ISOdatetime(2018,1,1,0,0,0), to=ISOdatetime(2018,1,2,0,0,0), by="sec")

topOfSawTooth <- 256
sawtooth.tmp <- rep(1:topOfSawTooth,(length(dataTimeStamp)/topOfSawTooth)+2)
cyberneticHeartbeat <- sawtooth.tmp[1:length(dataTimeStamp)]
cyberHeartBeatDescription <- "Pulsometer readout."

warpCoreEfficiency <- rnorm(length(dataTimeStamp),mean=80,sd=4)
warpCoreEfficiencyDescription <- "Engine efficiency."

# library(geosphere)
# 
# # Starting longitude and latitude:
# coords <- c(-71, 42)
# 
# # Distance in meters:
# distance <- 5000
# 
# ne.coords <- c(destPoint(p = coords, b = 90, d = distance)[1],
#                destPoint(p = coords, b = 0,  d = distance)[2])
# 
# sw.coords <- c(destPoint(p = coords, b = 90, d = -distance)[1],
#                destPoint(p = coords, b = 0,  d = -distance)[2])
# 
# This gives:
#   
#   R> ne.coords
# [1] -70.93965  42.04502
# R> sw.coords
# [1] -71.06035  41.95498


dashBoardData <- data.frame(dataTimeStamp,cyberneticHeartbeat,warpCoreEfficiency)
dashBoardData <- rbind(c(NA,cyberHeartBeatDescription,warpCoreEfficiencyDescription),dashBoardData)


