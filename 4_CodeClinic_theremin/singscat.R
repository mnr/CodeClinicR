# macintosh speech documentation at https://developer.apple.com/library/mac/documentation/userexperience/conceptual/SpeechSynthesisProgrammingGuide/FineTuning/FineTuning.html#//apple_ref/doc/uid/TP40004365-CH5-SW4

SingScat <- function() {
  #for (thePitch in 34:80) {
  #  print(thePitch)
  #  system(paste("say [[pbas ", thePitch, "]]bah"))
  #}
  for(theVolume in 0:9) {
    print(theVolume)
    system(paste("say [[volm .", theVolume, "]]bah",sep=""))
  }
}

