# remarks -----------------------------------------------------------------
# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 6. data dashboard


# setup -------------------------------------------------------------------

# install.packages("shiny")
# install.packages("Exercise Files/2018_6_dataDashboard/CodeClinicDataDash_0.1.0.tar.gz", 
#                  repos = NULL, 
#                  type = "source")

library(shiny)
library(CodeClinicDataDash)

# shiny server ------------------------------------------------------------


shinyServer(function(input, output, session) {
  
  autoInvalidate <- reactiveTimer(10)
    
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
