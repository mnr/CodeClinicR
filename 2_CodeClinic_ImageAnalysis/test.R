# test the function

setwd("2_CodeClinic_ImageAnalysis")
source("isthisacroppedversionofthat.R")

list.of.images <- list.files("imagesToAnalyze")
image.pairs <- expand.grid(list.of.images,list.of.images)
funcWrapper <- function(anImagePair) {
  needle <- paste("imagesToAnalyze",anImagePair[1])
  haystack <- paste("imagesToAnalyze",anImagePair[2])
  isthisacroppedversionofthat(needle,haystack)
}
apply(image.pairs,1,funcWrapper)
