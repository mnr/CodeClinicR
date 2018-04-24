# remarks -----------------------------------------------------------------

# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 6. data dashboard

# setup -------------------------------------------------------------------

# install.packages("shiny")

library(shiny)

# shiny ui ----------------------------------------------------------------


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Code Clinic Problem 6 - Data Dashboard"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("DataPoints",
                   "Number of Data Points:",
                   min = 1,
                   max = 50,
                   value = 10),
       tableOutput("dataTableRow")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("dataPlot")
       
    )
  )
))
