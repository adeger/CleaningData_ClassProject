# Data merging and analysis R script for Samsung accelerometer data downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# (md5 checksum = d29710c9530a31f303801b6bc34bd895) as file SamsungDataset.zip. 
#
# The script satisfies the requirements of the Coursera course "Getting and Cleaning Data" 
# class project:
#
#  1) Merges training and data sets (variables containing mean() and std()), subject (number) and
#     activity using the activity name instead of the activity code
#  2) Outputs a tidy data set grouped by subject (number) and activity of means for those observation
#     groups
#
# The following file paths must be visible from the current R working directory:
#   - ./activity_labels.txt
#   - ./features.txt
#   - ./features_info.txt
#   - ./test/subject_test.txt
#   - ./test/X_test.txt
#   - ./test/y_test.txt
#   - ./train/subject_train.txt
#   - ./train/X_train.txt
#   - ./train/y_train.txt
# 
# to run, source this script in R console (or possibly R Studio), and run "do_all()" (without quotes).
# A data.frame will be returned with the required (mean summary) data set.  In addition, the file
# Acceleration_Data_Means_Summarized_by_Subject&Activity.txt will be generated readable by the
# read.table() function.

library(dplyr)   # required library

merge_data <- function(data_list){
    # return a data frame of merged data (combining "test" and "training" subjects) from the 
    # list output by read_data, excluding accelerometer data variables not reporting 
    # means or standard deviations 
	
    all_x <- rbind(data_list$x_train, data_list$x_test)
    colnames(all_x) <- data_list$features[,2]
    all_x <- all_x[, grep("(std\\(\\)|mean\\(\\))", colnames(all_x), perl=TRUE)]
    #all_x$Group <- c(rep("Train", nrow(data_list$x_train)), rep("Test", nrow(data_list$x_test)))

    all_y <- rbind(data_list$y_train, data_list$y_test)
    colnames(all_y) <- "Activity.Code"

    results <- cbind(all_y, all_x)

    all_subject <- rbind(data_list$subject_train, data_list$subject_test)
    colnames(all_subject) <- "Subject"

    results <- cbind(all_subject, results)

    colnames(data_list$activity_labels) <- c("Activity.Code", "Activity")
    results <- merge(data_list$activity_labels, results)
    results$Activity.Code <- NULL
    results
}

read_data <- function(){
    # return a list of data frames from each of the required files in the data set

    res <- list()
    res$x_train <- read.table("./train/X_train.txt", header=FALSE)
    res$y_train <- read.table("./train/y_train.txt", header=FALSE)
    res$subject_train <- read.table("./train/subject_train.txt", header=FALSE)

    res$x_test <- read.table("./test/X_test.txt", header=FALSE)
    res$y_test <- read.table("./test/y_test.txt", header=FALSE)
    res$subject_test <- read.table("./test/subject_test.txt", header=FALSE)

    res$activity_labels <- read.table("./activity_labels.txt", header=FALSE)
    res$features <- read.table("features.txt", header=FALSE)

    return(res)
}

summarize_data <- function(merged_data){
    # return a data frame of summary values for each of the variables grouped
    # by unique combinations of subject and activity

    summarise_each(group_by(merged_data, Subject, Activity), c("mean"))
}

do_all <- function() {
    # run the whole shmear

    data_list <- read_data()
    merged_data <- merge_data(data_list)
    summarized_data <- summarize_data(merged_data)
    write.table(summarized_data, file="Acceleration_Data_Means_Summarized_by_Subject&Activity.txt", row.names=FALSE)
    return(summarized_data)
}
