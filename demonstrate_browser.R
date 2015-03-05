# demonstrate the use of browser()

testrun <- 1:10

dosomething <- function (x) {
  # browser()
  
  print(x)
}

for (index in testrun) {
  dosomething(index)
}