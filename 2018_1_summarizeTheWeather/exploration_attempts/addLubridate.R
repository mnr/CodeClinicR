
# what I replaced with Lubridate

# original version
minDate = strptime(LPO_weather_data[ 1, "date" ], 
                   format = "%Y_%m_%d" )
# lubridate version
minDate = as_date(LPO_weather_data[ 1, "date" ])

# original version
maxDate = strptime(LPO_weather_data[ nrow(LPO_weather_data), "date" ],
                   format = "%Y_%m_%d" )
# lubridate version
maxDate = as_date(LPO_weather_data[ nrow(LPO_weather_data), "date" ])