GetPORDataFor <- function(weatherParameter,datepointer) {
  # weatherParameter is one of the POR weather files found at the deep moor site

  # raw data for deep moor is found at http://lpo.dt.navy.mil/data/DM/
  # set up the file name to access this weather data
  kPORDeepMoorPath <- "http://lpo.dt.navy.mil/data/DM/"
  kPathPartOne <- paste(year(datepointer), "/", 
                        year(datepointer),"_",
                        formatC(month(datepointer),width=2,flag="0"),"_",
                        formatC(mday(datepointer),width=2,flag="0"),"/",
                        sep="")
  
  kPathWD <- paste(kPORDeepMoorPath,kPathPartOne,weatherParameter,sep="")

  read.table(kPathWD)
  
}