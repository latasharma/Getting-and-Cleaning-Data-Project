## Getting-andCleaning-Data-Project
#Course Project

*You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#What you find in this repository
CodeBook.md: information about raw and tidy data set and elaboration made to transform them
README.md: this file
run_analysis.R: R script to transform raw data set in a tidy one

#How to create the tidy data set
1. download compressed raw data
2. unzip raw data and copy the directory UCI HAR Dataset to the cloned repository root directory
3. open a R console and set the working directory to the repository root (use setwd())
4. source run_analisys.R script (it requires the plyr package): source('run_analysis.R')
