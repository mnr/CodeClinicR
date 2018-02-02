
**Problem 1**

**Statistical Analysis - Exploring Lake Pend Oreille**

PRONUNCIATION TIP: Pend Oreille is pronounced “Pond O-Ray”

Code Clinic is a monthly course where a unique problem is introduced to a collection of lynda.com authors. In response, each author will create a solution using their programming language of choice. You can learn several things from Code Clinic: different approaches to solving a problem, the pros and cons of different languages, and some tips and tricks to incorporate into your own coding practices.

This is a problem in statistical analysis and to some extent, handling big data. It’s common to use a computer to manipulate and summarize large amounts of information, providing important insights on how to improve or handle a situation.

In this problem, we’ll use weather data collected by the US Navy from Lake Pend Oreille in Northern Idaho. Lake Pend Oreille is  the fifth deepest freshwater lake in the United States. So deep, in fact, that the US Navy uses it to test submarines. 

*Note: The original data is located [here](http://lpo.dt.navy.mil/data/). If you live outside of the United States, you won't be able to access this data. Instead, we have created a static repository [here](https://github.com/lyndadotcom/LPO_weatherdata).*

As part of that testing, the US Navy compiles an exhaustive list of weather statistics. Wind speed, Air Temperature, Barometric Pressure. 

You can browse this data by pointing your web browser at [http://lpo.dt.navy.mil/](). You’ll find several weather summaries, a web cam, and the raw data they collect every five minutes, archived as standard text files.

For anyone living or working on Lake Pend Oreille, weather statistics are an important part of everyday life. Average windspeed can be very different than median windspeed - especially if you are on a small boat in the middle of the lake.

In this challenge, each of our authors will use their favorite language to calculate the mean and median of the wind speed, air temperature and barometric pressure recorded at the deep moor station for a given range of dates. 

| | Wind speed | Air temperature | barometric pressure |
|----|-----|----|----|
| Mean |
| Median |


First, let’s briefly review mean and median - these are both statistics. 

To explain statistics, we need a set of numbers. How about fourteen readings for wind gust at Deep Moor weather station on January 1, 2014. You can see the data at [http://lpo.dt.navy.mil/data/DM/2014/2014_01_01/Wind_Gust]().

The first column is the day the wind gust was recorded, the second column is the time it was recorded, and the third column is the wind gust in miles per hour.

    2014_01_01 00:21:24 14
    2014_01_01 00:27:31 14
    2014_01_01 00:33:39 11
    2014_01_01 00:39:47 11
    2014_01_01 00:45:54 11
    2014_01_01 00:52:02 11
    2014_01_01 00:58:09 11
    2014_01_01 01:04:17 3
    2014_01_01 01:10:25 7
    2014_01_01 01:16:32 7
    2014_01_01 01:22:40 7
    2014_01_01 01:28:48 7
    2014_01_01 01:35:55 4
    2014_01_01 01:42:03 8

The Mean is also known as the average. 

To calculate the mean of a range of numbers, simply add the values in the set, then divide by the number of values.

In this example, we add 14+14+11+11+11+11+11+3+7+7+7+7+4+8, then divide the sum by 14 - the count of numbers in the set. In this case, the mean is equal to 9.

The Median is the number halfway between all the values in a sorted range of values. 

Think of the median as in the median strip of the road - it always marks the center of the road.

To calculate the median, first sort the numbers from lowest to highest. 

If there is an odd number of values, then just take the middle number.
animation

If there is an even number of values, then calculate the average of the central two numbers.

In this case, there is an even number of values, so we sort, then take the average of the middle two values: 8 and 11 . The median is 9.5

In addition, some authors have chosen to implement a web service, allowing other web sites to access the new weather statistics created by the author’s program.

This is typically done by creating a “RESTful API” which, when called, returns information in a format known as JSON.

For a detailed description of JSON and it’s uses, please refer to “Effective Design of Restful APIs” by Keith Casey and “Javascript and JSON” by Ray Villalobos. 

In our case, if I make this HTTP call…

[http://theauthorswebsite.com/pendoreilleWebService?startDate=20110319&endDate=20110320]()

I would expect to receive the Mean and Median for windspeed, air temperature and barometric pressure for the range of dates starting with March 19, 2011 and running until midnight of March 20, 2011. 

| | Wind speed | Air temperature | barometric pressure |
|----|-----|----|----|
| Mean | 6.117 | 38.96 | 29.781 |
| Median | 6.2 | 39.2 | 29.8 |

The JSON data would look something like this:

    var jsonReturnData = {
         "windSpeed": [{"mean":6.61179039301,"median":6.2}],
         "airTemperature":[{"mean":38.969650655,"median":39.2}],
         "barometricPressure":[{"mean":29.781441048,"median":29.8}]
    }

So there’s our first challenge - pull statistics from a data set available on-line. Perhaps you want to pause and create a solution of your own. How would you solve the problem? In the next videos, I’ll show you how I solved the challenge.
