# experimenting with a raster image that should register positive

install.packages("jpeg")
library(jpeg)

setwd("2_CodeClinic_ImageAnalysis")

needle.raster <- readJPEG("imagesToAnalyze/460249177a.jpg")
needle.width <- ncol(needle.raster) # width and height are used a lot
needle.height <- nrow(needle.raster)
needle.brick <- needle.raster[,,1]

haystack.raster <- readJPEG("imagesToAnalyze/460249177.jpg")
haystack.width <- ncol(haystack.raster)
haystack.height <- nrow(haystack.raster)

# discovering the row/column location where these two images match
# places needle on top of haystack
needle.x <- 1450
needle.y <- 1690

plot(c(0, haystack.width), c(0, haystack.height), 
     type = "n",main=paste("x=",needle.x,"y=",needle.y))

rasterImage(haystack.raster, 
            xleft=0, xright=haystack.width,
            ytop=haystack.height,ybottom=0)

rasterImage(needle.brick,
            xleft=needle.x,
            xright=needle.x+needle.width,
            ytop=needle.y+needle.height,
            ybottom=needle.y)


# creating and confirming a subset of haystack that matches needle
# produces a graph of images side-by-side

red.layer <- 1 # We're only interested in one layer
haystack.topImage <- haystack.height-needle.y-needle.height
haystack.brick <- haystack.raster[haystack.topImage:(needle.height+haystack.topImage),needle.x:(needle.width+needle.x),red.layer] 

plot(c(0, haystack.width), c(0, haystack.height), main=date(),type = "n")

rasterImage(haystack.brick, 
            xleft=0, 
            xright=ncol(haystack.brick),
            ytop=nrow(haystack.brick),
            ybottom=0)

rasterImage(needle.brick, 
            xleft=2000, 
            xright=(needle.width+2000),
            ytop=nrow(haystack.brick),
            ybottom=0)

# This shows a 100% correlation between two identical images
ccf(as.vector(needle.brick),as.vector(needle.brick),main=date())

# This shows the difference between two similar images
corl <- ccf(as.vector(haystack.brick),as.vector(needle.brick),main=date())
max(corl$acf) # 0.7273756

# This shows the difference between two dissimilar images
ccf(as.vector(haystack.raster),as.vector(needle.brick),main=date())
