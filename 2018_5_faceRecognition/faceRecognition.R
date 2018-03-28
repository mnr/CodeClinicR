# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 5. facial recognition

# First, the function should accept a jpeg, gif or png file of varying dimensions.
# Their function should then identify the number of faces in that image. 
# There may not be any faces in the image, in which case the function should return zero.
# If the author chooses to go for extra credit, their function can create 
# a copy of the image with the faces visually identified, either with a surrounding box or other method.

#The function should return a JSON file with two fields: countFaces and imageLocation
#{
#  "countFaces" : 3,
#  "imageLocation" : "file.jpg"
#}

# install.packages("rjson")

library(rjson)

# Key 1: 7a533dd6c382492daa3b83b480e85d7c
# Key 2: 50946cd489104c70b3215cc9ef70f5f0


recognizeFaces <- function(imageWithFaces) {
  
  endpoint <- "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/"
  FaceRecogURL <- "detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes={string}"
  contentType <- "Content-Type: application/json"
  apiKey <- "Ocp-Apim-Subscription-Key: <Subscription Key>"
  
  results <- list(countfaces = 3, imageLocation = "file.jpg")
  return(toJSON(results))
}

