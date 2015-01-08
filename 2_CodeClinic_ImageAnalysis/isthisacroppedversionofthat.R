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
    
  # points.of.interest is an array of x,y coordinates that are possible starting points for a subset image
  red.layer <- 1 # We're only interested in one layer
  poi.rows <- nrow(haystack.raster) - needle.height # only POIs that allow full height of needle
  poi.columns <- ncol(haystack.raster) - needle.width # only POIs that allow full width of needle
  points.of.interest <- haystack.raster[1:poi.rows,1:poi.columns,red.layer] 
      
  # now points.of.interest are interesting. But are they subsets?
  
  # Compare a brick from needle against points.of.interest in haystack
  # first - subset an image brick from the Red layer of needle
  #needle.quarter.width <- ncol(needle.raster) / 4
  #needle.quarter.height <- nrow(needle.raster) / 4
  #needle.brick <- needle.raster[1:needle.quarter.height,1:needle.quarter.width,1]

  # correlate needle to haystack at the points of interest
  stepDistance <- needle.width
  for (aPOI in seq(from=1,to=length(points.of.interest),by=stepDistance)) {
    locn <- arrayInd(aPOI,dim(points.of.interest))
    aPOI.height <- locn[1] + needle.height 
    aPOI.width <- locn[2] + needle.width
    haystack.brick <- haystack.raster[locn[1]:aPOI.height,locn[2]:aPOI.width,red.layer] 
    plotTitle <- paste("Point",aPOI,date())
    correlation.result <- ccf(as.vector(haystack.brick),as.vector(needle.raster),lag.max=(stepDistance/2),main=plotTitle,ylim=c(-1,1))
    dev.copy(png,paste("needle_raster_",aPOI,".png",sep=""))
    dev.off()
    #if (any(correlation.result$acf > .7)) {

      # it's a hit. check for the remaining values
      #return(c(max(correlation.result$acf),aPOI))
      
   # } else {
     # print(paste("max correlated is",max(correlation.result$acf)," Row:",locn[1],"Col:",locn[2]))
   # }
  }

  return(FALSE)
}
