##install.packages("dplyr")
library(dplyr)

raw_x_test <- read.table("UCI HAR Dataset/test/X_test.txt") ##2947, 561
raw_y_test <- read.table("UCI HAR Dataset/test/y_test.txt") ##2947, 1
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") ##2947, 1

raw_x_train <- read.table("UCI HAR Dataset/train/X_train.txt") ##7352, 561
raw_y_train <- read.table("UCI HAR Dataset/train/y_train.txt") ##7352, 1
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")##7352, 1

raw_features <- read.table("UCI HAR Dataset/features.txt", header = FALSE) ##561, 2

## read in all necessary files

all_x <- rbind(raw_x_train, raw_x_test)
colnames(all_x) <- as.character(raw_features[,2])
## combine all x data, name columns with features

all_subject <- rbind(subject_train, subject_test)
colnames(all_subject) <- "subject"
## combine all subject data, name column

all_y <- rbind(raw_y_train, raw_y_test)
colnames(all_y) <- "activity"
## combine all y/activity, data, name column

data <- cbind(all_x, all_subject, all_y)
## combine all data frames
                
mean <- data[grep("mean\\(.", names(data))]
std <- data[grep("std\\(.", names(data))]
mean_std <- cbind(all_subject, all_y, mean, std)
## extract mean, std info, build data frame with subject, activity and extraced info

mean_std[,2]<-gsub(1, "walking", mean_std$activity)
mean_std[,2]<-gsub(2, "walking_upstairs", mean_std$activity)
mean_std[,2]<-gsub(3, "walking_downstairs", mean_std$activity)
mean_std[,2]<-gsub(4, "sitting", mean_std$activity)
mean_std[,2]<-gsub(5, "standing", mean_std$activity)
mean_std[,2]<-gsub(6, "laying", mean_std$activity)
## rename activity

tidy_data <- aggregate(mean_std[3:68], list(activity = mean_std$activity, subject = mean_std$subject), mean)
tidy_data <- select(tidy_data, subject, activity, 3:68)
## get mean of each column of measurements for each activity, each subject
## reorganize back to subject/activity/data

write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
## output final tidy data