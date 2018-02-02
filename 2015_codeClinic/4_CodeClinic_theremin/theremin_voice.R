require(tcltk)

kPitchRange <- 80:34 #pitch can be from 34 to 80. 
kPitchRangeLength <- length(kPitchRange)

handleMouse <- function(x,y) {
  #print(c(x,y))
  theVolume <- as.numeric(x)/100 #volume can be from .0 to .9
  # y can be from 0 to 200. 0 is at top so I've inverted the list
  thePitchIndex <- kPitchRangeLength* as.numeric(y) / 200
  thePitch <- kPitchRange[thePitchIndex]
  
  volm.string <- paste("[[volm ", theVolume, "]]",sep="")
  pbas.string <- paste("[[pbas ", thePitch, "]]",sep="")
  all.string <- paste("say -v Good",volm.string, pbas.string, "o")
  #print(all.string)
  system(all.string)
}

tt<-tktoplevel()
tkbind(tt,"<B1-Motion>", handleMouse )
tkfocus(tt)