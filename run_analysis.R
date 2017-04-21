run_analysis <- function () {
    #################################################################################
    ##
    ## Author: Omyung (Richard) Kwon
    ## Date: April 21, 2017
    ## Human Activity Recognition - Coursera (Getting and Cleaning Data course)
    ##
    #################################################################################
    
    library(dplyr)
    library(plyr)
    
    #################################################################################
    ## 1, merge the training and test data sets
    #################################################################################
    
    ## data set
    training_set <- read.csv("UCI HAR Dataset\\train\\X_train.txt", header=FALSE, sep="")
    test_set <- read.csv("UCI HAR Dataset\\test\\X_test.txt", header=FALSE, sep="")
    merged_set <- rbind(training_set, test_set)
    
    ## activity label
    training_label <- read.csv("UCI HAR Dataset\\train\\y_train.txt", sep="", header=FALSE)
    test_label <- read.csv("UCI HAR Dataset\\test\\y_test.txt", sep="", header=FALSE)
    merged_label <- rbind(training_label, test_label)
    
    ## test subjects
    test_subjects <- read.csv("UCI HAR Dataset\\test\\subject_test.txt", sep="", header=FALSE)
    training_subjects <- read.csv("UCI HAR Dataset\\train\\subject_train.txt", sep="", header=FALSE)
    merged_subjects <- rbind(training_subjects, test_subjects)
    
    
    #################################################################################
    ## 2, extracts only the mesaurements on the mean and standard deviation for
    ## each measurement.
    ## 3, Uses descriptive activity names to name the activities in the data set
    #################################################################################
    
    ## Read column names
    column_names <- read.csv("UCI HAR Dataset\\features.txt", header=FALSE, sep="")
    column_names <- column_names[,2]
    
    ## Rename merged data set's column names to those read from features.txt
    names(merged_set) <- as.character(column_names)
    
    ## Find columns with "mean" and "std" strings
    char_column_names<-as.character(column_names)
    bool_mean_and_std <- grepl("std|mean", char_column_names)
    
    ## Filter down to only mean and std columns
    merged_set <- merged_set[, bool_mean_and_std]
    
    
    #################################################################################
    ## 4, Appropriately labels the data set with descriptive variable names
    #################################################################################
    
    ## Read the activity labels
    activity_labels <- read.csv("UCI HAR Dataset\\activity_labels.txt", sep = "", header = FALSE)
    
    ## Turn merged_label to more descriptive activity labels
    temp <- join(merged_label, activity_labels)
    merged_label <- temp[2]
    
    names(merged_label) <- "activity"
    names(merged_subjects) <- "personid"

    ## Now add person and activities columns to the merged data set
    ## We have a big, consolidated tidy data!
    tidy_data <- cbind(merged_subjects, merged_label, merged_set)
    
    
    #################################################################################
    ## 5, From the data set in step 4, creates a second, independent tidy data set
    ## with the average of each variable for each activity and each subject (person)
    #################################################################################
    new_tidy_data <- summarize_each(group_by(tidy_data, personid, activity), funs(mean))
    
    ## Write the new tidy data set to the TXT file
    write.table(new_tidy_data, file="./summarized_tidy_data.txt", row.names = FALSE)
    
}