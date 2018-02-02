# set up
install.packages("lubridate")
library(lubridate)
setwd("/Users/mnr/git/Code_Clinic_for_R/1_CodeClinic_PendOReille")

# Unit tests for GetPendOreille
GetPendOreille("20110503","20100503") #  Invalid input: start date is after end date

GetPendOreille("20100503","20110503") # data isn't available for 2010

GetPendOreille("20120723","20120724") # this should work

GetPendOreille("20110319","20110320") 
# should produce the following:
#           Wind   Air          Barometric
#           Speed  Temperature  Pressure
# --------------------------------
# Mean     6.117    38.96       29.781
# Median   6.2      39.2        29.8

GetPendOreille("20110319","20130320") # testing data across files
