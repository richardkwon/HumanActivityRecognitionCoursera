# HumanActivityRecognitionCoursera

### Here is what the assignment specified

> You should create one R script called run_analysis.R that does the following.

> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names.
>5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



### My code simply follow the each steps at a time.

#### FIRST, merges the training and the test file sets to create one data set.
Both test and train subfolders had 3 types of files to read - raw data files, label files, and test subject/person information files

This portion reads the raw data files from both subfolders and merges them.
```
training_set <- read.csv("UCI HAR Dataset\\train\\X_train.txt", header=FALSE, sep="")
test_set <- read.csv("UCI HAR Dataset\\test\\X_test.txt", header=FALSE, sep="")
merged_set <- rbind(training_set, test_set)
```

Same process is done for labels and persons data files.
```
training_label <- read.csv("UCI HAR Dataset\\train\\y_train.txt", sep="", header=FALSE)
test_label <- read.csv("UCI HAR Dataset\\test\\y_test.txt", sep="", header=FALSE)
merged_label <- rbind(training_label, test_label)
    
test_subjects <- read.csv("UCI HAR Dataset\\test\\subject_test.txt", sep="", header=FALSE)
training_subjects <- read.csv("UCI HAR Dataset\\train\\subject_train.txt", sep="", header=FALSE)
merged_subjects <- rbind(training_subjects, test_subjects)
```

What we have now are 3 merged (test + train) data sets - data, label, person.



#### SECOND, read the column names from the features.txt file and applied them to the merged "data" set so that we have more descriptive column headings
```
column_names <- read.csv("UCI HAR Dataset\\features.txt", header=FALSE, sep="")
column_names <- column_names[,2]
names(merged_set) <- as.character(column_names)
```

#### THIRD, search for the columns with "mean" and "std" substrings.  Using that column list, filter down the "data" table to only those columns.
```
char_column_names<-as.character(column_names)
bool_mean_and_std <- grepl("std|mean", char_column_names)
merged_set <- merged_set[, bool_mean_and_std]
```

#### FOURTH, substitute activity values to more descriptive activity labels.  The descriptive activity labels come from a file activity_labels.txt
#### By applying the more descriptive activity labels to the merged "data", we now have a BIG, TIDY data set
```
activity_labels <- read.csv("UCI HAR Dataset\\activity_labels.txt", sep = "", header = FALSE)
temp <- join(merged_label, activity_labels)
merged_label <- temp[2]    

names(merged_label) <- "activity"
names(merged_subjects) <- "personid"

tidy_data <- cbind(merged_subjects, merged_label, merged_set)    
```

#### LASTLY, we summarize into new tidy data set grouped by person and activity and averaging each data readings
```
new_tidy_data <- summarize_each(group_by(tidy_data, personid, activity), funs(mean))
```

!https://s-media-cache-ak0.pinimg.com/736x/02/e4/dc/02e4dcd5541e5be82dcf13a1227c370b.jpg
