
# remarks -----------------------------------------------------------------


# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 4. Theremin

# https://stat.ethz.ch/R-manual/R-devel/library/tcltk/html/tcltk-package.html

# setup -------------------------------------------------------------------


# install.packages("tcltk")
# install.packages("sonify")

library(tcltk)
library(sonify)

# initialize tcl/tk -------------------------------------------------------


mouseCapture <- data.frame(xMouse = numeric(0), 
                           yMouse = numeric(0))
startMoveTime <- NULL

handleMouse <- function(x, y) {
  # <B1-Motion>
  
  if (is.null(startMoveTime)) {
    startMoveTime <<- Sys.time()
  }
  # cache the mouse location
  localMC <- mouseCapture
  newDF <- data.frame(xMouse = as.numeric(x), 
                      yMouse = as.numeric(y))
  mouseCapture <<- rbind(localMC, newDF)
}

# play sound --------------------------------------------------------------


playSound <- function() {
  #<ButtonRelease-1>
  moveTime <- as.numeric(Sys.time() - startMoveTime)
  
  # invert the y axis so pitch goes "up"
  mouseCapture <<- mouseCapture[nrow(mouseCapture):1,]
  
  # convert the data to sound
  sonify(mouseCapture$yMouse, 
         duration = moveTime,
         pulse_amp = mouseCapture$xMouse/255 )

}

# start the theremin ------------------------------------------------------


runTheremin <- function() {
  # reset the counters
  mouseCapture <<- data.frame(xMouse = numeric(0), 
                             yMouse = numeric(0))
  startMoveTime <<- NULL
  
  # set up tkinter
  tt <- tktoplevel()
  tkbind(tt,"<B1-Motion>", handleMouse )
  tkbind(tt,"<ButtonRelease-1>", playSound )
  tkfocus(tt)
  
}

runTheremin()


