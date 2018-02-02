# set up for test

install.packages("jpeg")
library(jpeg)

setwd("2_CodeClinic_ImageAnalysis")
source("isthisacroppedversionofthat.R")

funcWrapper <- function(anImagePair) {
  needle <- paste("imagesToAnalyze/",anImagePair[1],sep="")
  haystack <- paste("imagesToAnalyze/",anImagePair[2],sep="")
  is.it.a.match <- isthisacroppedversionofthat(needle,haystack)
  if (is.it.a.match[1] > 0) {
    print(paste(anImagePair[1],"is a subset of",anImagePair[2],"with correlation of",is.it.a.match[1],"and at point",is.it.a.match[2]))
  } else {
    print(paste(anImagePair[1],"is not a subset of",anImagePair[2]))
  }
}

# test the function
list.of.images <- list.files("imagesToAnalyze")
image.pairs <- expand.grid(list.of.images,list.of.images)
apply(image.pairs,1,funcWrapper)


# test known subsets
funcWrapper(c("460249177a.jpg","460249177.jpg")) #this is a subset
funcWrapper(c("478946583a.jpg","478946583.jpg")) #this is a subset
funcWrapper(c("78771293a.jpg","78771293.jpg")) #this is a subset
funcWrapper(c("103992931.jpg","78771293.jpg")) #this is not a subset
funcWrapper(c("168680522.jpg","103992931.jpg")) #this is not a subset
