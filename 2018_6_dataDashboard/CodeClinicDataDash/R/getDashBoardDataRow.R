# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil

#' Return a row from data table based on current time.
#'
#' Assumes the presence of dashBoardData
#'
#' @param howManyRows Number of rows to return. These rows represente earlier observations.
#' If the number of rows requested are less than the number of seconds from midnight, return will
#' be only from the first row - and probably less than the number requested. Be sure
#' to check the number of rows returned - it may be less than you asked for.
#'
#' @return A row of data from dashBoardData
#' @examples
#' getDashBoardDataRow()


getDashBoardDataRow <- function(howManyRows = 1) {

  time_date_posixct <- as.POSIXct(trunc(Sys.time(), units = "days"))
  time_now_posixct <- Sys.time()
  time_secSinceMidnight_difftime <- difftime(time_now_posixct, time_date_posixct, units = "secs")
  secondsSinceMidnight <- trunc(as.numeric(time_secSinceMidnight_difftime))

  previousSeconds <- ifelse(secondsSinceMidnight > howManyRows,
                            secondsSinceMidnight - howManyRows + 1,
                            1)

  return( dashBoardData[ previousSeconds:secondsSinceMidnight, ] )

}
