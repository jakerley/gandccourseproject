## Getting and Cleaning Data May 2014 Course Project
## This script:
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive activity names. 
## 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Constant names
zipFileName = "getdata_projectfiles_UCI HAR Dataset.zip"
zipFolder <- "UCI HAR Dataset"

## Simple function to pretty up column names
prettyNames <- function(x) {
  names <- gsub( "\\)","", names(x))
  names <- gsub( "\\(","", names)
  names <- tolower(gsub( "-","", names) )
}

## Function to load and clean the data
loadData <- function ( zipFileName) {
  unzip( zipFileName)
  ## Read the activity labels
  activities <- read.table( paste( zipFolder,"/activity_labels.txt", sep = ""))
  activityList <- activities[[2]]
  ## Read the feature names
  features <- read.table( paste( zipFolder,"/features.txt", sep = ""))
  ## Read the feature names for the test scenario
  testLabels <- read.table( paste( zipFolder,"/test/Y_test.txt", sep = ""))  
  ## Read the subjest IDs for the test scenario  
  testSubjects <- read.table( paste( zipFolder,"/test/subject_test.txt", sep = ""))
  ## Read the results for the test scenario    
  xtestraw <- read.table( paste( zipFolder,"/test/X_test.txt", sep = ""))
  ## Set the column names from the list of features
  names(xtestraw) <- features[,2]
  ## Remove all columns excpet mean and stdev
  xtest <<- xtestraw[ c(grep("mean\\(", names(xtestraw)),grep("std\\(", names(xtestraw)))]
  ## Create a vector of "porettified" names
  names <- prettyNames( xtest)
  ## Set the column names for the test scenario
  names(xtest) <<- names
  ## Set the subject column
  xtest$subject <<- factor(testSubjects[[1]])
  ## Set the activity column the activity factors
  xtest$activity <<- factor( testLabels[[1]], 1:6, activityList)  
  
  ## Read the feature names for the training scenario
  trainLabels <- read.table( paste( zipFolder,"/train/Y_train.txt", sep = ""))    
  ## Read the subjest IDsfor the training scenario  
  trainSubjects <- read.table( paste( zipFolder,"/train/subject_train.txt", sep = ""))  
  ## Read the results for the training scenario      
  xtrainraw <- read.table( paste( zipFolder,"/train/X_train.txt", sep = ""))
  ## Set the column names from the list of features
  names(xtrainraw) <- features[,2]
  ## Remove all columns excpet mean and stdev
  xtrain <<- xtrainraw[ c(grep("mean\\(", names(xtrainraw)),grep("std\\(", names(xtrainraw)))]  
  ## Set the column names for the training scenario
  names(xtrain) <<- names
  ## Set the subject column  
  xtrain$subject <<- factor(trainSubjects[[1]])
  ## Set the activity column the activity factors
  xtrain$activity <<- factor( trainLabels[[1]], 1:6, activityList)
}

## Create and return the tidy data set per requirements
makeTidyDataSet <- function(x) {
  avg <- aggregate( x[1:66], by = list(x$activity,x$subject), mean)
  names(avg)[1] <- "activity"
  names(avg)[2] <- "subject"
  avg
}

## Main routine
##  Look for zip file. It is assumed ot be in the working directory
## If it isn't there exit with a message.
if( !file.exists( zipFileName)) {
  print(c("Missing file: ", zipFileName))
} else {
  ## Load and clean the data
  loadData( zipFileName)
  ## Combine the the data sets
  mergedData <- rbind( xtest, xtrain)
  ## Create the tidy data set
  tidyData <- makeTidyDataSet( mergedData)
  ## Create a csv file of the tidy data set
  ## write.csv uses way too much memory
  write.table(tidyData, file="tidy.csv", sep=",")
}