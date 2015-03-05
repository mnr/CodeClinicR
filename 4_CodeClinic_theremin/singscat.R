# macintosh speech documentation at https://developer.apple.com/library/mac/documentation/userexperience/conceptual/SpeechSynthesisProgrammingGuide/FineTuning/FineTuning.html#//apple_ref/doc/uid/TP40004365-CH5-SW4

SingScat <- function() {
  #for (thePitch in 34:80) {
  #  print(thePitch)
  #  system(paste("say [[pbas ", thePitch, "]]bah"))
  #}
  # for(theVolume in 0:9) {
  #   print(theVolume)
  #  system(paste("say [[volm .", theVolume, "]]bah",sep=""))
  #}
  
  for(theVolume in 5:9){
    for(thePitch in 34:80){
      volm.string <- paste("[[volm .", theVolume, "]]",sep="")
      pbas.string <- paste("[[pbas ", thePitch, "]]",sep="")
      #all.string <- paste("say ",volm.string,pbas.string,"bah")
      all.string <- paste("say -v Good",volm.string,pbas.string,"o")
      print(all.string)
      system(all.string)
    }
  }
  print("I'm done")
}

