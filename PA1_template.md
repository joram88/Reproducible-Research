---
title: "Reproducible Research"
author: "JRP"
date: "11/7/2019"
output: html_document
---

#1) Reading all the libraries and data in.

You will need to install downloader and zoo if you don't have it.

```r
library(zoo)
library(tidyverse)
library(downloader)
library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download(url, dest="repdata_data_activity.zip", mode="wb")
unzip("repdata_data_activity.zip")

act <- read.csv("activity.csv")
```

#2) Histogram of the steps per day

```r
hist(totsteps$steps, breaks=20)
```

```r
totsteps <- act %>% 
        group_by(date) %>% 
        summarise(steps = sum(steps))


```

#3) Mean and median number of steps taken each day

```r
mean <- mean(totsteps$steps, na.rm = TRUE)
median <- median(totsteps$steps, na.rm = TRUE)
```

#4) Time series plot of the average number of steps taken

```{r, echo=TRUE}
clact <- na.omit(act)

by_int <- clact %>% group_by(interval)
intervals <- by_int %>% summarize(steps = mean(steps))

ggplot(data = intervals, 
        mapping = aes(interval, steps))+geom_line()+
        labs(title="Steps per 5 Second Interval")+
        xlab("Interval")+
        ylab("Steps")+
        theme(plot.title = element_text(hjust = 0.5))
```

#5) The 5-minute interval that contains max number of steps

```r

maxsteps <- intervals %>% 
        filter(steps == max(steps))
```

#6) Code to describe and show a strategy for imputing missing data

```r
by_date <- act %>% group_by(date)
        daily <- by_date %>% summarise(steps = sum(steps))
        
        barplot(daily$steps,  
                col = "darkred",
                xlab = "Day",
                ylab = "Steps",
                main = "Total Daily Steps")


# Here we can see the missing values by day. To fix this
# I am going to use the approx function in R to interpolate
# then replace the first and last obs via zoo        

daily$steps <- na.approx(daily$steps, na.rm = FALSE)
na.locf(daily$steps, na.rm = TRUE, fromLast = TRUE)
daily$steps <- na.fill(daily$steps, "extend")
```

#7) Histogram of total number of steps taken each day after missing
values are imputed

```r
hist(daily$steps, breaks=20)

mean2 <- mean(daily$steps, na.rm = TRUE)
median2 <- median(daily$steps, na.rm = TRUE)
```
We see that there is an impact, with the mean and media decreasing

#8) Panel plot comparing average number of steps taken per 5-minute
# interval across weekdays and weekends

```r
final <- act

final$date <- ymd(final$date)
final$day <- weekdays(final$date)
final <- mutate(final, type = ifelse(grepl("Saturday", day), "Weekend",
                        ifelse(grepl("Sunday", day), "Weekend", "Weekday")))

final2 <- na.omit(final)
        by_fin <- final2 %>% group_by(interval, type)
        final2int <- by_fin %>% summarize(steps = mean(steps))

g <- ggplot(data = final2int, 
       mapping = aes(interval, steps, group=type))+geom_line(aes(color=type))+
        labs(title="Steps per 5 Second Interval Comparison")+
        xlab("Interval")+
        ylab("Steps")+
        theme(plot.title = element_text(hjust = 0.5))
g+facet_grid(type ~.)+ theme(legend.position="none")
```
