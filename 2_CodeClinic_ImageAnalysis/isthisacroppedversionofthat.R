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
  
  points.of.interest <- ncol(haystack.raster) * nrow(haystack.raster) # number of pixels in one layer
  wide.enough <- which(arrayInd(points.of.interest,dim(haystack.raster))[,2] < needle.width)
  tall.enough <- which(arrayInd(wide.enough,dim(haystack.raster))[,1] < needle.height)

  
    
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