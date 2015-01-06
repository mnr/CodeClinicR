# testing plotting functions

plotThisJpeg <- haystack.raster
ptj.width <- ncol(plotThisJpeg)
ptj.height <- nrow(plotThisJpeg)
plotThisClip <- needle.raster
ptjc.width <- ncol(plotThisClip)
ptjc.height <- nrow(plotThisClip)

plot(c(0, ptj.width), c(0, ptj.height), type = "n")
# plot(plotThisJpeg,useRaster=TRUE)
# plot(plotThisClip,add=TRUE,useRaster=TRUE)
rasterImage(plotThisJpeg, 0, 0, ptj.width, ptj.height)

rasterImage(plotThisClip, 500, 500, ptjc.width, ptjc.height)
this <- arrayInd(points.of.interest[1000],dim(haystack.raster))
xleft <- this[2]
ybottom <- this[1]
rect(xleft,ybottom,(ptjc.width+xleft),(ptjc.height+ybottom))
