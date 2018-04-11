# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: create the data table used for code clinic dash board

createDataTable <- function() {

  time_stamp <- seq(
    from = ISOdatetime(2018, 1, 1, 0, 0, 0),
    to = ISOdatetime(2018, 1, 2, 0, 0, 0),
    by = "sec"
  )
  numOfObservations <- length(time_stamp)

  topOfSawTooth <- 256

  redval_once <- abs(sin(seq(0, 10, .1)) * 255)
  redval <- rep_len(redval_once, length.out = numOfObservations)

  blueval <- rnorm(numOfObservations, mean = 128, sd = 2)

  greenval <- (blueval + redval)
  greenval_adjusted <- greenval - min(greenval)
  greenval_range <- max(greenval) - min(greenval)
  greenval_step <- 255 / greenval_range
  greenval_scoped <- greenval_adjusted * greenval_step

  dashBoardData <- data.frame(time_stamp) %>%
    mutate(Pulsometer_readout = rep_len(1:topOfSawTooth, numOfObservations)) %>%
    mutate(Engine_efficiency = rnorm(numOfObservations, mean = 80, sd = 4)) %>%
    mutate(red_Value = as.integer(rep_len(redval, numOfObservations))) %>%
    mutate(blue_Value = as.integer(blueval)) %>%
    mutate(green_Value = as.integer(greenval_scoped))

  return(dashBoardData)
  # write_csv(dashBoardData, "dashBoardData.csv")
}
