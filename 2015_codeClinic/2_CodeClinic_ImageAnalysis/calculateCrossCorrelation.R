# demonstration of cross correlation

# set up dataX - we'll keep reusing this vector
dataX <- 1:10

# cross correlation for different values of dataY
dataY <- dataX # 100% cross correlation
dataY <- rnorm(10)*10 # not 100% correlation
dataY <- rev(dataX) # reverse the values in dataX

# show dataX and dataY side-by-side
data.frame(dataX,dataY)

# show a plot
plot(dataX,type="l",col="red")
lines(dataY,col="blue")

# calculate the cross-correlation
ccf(dataX,dataY)

# plot showing lag of 2 between dataX and dataY

dataYLag2 <- c(dataY[3:10],dataY[1:2]) # first, build a lag of dataY
data.frame(dataX,dataY,dataYLag2)      # show the values
plot(dataX,type="l",col="red")         # plot the values
lines(dataYLag2,col="blue")
ccf(dataX,dataYLag2)                   # cross-correlate
