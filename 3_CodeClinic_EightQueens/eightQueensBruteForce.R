# Brute force solution to 8 queens
setwd("3_CodeClinic_EightQueens/")
source("plotTheQueens.R")


# build a table containing all possible iterations
# placing 1-8 in each column prevents horizontal violations
clean.columns <- expand.grid(1:8,1:8,1:8,1:8,1:8,1:8,1:8,1:8) # 16777216 obs

# use this to show one line. 
plotARowOfQueens(clean.columns[60000,])

number.of.rows <- nrow(clean.columns) # used by countUnique
index <- 0 # used by countUnique

# start the process of removing rows with conflicts
# with system.time
# system.time(clean.columns.and.rows <- clean.columns[apply(clean.columns,1,countUnique),])
# and without system.time
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


for (queenPlot in 1:nrow(clean.diag)) {
  plotARowOfQueens(clean.diag[queenPlot,])
  Sys.sleep(5)
}
