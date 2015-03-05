library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hello lynda!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      img(width="200",
          src="http://upload.wikimedia.org/wikipedia/en/b/b1/Official-company-logo-for-lynda.com_400x400px.png"),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
