# a version of the theremin with tuneR

# installing tuneR
install.packages("tuneR")
library(tuneR)

kPitchRangeLength <- 200
kPitchRange <- seq(from=4000, to=300,length.out=kPitchRangeLength)

# build a list of pitches
pitches <- lapply(kPitchRange,sine)

handleMouse <- function(x,y) {
  #print(c(x,y))
  theVolume <- as.numeric(x)/100 #volume can be from .0 to .9
  theVolumeString <- paste0(" -v ",theVolume)
  
  # y can be from 0 to 200. 0 is at top so I've inverted the list of pitches
  thePitchIndex <- kPitchRangeLength* as.numeric(y) / 200
  
  # "afplay -v" is the sound player for macintosh
  # for windows, possibly one of the following...
  # "C:/Program Files/Window Media Player/wmplayer.exe"
  # powershell -c (New-Object Media.SoundPlayer "sound.wav").PlaySync();
  play(pitches[[thePitchIndex]],"afplay -v ",theVolume)
  
}

tt<-tktoplevel()
tkbind(tt,"<B1-Motion>", handleMouse )
tkfocus(tt)