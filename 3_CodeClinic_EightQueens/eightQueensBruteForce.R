# Brute force solution to 8 queens

# build a table containing all possible iterations
# placing 1-8 in each column prevents horizontal violations
clean.columns <- expand.grid(1:8,1:8,1:8,1:8,1:8,1:8,1:8,1:8) # 16777216 obs

# wipe out two or more queens in one row
sum.of.one.to.eight <- sum(1:8)
countUnique <- function(x) {
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
system.time(clean.columns.and.rows <- clean.columns[apply(clean.columns,1,countUnique),])
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





