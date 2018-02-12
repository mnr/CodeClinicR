# Copyright Mark Niemann-Ross, 2018
# Author: Mark Niemann-Ross. mark.niemannross@gmail.com
# LinkedIn: https://www.linkedin.com/in/markniemannross/
# Github: https://github.com/mnr
# More Learning: http://niemannross.com/link/mnratlil
# Description: Code Clinic R: Solution 3. Eight Queens

# test values
fail_posDiagonal <- c(1,2,3,4,5,6,7,8) # fails because of positive diagonals
fail_negDiagonal <- c(8,7,6,5,4,3,2,1) # fails because of negative diagonals
fail_dupRows <- c(1,1,2,3,4,5,6,7) # fails because of duplicate rows
validSolution <- c(7,5,3,1,6,8,2,4) # This should work


# createDiagValues returns a vector identifying diagonal attack rows
createDiagValues <- function(select_row, select_col, up_or_down = 1) {
  padWithZeros <- c(rep.int(0,times = select_col))

  diag_conflicts <- seq.int(from = select_row + up_or_down, 
                            by = up_or_down, 
                            length.out = 8 - select_col)
  diag_conflicts <- replace(diag_conflicts, diag_conflicts < 0, 0)
  diag_conflicts <- replace(diag_conflicts, diag_conflicts > 8, 0)
  
  return(c(padWithZeros,diag_conflicts))
}

is_this_a_valid_8_queens <- function(potentialSolution) {
  # potentialSolution is a vector of 8 numbers representing row of each column
  
  # if there are fewer than 8 unique values in potentialSolution ...
  # then there are duplicate rows - FAIL
  if (length(unique(potentialSolution)) < 8 ) return(FALSE)
  
  # check for diagonal conflicts
  for (eachElement in 1:8) {
    diagonal_conflicts <- createDiagValues(potentialSolution[eachElement], eachElement, 1)
    areThereDiagonalConflicts <- potentialSolution - diagonal_conflicts
    if (any(areThereDiagonalConflicts == 0)) {return(FALSE)}
    
    diagonal_conflicts <- createDiagValues(potentialSolution[eachElement], eachElement, -1)
    areThereDiagonalConflicts <- potentialSolution - diagonal_conflicts
    if (any(areThereDiagonalConflicts == 0)) {return(FALSE)}
  }
  
  # if we made it this far, it's a valid solution
  return(TRUE)
}

