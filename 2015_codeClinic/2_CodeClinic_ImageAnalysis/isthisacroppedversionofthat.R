# function to test if one image is a cropped version of another
# needle - image that might be a cropped version
# haystack - image that might be a parent version
# returns TRUE or FALSE

isthisacroppedversionofthat <- function(needle,haystack) {
  
  #   needle <- paste("imagesToAnalyze/","460249177a.jpg",sep="")
  #   haystack <- paste("imagesToAnalyze/","460249177.jpg",sep="")
  
  # assumes needle and haystack are jpeg images
  needle.raster <- readJPEG(needle)
  needle.width <- ncol(needle.raster) # width and height are used a lot
  needle.height <- nrow(needle.raster)
  haystack.raster <- readJPEG(haystack)
  haystack.width <- ncol(haystack.raster)
  haystack.height <- nrow(haystack.raster)
  red.layer <- 1 # We're only interested in one layer
  
  # if needle is larger than or same size as haystack, 
  # then needle can't be a cropped version.
  if ((needle.height >= haystack.height) 
      && (needle.width >= haystack.width)) return(c(0,0)) 
  
  # I'm going to assume that a match in one (of RGB) layers between
  # needle and haystack is a match between all layers. This reduces the 
  # amount of data we need to correlate by 2/3
  # This requires versions of needle and haystack with just one layer
  needle.red <- needle.raster[,,red.layer]
  haystack.red <- haystack.raster[,,red.layer]
  
  # points.of.interest is an array of x,y coordinates that are possible 
  # starting points for a subset image. Any points outside of this range
  # are either too narrow or too shallow to fit needle.
  # remember that we are talking about rows and columns of the IMAGE...
  # ...NOT the graph. Images start with 0,0 at upper left.
  # Graphs start with 0,0 in lower left
  diff.haystack.needle.height <- haystack.height-needle.height
  poi.rows <- (1:diff.haystack.needle.height)
  
  diff.haystack.needle.width <- haystack.width-needle.width
  poi.columns <- (1:diff.haystack.needle.width)
  
  xpos <<- numeric()
  ypos <<- numeric()
  ccf.max <<- numeric()
  
  
  stepSize <- 100
  for (rowIndex in seq(from=poi.rows[1],
                       to=poi.rows[length(poi.rows)],
                       by=stepSize)) {
    for (columnIndex in seq(from=poi.columns[1],
                            to=poi.columns[length(poi.columns)],
                            by=stepSize)) {
      #       if (rowIndex+needle.height < haystack.height &
      #             columnIndex+needle.width < haystack.width) {
      haystack.subset.to.be.correlated <- haystack.red[
        (rowIndex:(rowIndex+needle.height)),
        (columnIndex:(columnIndex+needle.width))
        ]
      
      ccf.object <- ccf(as.vector(haystack.subset.to.be.correlated),
                        as.vector(needle.red),
                        plot=FALSE)
      max.ccf <- max(ccf.object$acf)
      ccf.max <<- append(ccf.max,max.ccf)
      xpos <<- append(xpos,columnIndex)
      ypos <<- append(ypos,rowIndex)
      
      ###########
      # creates pretty graphics - and slows things down
      maintitle <- paste("ccf=",round(max.ccf,2),"xpos=",columnIndex,"ypos=",rowIndex)
      maintitle2 <- paste("ccf=",round(max.ccf,2))
      saveHere <- paste0("Plot",sprintf("%04d",rowIndex),sprintf("%04d",columnIndex),"_x",columnIndex,"_y",rowIndex,".png")
      
      png(filename=saveHere)
     # nf <- layout(matrix(c(1,2),1,2,byrow=T),c(1,1),c(1,1),T)
      #layout.show(nf)
      #boxplot(ccf.object$acf,ylim=c(0,1),main=maintitle2)
      plot(c(0, haystack.width), c(0, haystack.height), main=maintitle,type = "n")
      
      #         rasterImage(haystack.subset.to.be.correlated, 
      #                     xleft=0, 
      #                     xright=ncol(haystack.subset.to.be.correlated),
      #                     ytop=nrow(haystack.subset.to.be.correlated),
      #                     ybottom=0)
      rasterImage(haystack.raster, 
                  xleft=0, 
                  xright=haystack.width,
                  ytop=haystack.height,
                  ybottom=0)
      
      rasterImage(needle.red, 
                  xleft=columnIndex, 
                  xright=(needle.width+columnIndex),
                  ytop=(haystack.height-(rowIndex+needle.height)),
                  ybottom=(haystack.height-rowIndex))
      dev.off()
      ###########
      
      cat("rowIndex=",rowIndex,"columnIndex=",columnIndex,"               \r")
      #       }
    }
  }
  
  ccf.results <- matrix(c(xpos,ypos,ccf.max),ncol=3)
  colnames(ccf.results) <- c("xpos","ypos","ccf.max")
  
}
