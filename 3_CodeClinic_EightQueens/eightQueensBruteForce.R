# Brute force solution to 8 queens

# build a table containing all possible iterations
# placing 1-8 in each column prevents horizontal violations
clean.columns <- expand.grid(1:8,1:8,1:8,1:8,1:8,1:8,1:8,1:8) # 16777216 obs

number.of.rows <- nrow(clean.columns)
index <- 0

# start the process
clean.columns.and.rows <- clean.columns[apply(clean.columns,1,countUnique),]

# down to 40320 obs

clean.diag <- clean.columns.and.rows

for (queenIsInRow in 1:8) {
  for (columnIndex in 1:7) {
    for (columnIndexOffset in 1:7) {
      if (((columnIndex + columnIndexOffset) < 9) & ((queenIsInRow - columnIndexOffset) > 0 )) {
        clean.diag <- clean.diag[!(clean.diag[,columnIndex] == queenIsInRow & clean.diag[,(columnIndex + columnIndexOffset)] == queenIsInRow - columnIndexOffset),]
      }
      
      if (((columnIndex + columnIndexOffset) < 9) & ((queenIsInRow + columnIndexOffset) < 9 )) {
        clean.diag <- clean.diag[!(clean.diag[,columnIndex] == queenIsInRow & clean.diag[,(columnIndex + columnIndexOffset)] == queenIsInRow + columnIndexOffset),]        
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
