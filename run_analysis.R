# download the file and put it in data folder
if(!file.exists("./data")) {dir.create("./data")}
file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file, destfile = "./data/Dataset.zip", method = "curl")

#unzip the file
unzip(zipfile = "./data/Dataset.zip", exdir="./data")
file_path <- file.path("./data", "UCI HAR Dataset")

#get the list of the files
files <- list.files(file_path, recursive=TRUE)

#read the activity file
dtActivityTest <- read.table(file.path(file_path, "test", "Y_test.txt"), header = FALSE)
dtActivityTrain <- read.table(file.path(file_path, "train", "Y_train.txt"), header = FALSE)

# read the subject file
dtSubjectTest <- read.table(file.path(file_path, "test", "subject_test.txt"), header = FALSE)
dtSubjectTrain <- read.table(file.path(file_path, "train", "subject_train.txt"), header = FALSE)

# read the features file
dtFeatureTest <- read.table(file.path(file_path, "test", "X_test.txt"), header = FALSE)
dtFeatureTrain <- read.table(file.path(file_path, "train", "X_train.txt"), header = FALSE)

# combine the data of 'train' and 'test' by rows
dataSubject <- rbind(dtSubjectTrain, dtSubjectTest)
dataActivity <- rbind(dtActivityTrain, dtActivityTest)
dataFeature <- rbind(dtFeatureTrain, dtFeatureTest)

# set name to variables
names(dataSubject) <- c("subject")
names(dataActivity)<- c("activity")
dtFeatureNames <- read.table(file.path(file_path, "features.txt"), header = FALSE)
names(dataFeature) <- dtFeatureNames$V2

# merge columns to make the data table for all the data
datamerge <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeature, datamerge)

#subset data with mean and std
subMeanStd <- dtFeatureNames$V2[grep("mean\\(\\)|std\\(\\)", dtFeatureNames$V2)]
featureNames <- c(as.character(subMeanStd), "subject", "activity")
Data <- subset(Data, select =featureNames)
str(Data)
# add the descriptive activity labels from "activity_labels.txt"
actLabels<- read.table(file.path(file_path, "activity_labels.txt"), header = FALSE)
#give descriptive names
names(Data)<-gsub ("^t", "time", names(Data))
names(Data)<-gsub ("^f", "frequency", names(Data))
names(Data)<-gsub ("Acc", "Accelerometer", names(Data))
names(Data)<-gsub ("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub ("Mag", "Magnitude", names(Data))
names(Data)<-gsub ("BodyBody", "Body", names(Data))

# create an independent tidy data with average of each variable for each activity and each subject

library(plyr);
Data2<- aggregate (. ~subject + activity, Data, mean)
Data2<- Data2[order(Data2$subject, Data2$activity),]
write.table(Data2, file = "tidydata.txt", row.name = FALSE)
