# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 6. data dashboard

library(shiny)
library(CodeClinicDataDash)

shinyServer(function(input, output, session) {
  
  autoInvalidate <- reactiveTimer(1000)
  
  output$time_stamp <- renderText({
    autoInvalidate()
    return(strftime(getDashBoardDataRow()$time_stamp, format = "%H-%M-%S"))
  })
  
  output$pulsometer <- renderText({
    autoInvalidate()
    return(getDashBoardDataRow()$Pulsometer_readout)
  })
  
  output$engine <- renderText({
    autoInvalidate()
    return(getDashBoardDataRow()$Engine_efficiency)
  })
  
  output$red_Value <- renderText({
    autoInvalidate()
    return(getDashBoardDataRow()$red_Value)
  })
  
  output$blue_Value <- renderText({
    autoInvalidate()
    return(getDashBoardDataRow()$blue_Value)
  })
  
  output$green_Value <- renderText({
    autoInvalidate()
    return(getDashBoardDataRow()$green_Value)
  })
})
