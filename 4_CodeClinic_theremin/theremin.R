require(tcltk)

handleMouse <- function(x,y) {
  #theVolume in 0:9
  #thePitch in 34:80
  
  volm.string <- paste("[[volm .", theVolume, "]]",sep="")
  pbas.string <- paste("[[pbas ", thePitch, "]]",sep="")
  all.string <- paste("say ",volm.string,pbas.string,"bah")
  print(all.string)
  system(all.string)
}

tt<-tktoplevel()
tkbind(tt,"<B1-Motion>", handleMouse )
tkfocus(tt)