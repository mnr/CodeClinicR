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
#' plot_pulseToengine(dashBoardData[1:10, "Pulsometer_readout"],  dashBoardData[1:10, "Engine_efficiency"])

plot_pulseToengine <- function(pulsometer_10, engine_10) {
  plot(pulsometer_10, engine_10)
}
