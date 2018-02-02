# system.time demonstration

testit <- function(x)
{
  pb <- txtProgressBar(min=0,max=x,style=3)
  for(i in 1:x) {
    Sys.sleep(1)
    setTxtProgressBar(pb, i)
  }
  close(pb)
}

system.time(testit(1))
