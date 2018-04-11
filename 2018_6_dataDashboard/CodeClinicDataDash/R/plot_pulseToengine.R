# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil

#' plot pulsometer against engine efficiency
#'
#' @param pulsometer_10 a vector of 10 values from pulsometer.
#' @param engine_10 a vector of 10 values from engine efficiency.
#'
#' @return a plot
#'
#' @examples
#' plot_pulseToengine()

plot_pulseToengine <- function() {
  maybe_ten_rows <- getDashBoardDataRow(10)
  pulse_tmp <- maybe_ten_rows$Pulsometer_readout
  efficiency_tmp <- maybe_ten_rows$Engine_efficiency

  plot(pulse_tmp, efficiency_tmp)
  lines(spline(pulse_tmp, efficiency_tmp, method = 'natural', n = 100))

  title("this is a title")

  }
