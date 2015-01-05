# testing plotting functions

plotThisJpeg <- myjpeg
ptj.width <- ncol(plotThisJpeg)
ptj.height <- nrow(plotThisJpeg)
plotThisClip <- myjpegclip
ptjc.width <- ncol(plotThisClip)
ptjc.height <- nrow(plotThisClip)

plot(c(100, ptj.width), c(100, ptj.height), type = "n")
# plot(plotThisJpeg,useRaster=TRUE)
# plot(plotThisClip,add=TRUE,useRaster=TRUE)
rasterImage(plotThisJpeg, 100, 100, ptj.width, ptj.height)

rasterImage(plotThisClip, 500, 500, ptjc.width, ptjc.height)
