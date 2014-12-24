# function to test if one image is a cropped version of another
# needle - image that might be a cropped version
# haystack - image that might be a parent version
# returns TRUE or FALSE

isthisacroppedversionofthat <- function(needle,haystack) {
  # assumes needle and haystack are jpeg images
  needle.raster <- readJPEG(needle)
  haystack.raster <- readJPEG(haystack)
  needle.width <- ncol(needle.raster) # width and height are used a lot
  needle.height <- nrow(needle.raster)
 
  # if needle is larger than or same size as haystack, 
  # then needle can't be a cropped version.
  if ((needle.height >= nrow(haystack.raster)) 
      && (needle.width >= ncol(haystack.raster))) {return(FALSE) }
  
  # find the first byte of needle in haystack
  points.of.interest <- which(haystack.raster == needle.raster[1])
  # if there are no instances of the first byte of needle in haystack, 
  # then this can't be a cropped version
  if (length(points.of.interest) == 0) {return(FALSE)}
  
  # find dim (aka:row-column-layer) of index points in points.of.interest
  location.of.POIs <- arrayInd(points.of.interest,dim(haystack.raster))
  
  # remove points.of.interest that are not wide enough to hold the sub image
  points.of.interest <- points.of.interest[location.of.POIs[,2] < needle.width]
  
  # remove points.of.interest that are not tall enough to hold the sub image
  points.of.interest <- points.of.interest[location.of.POIs[,1] < needle.height] 
  points.of.interest <- na.omit(points.of.interest) #I may be subsetting incorrectly, so use this to remove NA
  
  if (length(points.of.interest) == 0) {return(FALSE)}
  
  # now points.of.interest are interesting. But are they subsets?
  # Compare the first row of needle against the rows associated with points.of.interest
  # first - hash the first row of needle
  needle.first.row.hash <- digest(needle.raster,algo="murmur32", length=needle.width, seed=1)
  
  # then hash the row following points of interest and compare results
  for (a.point.of.interest in points.of.interest) {
    haystack.first.row.hash <- digest(haystack.raster[a.point.of.interest:(a.point.of.interest+needle.width-1)],algo="murmur32",seed=1)
        
    if (haystack.first.row.hash == needle.first.row.hash) {

      # it's a hit. check for the remaining values
      needle.hash <- digest(needle.raster,algo="murmur32",seed=1)
      # build an image brick of size needle, using data from haystack
      haystack.hash <- digest(haystack.raster[a.point.of.interest:needle.width,a.point.of.interest:needle.height,], algo="murmur32", seed=1)
      if (haystack.all.hash == needle.all.hash) return (TRUE)
    }
  }

  return(FALSE)
}