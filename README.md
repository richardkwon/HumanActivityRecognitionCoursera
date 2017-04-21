# HumanActivityRecognitionCoursera

### Here is what the assignment specified

> You should create one R script called run_analysis.R that does the following.

> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names.
>5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### My code simply follow the each steps at a time.
#### FIRST, merges the training and the test sets to create one data set.
both test and train subfolders had 3 types of files to read - raw data set, label file, and test subject/person information

this portion reads the raw data sets from both subfolders.
```training_set <- read.csv("UCI HAR Dataset\\train\\X_train.txt", header=FALSE, sep="")
test_set <- read.csv("UCI HAR Dataset\\test\\X_test.txt", header=FALSE, sep="")```

