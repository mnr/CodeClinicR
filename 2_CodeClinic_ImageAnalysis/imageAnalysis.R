# http://cran.r-project.org/web/packages/ripa/index.html
install.packages("ripa")
library(ripa)

# # # # # #
# EBImage
=======
source("http://bioconductor.org/biocLite.R")
biocLite("EBImage")
install.packages("tiff") #package ‘tiff’ is not available (for R version 3.1.2)
library("EBImage")
# Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) : 
# there is no package called ‘tiff’
# Error: package or namespace load failed for ‘EBImage’
browseVignettes("EBImage")
f = system.file("images", "sample.png", package="EBImage")
img = readImage(f)

# # # # # #
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

# # # # # #
# package Raster
#http://cran.r-project.org/web/packages/raster/index.html

# # # # # #
# package rimage
install.packages("rimage")
# Warning in install.packages : package ‘rimage’ is not available (for R version 3.1.2)

