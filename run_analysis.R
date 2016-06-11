library(plyr)

## Begin by downloading the required dataset

if(!file.exists("data")){
  dir.create("data")
}

filename <- "dataset.zip"

## Download the dataset and unzip it
if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
  download.file(fileUrl, filename, method = "curl")

  unzip(filename)
}

## We now have an unzipped folder called UCI HAR Dataset


####### 1. Merge the training and the test sets to create on data set #######


## Begin by loading the desired data

trainingSet <- read.table("UCI HAR Dataset/train/X_train.txt")
trainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

testSet <- read.table("UCI HAR Dataset/test/X_test.txt")
testLables <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")


## Create the "X" data set by merging the test and training Set

fullSet <- rbind(trainingSet, testSet)

## Create the "Y" data set by merging the test and training labels

fullLabels <- rbind(trainingLabels, testLables)

## Create the subject data set by merging the test and training subjects

fullSubjects <- rbind(trainingSubjects, testSubjects)



###### 2. Extract only the measurements on the mean and standard deviation for each measurement ######

features <- read.table("UCI HAR Dataset/features.txt")

## Get the columns with mean or std in their names

featuresDesired <- grep("-(mean|std)\\(\\)", features[, 2])

## Subset the desired columns

desiredSet <- fullSet[, featuresDesired]

## Change the column names

names(desiredSet) <- features[featuresDesired, 2]



###### 3. Use descriptive activity names to name the activities in the data set ######

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

## Update the labels with the proper activity names

fullLabels[, 1] <- activities[fullLabels[, 1], 2]

## Update the column name

names(fullLabels) <- "activity"



###### 4. Appropriately label the data set with descriptive variable names ######

## Update the column name

names(fullSubjects) <- "subject"

## Merge all the data into a single data set

desiredData <- cbind(desiredSet, fullLabels, fullSubjects)


###### 5. From the data set in step 4, creates a second, independent tidy data set with
#         the average of each variable for each activity and each subject. ######

# Note: the last two columns are activity and subject, so we only use columns 1-66
averages <- ddply(desiredData, .(subject, activity), function(x) colMeans(x[, 1:66]))


## Now we create the second independent data set

write.table(averages, "TidyData.txt", row.name = FALSE, quote = FALSE)
