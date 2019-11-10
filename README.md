## README

    Load the data (i.e. read.csv()\color{red}{\verb|read.csv()|}read.csv())
    Process/transform the data (if necessary) into a format suitable for your analysis

library(zoo)

library(tidyverse)

library(downloader)

library(lubridate)


url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download(url, dest="repdata_data_activity.zip", mode="wb")
unzip("repdata_data_activity.zip")

act <- read.csv("activity.csv")

  What is mean total number of steps taken per day?

    For this part of the assignment, you can ignore the missing values in the dataset.

    1) Calculate the total number of steps taken per day
    2) Make a histogram of the total number of steps taken each day
    3) Calculate and report the mean and median of the total number of steps taken per day

Here we have the total number of steps taken per d ay

![graph5](https://raw.githubusercontent.com/jrpineda/Reproducible-Research/master/graph5.png)


Here is the histogram

![graph1](https://raw.githubusercontent.com/jrpineda/Reproducible-Research/master/graph1.png)

Mean = 10766.1886792453

Median = 10765

  What is the average daily activity pattern?

    Make a time series plot (i.e. type = "l"\color{red}{\verb|type = "l"|}type="l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
    Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

maxsteps <- intervals %>% 
        filter(steps == max(steps))

We learn that interval 835 h ad 206.2 steps, which was the maximum. We can see this in the graph below.

![graph2](https://raw.githubusercontent.com/jrpineda/Reproducible-Research/master/graph2.png)

    Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

![graph3](https://raw.githubusercontent.com/jrpineda/Reproducible-Research/master/graph3.png)

Mean2 = 10372

Median = 10571


We see that mean and median dropped once we removed the missing values.

    Make a panel plot containing a time series plot (i.e. type = "l"\color{red}{\verb|type = "l"|}type="l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 

![graph4](https://raw.githubusercontent.com/jrpineda/Reproducible-Research/master/graph4.png)

