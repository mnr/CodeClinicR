# Code Clinic - build the web
# using Shiny - shiny.rstudio.com

install.packages("shiny")
library(shiny)

# is this the correct home directory?
getwd()

# create a home directory
makeDirectoryHere <- "demonstrationFolder"
dir.create(makeDirectoryHere)

# copy ui.R and server.R
fileList <- list.files("shiny_setup/",full.names=TRUE)
file.copy(fileList,to=makeDirectoryHere)

# create folder "www"
dir.create(paste0(makeDirectoryHere,"/www"))
# copy "index.html" in the "www" folder
wwwfileList <- list.files("shiny_setup/www",full.names=TRUE)
file.copy(wwwfileList,to=paste0(makeDirectoryHere,"/www"))

# prep for shiny.io
# shiny.rstudio.com/articles/shinyapps.html
install.packages("devtools")
devtools::install_github("rstudio/shinyapps")
library(shinyapps)
# set up an account at shinyapps. 
# use shinyapps::setAccountInfo
library(shiny)
setwd("something") # change this to the directory of the shiny application you've built
runApp()
deployApp() # or press the deploy button on the RStudio browser window
