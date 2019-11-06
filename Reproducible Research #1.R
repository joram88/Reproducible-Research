#REPRODUCIBLE RESEARCH
#By JRP

install.packages("downloader")

library(tidyverse)
library(downloader)

#1) First extract the ZIP file

url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download(url, dest="repdata_data_activity.zip", mode="wb")
unzip("repdata_data_activity.zip")

act <- read.csv("activity.csv")

#2) Histogram of steps

hist(act$steps)

#3) Mean and median number of steps taken each day

mean(act$steps, na.rm = TRUE)
median(act$steps, na.rm = TRUE)

#4) Time series plot of the average number of steps taken

#5) The 5-minute interval that contains max number of steps

#6) Code to describe and show a strategy for imputing missing data

miss <- nrow(filter(act, is.na(steps)))

#7) Histogram of total number of steps taken each day after missing
# values are imputed


#8) Panel plot comparing average number of steps taken per 5-minute
# interval across weekdays and weekends


