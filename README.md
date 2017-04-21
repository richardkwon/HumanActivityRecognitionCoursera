# HumanActivityRecognitionCoursera

### Here is what the assignment specified

> You should create one R script called run_analysis.R that does the following.

> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names.
>5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



### My code simply follow the each steps at a time.

##### FIRST, merges the training and the test file sets to create one data set.
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



##### SECOND, read the column names from the features.txt file and applied them to the merged "data" set so that we have more descriptive column headings
```
column_names <- read.csv("UCI HAR Dataset\\features.txt", header=FALSE, sep="")
column_names <- column_names[,2]
names(merged_set) <- as.character(column_names)
```
