# Different attempts at countUnique
 
# countUnique wipes out two or more queens in one row
# returns FALSE if there are two or more queens in one row
# returns TRUE if the row is falid

################################
#       user   system  elapsed 
#   6782.063 1665.710 8607.517 
countUnique <- function(x) {
  # and...this line only printed at the beginning of execution
  cat('\r',index,"rows examined of",number.of.rows,"total. ",(index/number.of.rows)*100," percent finished          ")
  index <- index + 1
  
  return(ifelse(nlevels(factor(as.numeric(x))) == 8,TRUE,FALSE))
}

################################
#     user   system  elapsed 
# 1035.575   64.781 1209.968 
countUnique <- function(x) {
  ifelse(length(unique(as.list(x))) == 8,TRUE,FALSE)
}

################################
#    user  system elapsed 
# 212.989  14.886 235.417 
countUnique <- function(x) {
  return(ifelse(nlevels(factor(as.numeric(x))) == 8,TRUE,FALSE))
}



################################
#    user  system elapsed 
# 195.558  17.218 235.582
sum.of.one.to.eight <- sum(1:8)
countUnique <- function(x) {
  if (sum(x) != sum.of.one.to.eight) { 
    return(FALSE)
  } else {
    ifelse(length(unique(as.list(x))) == 8,TRUE,FALSE)
  }
}

################################
#    user  system elapsed 
# 500.989  11.123 534.888 
countUnique <- function(x) {
  return(!anyDuplicated(x))
}