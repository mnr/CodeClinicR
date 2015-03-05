# setup for plotting 8 queens

# set up for plotting
install.packages("jpeg")
library(jpeg)
install.packages("png")
library(png )

chessboardImage <- readJPEG("images/chessboard.jpg")
queenImage <- readPNG("images/queen_image.png")

chessbrd.width <- ncol(chessboardImage)
chessbrd.height <- nrow(chessboardImage)
oneSquare.width <- chessbrd.width/10.2
oneSquare.height <- chessbrd.height/10.25

# graphic version of plotter
plotARowOfQueens <- function(theRow) {
  # theRow is a vector 8 positions wide
  theTitle <- ""
  for (index in 1:8) theTitle <- paste(theTitle,theRow[index],sep="     ")
  par(pty="s") # this plot is square
  plot(c(0, chessbrd.width), c(0, chessbrd.height), type = "n", main=theTitle,
       xlab="Columns",ylab="Rows",)
  rasterImage(chessboardImage, 0, 0, chessbrd.width, chessbrd.height)
  for(queenPos in 1:8) {
    queenXPos <- queenPos * (oneSquare.width)
    queenYPos <- (theRow[queenPos] * (oneSquare.height)) + 3
    rasterImage(queenImage,queenXPos,queenYPos,queenXPos+oneSquare.width,queenYPos+oneSquare.height)
  }
}
