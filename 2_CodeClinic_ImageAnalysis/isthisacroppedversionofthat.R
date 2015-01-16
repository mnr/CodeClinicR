# function to test if one image is a cropped version of another
# needle - image that might be a cropped version
# haystack - image that might be a parent version
# returns TRUE or FALSE

isthisacroppedversionofthat <- function(needle,haystack) {
  # assumes needle and haystack are jpeg images
  needle.raster <- readJPEG(needle)
  needle.width <- ncol(needle.raster) # width and height are used a lot
  needle.height <- nrow(needle.raster)
  haystack.raster <- readJPEG(haystack)
  haystack.width <- ncol(haystack.raster)
  haystack.height <- nrow(haystack.raster)
 
  # if needle is larger than or same size as haystack, 
  # then needle can't be a cropped version.
  if ((needle.height >= haystack.height) 
      && (needle.width >= haystack.width)) return(c(0,0)) 
    
  # points.of.interest is an array of x,y coordinates that are possible starting points for a subset image
  red.layer <- 1 # We're only interested in one layer
  poi.rows <- haystack.height - needle.height # only POIs that allow full height of needle
  poi.columns <- haystack.width - needle.width # only POIs that allow full width of needle
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
    
    plot(c(0, haystack.width), c(0, haystack.height), 
         type = "n",main=paste("x=",locn[2],"y=",locn[1]))
    rasterImage(haystack.raster, 
                xleft=0, xright=haystack.width,
                ytop=haystack.height,ybottom=0)
    rasterImage(needle.raster,
                xleft=locn[2],xright=aPOI.width,
                ytop=aPOI.height,ybottom=locn[1])
    #haystack.brick <- haystack.raster[locn[1]:aPOI.height,locn[2]:aPOI.width,red.layer] 
    #plotTitle <- paste("Point",aPOI,date())
    #correlation.result <- ccf(as.vector(haystack.brick),as.vector(needle.raster),lag.max=(stepDistance/2),main=plotTitle,ylim=c(-1,1))
    
    #correlation.result <- ccf(as.vector(haystack.brick),as.vector(needle.raster),lag.max=(stepDistance/2),plot=FALSE)
    #print(paste("point:",aPOI,"Corr_max:",max(correlation.result$acf)))
    
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
