##Course project:
##setting wd
setwd("/Users/emilhermansson/Desktop/RkursJH")
getwd()

# Load library
library(utils)
library(dplyr)

# Download the zip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "/Users/emilhermansson/Desktop/RkursJH/Data.zip")

# List the contents of the zip file
unzip("/Users/emilhermansson/Desktop/RkursJH/Data.zip", list = TRUE)

# Unzip the file to a new directory
unzip("/Users/emilhermansson/Desktop/RkursJH/Data.zip", exdir = "/Users/emilhermansson/Desktop/RkursJH/exam_data")

#reading files:
test_x <-         read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/test/X_test.txt")
test_y <-         read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/test/y_test.txt")
subject_test <-   read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/test/subject_test.txt")

train_x <-        read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/train/X_train.txt")
train_y <-        read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/train/y_train.txt")
subject_train <-  read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/train/subject_train.txt")

features <-       read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/features.txt")

activityLabels <- read.table("/Users/emilhermansson/Desktop/RkursJH/exam_data/UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("activityID", "activityType")

# Assigning names to the loaded variables
colnames(train_x) <- features[, 2]
colnames(train_y) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(test_x) <- features[, 2]
colnames(test_y) <- "activityID"
colnames(subject_test) <- "subjectID"

# Merging all datasets into one set
comptest <- cbind(test_y, subject_test, test_x)
comptrain <- cbind(train_y, subject_train, train_x)
compdata <- rbind(comptrain, comptest)

#  Extracting only mean and sd for each measurement
mean_std <- grepl("activityID|subjectID|mean\\(\\)|std\\(\\)", colnames(compdata))
data_mean_std <- compdata[, mean_std]

# assigning activity names
data_mean_std_AN <- merge(data_mean_std, activityLabels, by = "activityID", all.x = TRUE)

#  substituting labels
colnames(data_mean_std_AN) <- gsub("^t", "time", colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("^f", "frequency", colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("Acc", "Accelerometer",colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("Gyro", "Gyroscope",colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("Mag", "Magnitude",colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("Body", "Body",colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("tBody", "TimeBody", colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("-mean()", "Mean", colnames(data_mean_std_AN), ignore.case = TRUE)
colnames(data_mean_std_AN) <- gsub("-std()", "STD", colnames(data_mean_std_AN), ignore.case = TRUE)
colnames(data_mean_std_AN) <- gsub("-freq()", "Frequency", colnames(data_mean_std_AN), ignore.case = TRUE)
colnames(data_mean_std_AN) <- gsub("angle", "Angle", colnames(data_mean_std_AN))
colnames(data_mean_std_AN) <- gsub("gravity", "Gravity", colnames(data_mean_std_AN))

#  Creating a second, independent tidy data set with the avg of each variable for each activity and subject
output <- data_mean_std_AN %>%
  group_by(subjectID, activityID, activityType) %>%
  summarise(across(everything(), ~ mean(.x, na.rm = TRUE)))

# Writing output in form of a .txt tidy dataset
write.table(output, "output.txt", row.names = FALSE)
