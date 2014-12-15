# http://cran.r-project.org/web/packages/ripa/index.html
install.packages("ripa")
library(ripa)

<<<<<<< HEAD
# EBImage
=======
# try grepraw


>>>>>>> c2670a1cf46d4e3816d27d16dab20663a8fa8f81
source("http://bioconductor.org/biocLite.R")
biocLite("EBImage")
browseVignettes("EBImage")
library("EBImage")
f = system.file("images", "sample.png", package="EBImage")
img = readImage(f)

# grep, grepRaw, grepl
install.packages("jpeg")
library(jpeg)
img.one <- readJPEG("2_CodeClinic_imageAnalysis/imagesToAnalyze/460249177.jpg")
img.one.subset <- readJPEG("2_CodeClinic_imageAnalysis/imagesToAnalyze/460249177a.jpg")
grepl(img.one.subset[,,1], img.one[,,1], useBytes=TRUE)
grepRaw(as.vector(img.one.subset[,,1]), as.vector(img.one[,,1]), value=FALSE)
                
# Warning message:
# In grepl(img.one.subset[, , 1], img.one[, , 1], useBytes = TRUE) :
#  argument 'pattern' has length > 1 and only the first element will be used

# package Raster
#http://cran.r-project.org/web/packages/raster/index.html

# package rimage
install.packages("rimage")
# Warning in install.packages : package ‘rimage’ is not available (for R version 3.1.2)

