
# Remarks -----------------------------------------------------------------


# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 5. facial recognition

# tutorial - https://docs.microsoft.com/en-us/azure/cognitive-services/face/face-api-how-to-topics/howtodetectfacesinimage
# get a subscription key - https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/vision-api-how-to-topics/howtosubscribe
# https://azure.microsoft.com/en-us/try/cognitive-services/my-apis/


# setup -------------------------------------------------------------------


# install.packages("rjson")
# install.packages("httr")
# install.packages("imager")

library(rjson)
library(httr)
library(imager)

# Web API -----------------------------------------------------------------


recognizeFaces <- function(imageWithFaces) {
  # imageWithFaces is a URL to a jpeg, gif or png
  
  endpoint <- "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect"
  FaceRecogURL <- "?returnFaceId=true&returnFaceRectangle=true"
  
  theURLtoSend <- paste0(endpoint,FaceRecogURL)
  theBodytoSend <- paste0('{"url": "',imageWithFaces,'"}')
  
  # get a subscription key - https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/vision-api-how-to-topics/howtosubscribe
  apiKey <- "put your subscription key here"
  
  thePostResults <- POST(theURLtoSend, 
       add_headers( "Ocp-Apim-Subscription-Key" = apiKey ),
       body = theBodytoSend,
       encode = "json"
       )
  thePRfromJSON <- fromJSON(content(thePostResults, "text"))


  # display image with boxes
  storeImageHere <- file.path(getwd(),"tempfacefile")
  download.file(imageWithFaces, storeImageHere, mode='wb')
  hereIsImage <- load.image(storeImageHere)
  
  facesWithBoxes <- file.path(getwd(), "facesWithBoxes.png")
  
  # save plot to disk file
  png(filename = facesWithBoxes)
  plot(hereIsImage)
  for (eachface in 1:length(thePRfromJSON)) {
    theRect <- thePRfromJSON[[eachface]]$faceRectangle
    rect(xleft = theRect$left, 
         ybottom = theRect$top + theRect$height,
         xright = theRect$left + theRect$width,
         ytop = theRect$top
         )
  }
  dev.off()
  

  # return face count
  results <- list(countfaces = length(thePRfromJSON), 
                  imageLocation = facesWithBoxes)
  write(toJSON(results), file = "faceData.json")
}

recognizeFaces("https://www.nasa.gov/sites/default/files/iss038-s-002.jpg")

