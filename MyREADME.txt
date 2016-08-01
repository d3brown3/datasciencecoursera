##Mentor Graded Assignment: Getting and Cleaning Data Course Project

1. Merges the training and the test sets to create one data set.
	* Read in the X and Y text files (combine data.frames into one)
3. Uses descriptive activity names to name the activities in the data set
	* Read in data from features file and add to main data.frame as column names
2. Extracts only the measurements on the mean and standard deviation for each measurement.
	* Use grepl to identify columns with mean and std in the name and subset on these columns
4. Appropriately labels the data set with descriptive variable names.
	* Read in subject and activity files and add to data files
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	* Use data reshaping functions to creating a second data set of averages by subject and activity 