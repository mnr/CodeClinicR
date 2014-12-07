# http://cran.r-project.org/web/packages/ripa/index.html
install.packages("ripa")
library(ripa)


source("http://bioconductor.org/biocLite.R")
biocLite("EBImage")
browseVignettes("EBImage")
library("EBImage")
f = system.file("images", "sample.png", package="EBImage")
img = readImage(f)

install("jpeg")
img <- readJPEG(system.file("img", "Rlogo.jpg", package="jpeg"))
#match()

if (exists("rasterImage")) { # can plot only in R 2.11.0 and higher
  plot(2:2, type='n')
  rasterImage(img, 1.2, 1.27, 1.8, 1.73)
  #rasterImage(img.n, 1.5, 1.5, 1.9, 1.8)
}

