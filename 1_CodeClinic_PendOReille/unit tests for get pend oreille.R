# set up
install.packages("lubridate")
library(lubridate)
setwd("/Users/mnr/git/Code_Clinic_for_R/1_CodeClinic_PendOReille")

# Unit tests for GetPendOreille

source("GetPendOreille.R")
source("GetPORDataFor.R")

GetPendOreille("20110503","20100503")
#Error in GetPendOreille("20110503", "20100503") : 
#  Invalid input: start date is after end date

GetPendOreille("20100503","20110503") # this generates a 404. Not sure why

GetPendOreille("20020723","20041015") # import old format data
GetPendOreille("20120723","20120724") # import new format data
GetPendOreille("20101230","20110102") # import a mix of old and new format data


