## This reads the train and test data into R
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## Combines the train and test data for x, y, and subject separately
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
s <- rbind(subject_train, subject_test)

## Read labels of features into R and then searches for mean and std
## in each and replaces all matches with more descriptive names
features <- read.table("./UCI HAR Dataset/features.txt")
secondcolumn <- grep("-mean\\(\\)|-std\\(\\)", features$V2)
x <- x[, secondcolumn]
names(x) <- gsub("\\(|\\)", "", (features[secondcolumn, 2]))

## Read activities and subjects into R, renames columns, and then
## give descriptive names and then provides a tidy set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
y[, 1] = activities[y[, 1], 2]
names(s) <- "Subject"
names(y) <- "Activity"
tidy <- cbind(s, y, x)


##Creates a 2nd, independent tidy data set with the average of each variable
#for each activity and each subject with descriptive names then prints it:
p <- tidy[, 3:dim(tidy)[2]] 
tidytwo <- aggregate(p,list(tidy$Subject, tidy$Activity), mean)
names(tidytwo)[1] <- "Subject"
names(tidytwo)[2] <- "Activity"
write.table(tidytwo, file = "tidytwo.txt",row.name=FALSE)
tidytwo