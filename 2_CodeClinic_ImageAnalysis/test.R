# set up for test

install.packages("jpeg")
library(jpeg)
install.packages("digest")
library(digest)

setwd("2_CodeClinic_ImageAnalysis")
source("isthisacroppedversionofthat.R")

# test the function
list.of.images <- list.files("imagesToAnalyze")
image.pairs <- expand.grid(list.of.images,list.of.images)
funcWrapper <- function(anImagePair) {
  needle <- paste("imagesToAnalyze/",anImagePair[1],sep="")
  haystack <- paste("imagesToAnalyze/",anImagePair[2],sep="")
  is.it.a.match <- isthisacroppedversionofthat(needle,haystack)
  print(paste(anImagePair[1],ifelse(is.it.a.match,"is","is not"),"a subset of",anImagePair[2]))
}
apply(image.pairs,1,funcWrapper)
