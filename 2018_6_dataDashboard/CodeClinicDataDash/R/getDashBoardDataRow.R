# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil

#' Return a row from data table based on current time.
#'
#' Assumes the presence of dashBoardData
#'
#' @return A row of data from dashBoardData
#' @examples
#' getDashBoardDataRow()


getDashBoardDataRow <- function() {

  time_date_posixct <- as.POSIXct(trunc(Sys.time(), units = "days"))
  time_now_posixct <- Sys.time()
  time_secSinceMidnight_difftime <- difftime(time_now_posixct, time_date_posixct, units = "secs")
  secondsSinceMidnight <- trunc(as.numeric(time_secSinceMidnight_difftime))

  return( dashBoardData[ secondsSinceMidnight, ] )

}
