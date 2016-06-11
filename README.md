# Getting-and-Cleaning-Data-Course-Project

The script run_analysis.R was created for the course project of the Getting and Cleaning Data course.

It is designed to do the following (as required): 

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This script downloads and extracts the required data for the analysis.
After merging the data sets, labels are added, and only columns involving the mean or std are kept. 

The script returns a tidy data set with the means of the desired columns. 
(Note: this data set is saved as 'tidy.txt' and is included in the repository)
