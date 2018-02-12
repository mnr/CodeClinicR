# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 3. Eight Queens


vecsucceed <- c(1,2,3,4,5,6,7,8)
vecfail <- c(1,1,2,3,4,5,6,7)

unique(vecsucceed)
unique(vecfail)

length((unique(vecsucceed)))
length(unique(vecfail))

any(vecfail == 1)
any(vecfail == 8)


seq.int(vecsucceed[3],8)

# createDiagValues returns a vector identifying diagonal attack rows
createDiagValues <- function(select_row, select_col,up_or_down = 1) {
  padWithZeros <- c(rep.int(0,times = select_col))

  diag_conflicts <- seq.int(from = select_col + up_or_down, 
                            by = up_or_down, 
                            length.out = 8 - select_col)
  diag_conflicts <- replace(diag_conflicts, diag_conflicts < 0, 0)
  
  return(c(padWithZeros,diag_conflicts))
}

createDiagValues(1,2,-1)
