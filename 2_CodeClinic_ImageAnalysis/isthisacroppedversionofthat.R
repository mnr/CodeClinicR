# function to test if one image is a cropped version of another
# needle - image that might be a cropped version
# haystack - image that might be a parent version
# returns TRUE or FALSE

isthisacroppedversionofthat <- function(needle,haystack) {
  # assumes needle and haystack are jpeg images
  needle.raster <- readJPEG(needle)
  haystack.raster <- readJPEG(haystack)
 
  # if needle is larger than or same size as haystack, 
  # then needle can't be a cropped version.
  if ((nrow(needle.raster) >= nrow(haystack.raster)) 
      && (ncol(needle.raster) >= ncol(haystack.raster))) { return(FALSE)}
  
  # find the first byte of needle in haystack
  points.of.interest <- which(haystack.raster == needle.raster[1])
  # if there are no instances of the first byte of needle in haystack, 
  # then this can't be a cropped version
  if (length(points.of.interest) == 0) {return(FALSE)}
  
  # find dim (aka:row-column-layer) of index points in points.of.interest
  location.of.POIs <- arrayInd(points.of.interest,dim(haystack.raster))
  
  # remove points.of.interest that are not wide enough to hold the sub image
  points.of.interest <- points.of.interest[location.of.POIs[,2] < ncol(needle.raster)]
  
  # remove points.of.interest that are not tall enough to hold the sub image
  points.of.interest <- points.of.interest[location.of.POIs[,1] < nrow(needle.raster)] 
  
  if (length(points.of.interest) == 0) {return(FALSE)}
  
  # now points.of.interest are interesting. But are they subsets?
  # Compare the first row of needle against the rows associated with points.of.interest
  needle.first.row.hash <- digest(needle.raster,algo="murmur32",length=ncol(needle.raster),seed=1)
  
  #sapply? apply? tapply?
  
  return(TRUE)
}