##before running the script, remember to:
#1 setwd
#2 install and run library tidyr and dplyr

## download and unzip data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "human_smartphone_data.zip"
download.file(fileURL, filename)
unzip(filename)

## 1. Merges the training and the test sets to create one data set.
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
names(trainSet)<-c(features[,2])
testSet <- read.table("UCI HAR Dataset/test/X_test.txt")
names(testSet)<-c(features[,2])

trainLabel <- read.table("UCI HAR Dataset/train/Y_train.txt")
names(trainLabel)<-c("Activities")
testLabel <- read.table("UCI HAR Dataset/test/Y_test.txt")
names(testLabel)<-c("Activities")

trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(trainSubject)<-c("Subject")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(testSubject)<-c("Subject")

train<-cbind(trainSet, trainLabel, trainSubject)
test<-cbind(testSet, testLabel, testSubject)
completeData<-rbind(train, test)

## 3. Uses descriptive activity names to name the activities in the data set
completeData$Activities<- activityLabels[match(completeData$Activities, activityLabels$V1), 2]

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanStandardDeviationData<- completeData[grep(".*mean.*|.*std.*|Activities|Subject", names(completeData))]

## 4. Appropriately labels the data set with descriptive variable names.
names(meanStandardDeviationData) <- gsub("^t", "time", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub("^f", "fastFourierTransform", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub("Acc", "Accelerometer", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub("Gyro", "Gyroscope", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub("Mag", "Magnitude", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub("Freq", "Frequency", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub("mean", "Mean", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub("std", "StandardDeviation", names(meanStandardDeviationData))
names(meanStandardDeviationData) <- gsub('[-()]', '', names(meanStandardDeviationData))


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject.
AverageData<-group_by(meanStandardDeviationData, Activities, Subject) %>% summarise_each(funs(mean)) 
write.table(AverageData, "tidy.txt", row.names = FALSE, quote = FALSE)

