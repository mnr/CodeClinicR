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
    
  output$dataTableRow <- renderTable({
    autoInvalidate()
    reshapeRow <- getDashBoardDataRow()
    valueNames <- names(reshapeRow)
    reshapeRow <- t(reshapeRow)
    reshapeRow <- cbind(data.frame(Name = valueNames), reshapeRow)
    colnames(reshapeRow) <- c("Name", "Value")
    return(reshapeRow)
  })
  
  output$dataPlot <- renderPlot({
    autoInvalidate()
    plot_pulseToengine(input$DataPoints)
  })
  
})
