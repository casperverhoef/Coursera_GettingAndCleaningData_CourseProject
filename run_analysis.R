# set working directory to data directory
setwd("./UCI HAR Dataset")

library(plyr); library(dplyr)

# Read data
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
Y_test <- read.table("test/y_test.txt")
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
Y_train <- read.table("train/Y_train.txt")
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

# Merge data to create one data set.
# subject_table <- rbind(subject_test,subject_train)
# X_table <- rbind(X_test, X_train)
# Y_table <- rbind(Y_test, Y_train)

# Merge data to create one data set.
subject_table <- bind_rows(subject_test,subject_train)
X_table <- bind_rows(X_test, X_train)
Y_table <- bind_rows(Y_test, Y_train)

# name columns
"Subject" -> colnames(subject_table) 
features$V2 -> colnames(X_table)
"Activity" -> colnames(Y_table)

# Extract measurements on the mean and standard deviation
X_table_ms <- X_table[grepl(("(mean|std)\\("), features$V2)]

# create one data set
full_table <- bind_cols(subject_table, Y_table, X_table_ms)

# name activities
full_table$Activity <- factor(full_table$Activity, labels=casefold(activity_labels$V2))

# rename to better readable variables
Names <- names(full_table)
Names <- gsub("\\(\\)", "", Names)
Names <- gsub("-", "_", Names)
Names <- gsub("^t", "Time_", Names)
Names <- gsub("^f", "Freq_", Names)
Names <- gsub("mean", "Mean", Names)
Names <- gsub("std", "Std", Names)

Names -> colnames(full_table)

# create a data set with the average of each variable for each activity and subject 
tidy_dataset <- ddply(full_table, .(Subject, Activity),colwise(mean))
write.table(tidy_dataset, file="./tidy_dataset.csv")
