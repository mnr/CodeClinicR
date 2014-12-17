# set up for test

install.packages("jpeg")
library(jpeg)

setwd("2_CodeClinic_ImageAnalysis")
source("isthisacroppedversionofthat.R")

# test the function
list.of.images <- list.files("imagesToAnalyze")
image.pairs <- expand.grid(list.of.images,list.of.images)
funcWrapper <- function(anImagePair) {
  needle <- paste("imagesToAnalyze/",anImagePair[1],sep="")
  haystack <- paste("imagesToAnalyze/",anImagePair[2],sep="")
  isthisacroppedversionofthat(needle,haystack)
}
apply(image.pairs,1,funcWrapper)
