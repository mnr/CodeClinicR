# Brute force solution to 8 queens

# build a table containing all possible iterations
# placing 1-8 in each column prevents horizontal violations
clean.columns <- expand.grid(1:8,1:8,1:8,1:8,1:8,1:8,1:8,1:8) # 16777216 obs

# wipe out two or more queens in one row
new.countUnique <- function(x) {
  #       user   system  elapsed 
  #   6782.063 1665.710 8607.517 
  # and...this line only printed at the beginning of execution
  cat('\r',index,"rows examined of",number.of.rows,"total. ",(index/number.of.rows)*100," percent finished          ")
  index <- index + 1
  
  return(ifelse(nlevels(factor(as.numeric(x))) == 8,TRUE,FALSE))
}

countUnique <- function(x) {
  #    user  system elapsed 
  # 212.989  14.886 235.417 
  
  return(ifelse(nlevels(factor(as.numeric(x))) == 8,TRUE,FALSE))
}

sum.of.one.to.eight <- sum(1:8)
old2.countUnique <- function(x) {
  #    user  system elapsed 
  # 195.558  17.218 235.582
  if (sum(x) != sum.of.one.to.eight) { 
    return(FALSE)
  } else {
    ifelse(length(unique(as.list(x))) == 8,TRUE,FALSE)
  }
}
old.countUnique <- function(x) {
  #     user   system  elapsed 
  # 1035.575   64.781 1209.968 
  ifelse(length(unique(as.list(x))) == 8,TRUE,FALSE)
}

number.of.rows <- nrow(clean.columns)
index <- 0

# This next step is intensive, so I am going to display a progress bar
#pb <- txtProgressBar(min = 0, max = nrow(clean.columns), style = 2)
# start the process
system.time(clean.columns.and.rows <- clean.columns[apply(clean.columns,1,countUnique),])

# the above one-liner broken out into a for loop
# list.of.clean.columns.and.rows <- for (index in 1:number.of.rows) {
#   #setTxtProgressBar(pb, index)  
#   cat('\r',index,"rows examined of",number.of.rows,"total. ",(index/number.of.rows)*100," percent finished          ")
#   ifelse(nlevels(factor(as.numeric(clean.columns[index,]))) == 8,TRUE,FALSE)
# }
# clean.columns.and.rows <- clean.columns[list.of.clean.columns.and.rows,]

close(pb)
# down to 40320 obs

clean.diag <- clean.columns.and.rows

#print(paste("nrow(clean.diag)=",nrow(clean.diag)))
for (queenIsInRow in 1:8) {
  for (columnIndex in 1:7) {
    for (columnIndexOffset in 1:7) {
      if (((columnIndex + columnIndexOffset) < 9) & ((queenIsInRow - columnIndexOffset) > 0 )) {
        clean.diag <- clean.diag[!(clean.diag[,columnIndex] == queenIsInRow & clean.diag[,(columnIndex + columnIndexOffset)] == queenIsInRow - columnIndexOffset),]
        #print(paste("columnIndex=",columnIndex,"queenIsInRow=",queenIsInRow,"columnIndexOffset=",columnIndexOffset,"nrow(clean.diag)=",nrow(clean.diag)))
      }
      
      if (((columnIndex + columnIndexOffset) < 9) & ((queenIsInRow + columnIndexOffset) < 9 )) {
        clean.diag <- clean.diag[!(clean.diag[,columnIndex] == queenIsInRow & clean.diag[,(columnIndex + columnIndexOffset)] == queenIsInRow + columnIndexOffset),]
        #print(paste("columnIndex=",columnIndex,"queenIsInRow=",queenIsInRow,"columnIndexOffset=",columnIndexOffset,"nrow(clean.diag)=",nrow(clean.diag)))
        
      }
    }
  }
}

# plot the results
for (queenPlot in 1:nrow(clean.diag)) {
  theTitle <- ""
  for (index in 1:8) theTitle <- paste(theTitle,clean.diag[queenPlot,index],sep="     ")
  plot(1:8,as.matrix(clean.diag[queenPlot,]),
       main=theTitle,
       xlab="Columns",ylab="Rows",
       lwd=3,pch=11)
  abline(h=1:8,v=1:8,lheight=100)
  Sys.sleep(5)
}





