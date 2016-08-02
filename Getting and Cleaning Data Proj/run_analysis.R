library(reshape2)
##read in data for test
setwd("C:/Users/dbrow/Getting and Cleaning Data/UCI HAR Dataset/test")
x_test <- read.table("x_test.txt", sep = "")
y_test <- read.table("y_test.txt", sep = "")
test_subjects <- read.table("subject_test.txt", sep = "")

##read in data for train
setwd("C:/Users/dbrow/Getting and Cleaning Data/UCI HAR Dataset/train")
x_train <- read.table("x_train.txt", sep = "")
y_train <- read.table("y_train.txt", sep = "")
train_subjects <- read.table("subject_train.txt", sep = "")

##read in activity labels
setwd("C:/Users/dbrow/Getting and Cleaning Data/UCI HAR Dataset")
activity_labels <- read.table("activity_labels.txt", sep = "")

##read in features info
features <- read.table("features.txt", sep = "", row.names = "V1")

##merge dataframe for class labels with dataframe for test / train labels
mergedy_test <- merge(y_test, activity_labels, sort = FALSE)
mergedy_train <- merge(y_train, activity_labels, sort = FALSE)

##merge x dataframes and y dataframes - rows
merged_xdfs <- rbind(x_test, x_train)
names(merged_xdfs) <- features$V2
merged_ydfs <- rbind(mergedy_test, mergedy_train)

##merge subject dataframes - rows
merged_subjects <- rbind(test_subjects, train_subjects)

##merge x to y (labels to data) - columns
final_merge <- cbind(merged_subjects, merged_ydfs, merged_xdfs)

##renaming first column and first row
names(final_merge)[c(1, 3)] <- c("subjects","activity")

##extracting mean and standard deviations
filtered_fm <- final_merge[, c("activity", "subjects", subset(names(final_merge),grepl("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]", names(final_merge))))]

##combine all of the measurement variables to make a tall and skinny dataset
melted_ffm <- melt(filtered_fm, measure.vars = c(names(filtered_fm)[3:88]))

##independent tidy data set with the average of each variable for each activity and each subject
averages <- dcast(melted_ffm, activity + subjects ~ variable, mean)
melted_averages <- melt(averages, measure.vars = c(names(averages)[3:88]))
melted_averages
setwd("C:/Users/dbrow/datasciencecoursera/Getting and Cleaning Data Project")
write.table(melted_averages, "tidydataset.txt", row.names = FALSE)
read.table("tidydataset.txt")