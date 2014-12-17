# function to test if one image is a cropped version of another
# needle - image that might be a cropped version
# haystack - image that might be a parent version
# returns TRUE or FALSE

isthisacroppedversionofthat <- function(needle,haystack) {
  # print(paste("needle:",needle," haystack:",haystack))
  needle.raster <- readJPEG(needle)
  haystack.raster <- readJPEG(haystack)
  str(needle.raster)
  str(haystack.raster)
  
}