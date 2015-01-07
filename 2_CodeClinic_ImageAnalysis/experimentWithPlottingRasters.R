# testing plotting functions

plotThisJpeg <- myjpeg
ptj.width <- ncol(plotThisJpeg)
ptj.height <- nrow(plotThisJpeg)
plotThisClip <- myjpegclip
ptjc.width <- ncol(plotThisClip)
ptjc.height <- nrow(plotThisClip)

plot(c(0, ptj.width), c(0, ptj.height), type = "n")
# plot(plotThisJpeg,useRaster=TRUE)
# plot(plotThisClip,add=TRUE,useRaster=TRUE)
rasterImage(plotThisJpeg, 0, 0, ptj.width, ptj.height)

rasterImage(plotThisJpeg[1:1500,1:2500,1], 0, 0, ptj.width, ptj.height)

rasterImage(plotThisClip, 500, 500, ptjc.width, ptjc.height)

this <- arrayInd(points.of.interest[1000],dim(haystack.raster))
xleft <- this[2]
ybottom <- this[1]
rect(xleft,ybottom,(ptjc.width+xleft),(ptjc.height+ybottom))

corltHayToNeedle <- function (aPOI) {
  needle.height.offset <- needle.quarter.height + aPOI
  needle.width.offset <- needle.quarter.width + aPOI
  ccf(haystack.raster[aPOI:needle.height.offset,1:needle.width.offset,1],needle.brick)
}

applyResults <- lapply(points.of.interest,corltHayToNeedle)
