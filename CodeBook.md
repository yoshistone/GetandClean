## CodeBook
This code book provides information about the variables that is contained in the tiny data set.

### Source
The source of this data was taken from the following:
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* Also available via this zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Study Design 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.



### Data files in zipped folder
* SUBJECT FILES

-- test/subject_test.txt &nbsp;
-- train/subject_train.txt

* ACTIVITY FILES

-- test/X_test.txt &nbsp;
-- train/X_train.txt

* DATA FILES

-- test/y_test.txt &nbsp;
-- train/y_train.txt

* Name of Column Variables

-- features.txt &nbsp;
-- activity_labels.txt

### Instruction List
* This reads the train and test data into R
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)&nbsp;
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)&nbsp;
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)&nbsp;
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)&nbsp;
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)&nbsp;
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

* Combines the train and test data for x, y, and subject separately
x <- rbind(x_train, x_test)&nbsp;
y <- rbind(y_train, y_test)&nbsp;
s <- rbind(subject_train, subject_test)

* Read labels of features into R and then searches for mean and std in each and replaces all matches with more descriptive names
features <- read.table("./UCI HAR Dataset/features.txt")&nbsp;
secondcolumn <- grep("-mean\\(\\)|-std\\(\\)", features$V2)&nbsp;
x <- x[, secondcolumn]&nbsp;
names(x) <- gsub("\\(|\\)", "", (features[secondcolumn, 2]))

* Read activities and subjects into R, renames columns, and then give descriptive names and then provides a tidy set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")&nbsp;
y[, 1] = activities[y[, 1], 2]&nbsp;
names(s) <- "Subject"&nbsp;
names(y) <- "Activity"&nbsp;
tidy <- cbind(s, y, x)


* Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject with descriptive names:
p <- tidy[, 3:dim(tidy)[2]] &nbsp;
tidytwo <- aggregate(p,list(tidy$Subject, tidy$Activity), mean)&nbsp;
names(tidytwo)[1] <- "Subject"&nbsp;
names(tidytwo)[2] <- "Activity"