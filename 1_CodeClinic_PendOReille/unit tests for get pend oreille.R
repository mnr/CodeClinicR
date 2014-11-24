# set up
install.packages("lubridate")
library(lubridate)

# Unit tests for GetPendOreille

source("GetPendOreille.R")

GetPendOreille("20110503","20100503")
#Error in GetPendOreille("20110503", "20100503") : 
#  Invalid input: start date is after end date

GetPendOreille("20100503","20110503")

GetPendOreille("20020723","20041015")

