# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil

#' plot pulsometer against engine efficiency
#'
#' @param howManyToPlot how many points to plot. Default 10
#'
#' @return a plot with splines
#'
#' @examples
#' plot_pulseToengine()

plot_pulseToengine <- function(howManyToPlot = 10) {
  maybe_ten_rows <- getDashBoardDataRow(howManyToPlot)
  timeStamp_num <- maybe_ten_rows$time_stamp
  timeStamp_str <- strftime(maybe_ten_rows$time_stamp, format = "%H:%M:%S")
  engineEff <- maybe_ten_rows$Engine_efficiency
  pulseMeter <- maybe_ten_rows$Pulsometer_readout
  redVal <- maybe_ten_rows$red_Value
  blueVal <- maybe_ten_rows$blue_Value
  greenVal  <- maybe_ten_rows$green_Value

  plot(timeStamp_num, engineEff,
       ylim = c(70, 90))

  symbols(timeStamp_num, engineEff,
          xlab = "Time",
          ylab = "Engine Efficiency",
          inches = pulseMeter/255,
          circles = pulseMeter,
          bg = rgb(redVal/255, blueVal/255, greenVal/255),
          xaxt = "n"
          )
  lines(spline(timeStamp_num, engineEff, method = 'natural', n = 100))
  axis(1,at = timeStamp_num, labels = timeStamp_str)

  }
