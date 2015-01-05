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
      && (needle.width >= ncol(haystack.raster))) return(c(0,0)) 
  
  # find the first byte of needle in haystack
  points.of.interest <- which(haystack.raster == needle.raster[1])
  # if there are no instances of the first byte of needle in haystack, 
  # then this can't be a cropped version
  if (length(points.of.interest) == 0) return(c(0,0))
  
  # quick and dirty matching to filter down possible matches
  for (loopIndex in 1:2) {
    next.point.of.interest <- which(haystack.raster[points.of.interest + loopIndex] == needle.raster[loopIndex + 1])
    points.of.interest <- points.of.interest[next.point.of.interest]
    if (length(points.of.interest) == 0) return(c(0,0))
  }
  
  # find dim (aka:row-column-layer) of index points in points.of.interest
  location.of.POIs <- arrayInd(points.of.interest,dim(haystack.raster))
  
  # remove points.of.interest that are not wide enough to hold the sub image
  points.of.interest <- points.of.interest[location.of.POIs[,2] < needle.width]
  
  # remove points.of.interest that are not tall enough to hold the sub image
  points.of.interest <- points.of.interest[location.of.POIs[,1] < needle.height] 
  points.of.interest <- na.omit(points.of.interest) #I may be subsetting incorrectly, so use this to remove NA
  
  if (length(points.of.interest) == 0) return(c(0,0))
  
  # now points.of.interest are interesting. But are they subsets?
  # Compare the first row of needle against the rows associated with points.of.interest
  # first - subset the first row and Red layer of needle to speed things up
  needle.first.row <- needle.raster[1,,1]
    
  # then correlate with the row following points of interest
  loopCount <- 1
  loopLength <- length(points.of.interest)
  for (a.point.of.interest in points.of.interest) {
   # print(paste("analyzing ",a.point.of.interest," loop",loopCount,"of",loopLength))
    loopCount <- loopCount + 1
    row.end <- a.point.of.interest+needle.width
    correlated.images <- ccf(haystack.raster[a.point.of.interest:row.end],needle.first.row)

    if (any(correlated.images$acf > .7)) {

      # it's a hit. check for the remaining values
      return(c(max(correlated.images$acf),a.point.of.interest))
      # build an image brick of size needle, using data from haystack
      
    } else {
      #print(paste("max correlated is",max(correlated.images$acf)))
    }
  }

  return(FALSE)
}