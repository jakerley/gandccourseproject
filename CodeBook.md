##Getting and Cleaning Data Course Project Codebook
## Input
The input for the analysis is the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The data is in [getdata_projectfiles_UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The dataset files are described in the README.txt file in the zip file.

The specific files used are:

+ activity_labels.txt: The labels for the six different activities studied.
+ features.txt: The names of all the features/variables captured.
+ test: directory containing files from the test scenario.
  + X\_test.txt: The data from the test scenario (described in features_info.txt in the zip file).
  + Y\_test.txt: The activity indices for the test scenario.
  + subject_test.txt: The subject indicies for the test scenario.
+ train: directory containing files from the training scenario.
  + X\_train.txt: The data from the training scenario (described in features_info.txt in the zip file).
  + Y\_train.txt: The activity indices for the training scenario.
  + subject_train.txt: The subject indicies for the training scenario.

The Inertial Signals directories were not necessary for the project because the only
data requested was mean and standard deviation measurements.

## Data Analysis/Manipulation
The run_analysis.R performs the manipulation of the data and outputs the tidy data set.

The script does the following:

1. Checks for the existence of the aboive zip file and unzips it into the working directory.
2. Calls loadData to load the above files and perform the following manipulation on both the test 
and training data:
  1. Create a vector of activity factors (once only)
  1. Sets the names of the data using the feature names.
  2. names(xtestraw) <- features[,2]
  3. Remove all columns except mean and stdev measurements.
  4. Create a vector of "porettified" names using the prettyNames function (once only) which removes special characters and lowercases the names.
  5. Set the column names on the data to be the prettyfied names.
  6. Add a new subject column to the data using the subject indices.
  7. Add a new activity column using the activity indicies and the activity factor names.
3. Appends the training data to the test data using rbind.
4. Calls makeTidyDataSet with the combined data to create the tidy data set:
  1. Create a new avg object which containes the averages of the data by subject and activity using the aggregate function.
  2. Set the names for the subject and activity columns.
5. Write the new file to disk.

## Output
There are two versions of the same output file:

* _tidy.csv_ is in the [project repository](https://github.com/jakerley/gandccourseproject).
* _tidy.txt_ was uploaded as part of the project submission.

tidy.csv has 2 columns of identifiction factors( activity and subject) and 68 columns of average measurements.
It has 180 rows of data which are the averages acrosss activity and subject.
There are 30 numbered subjects and 6 activity levels:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

The averaged measurements mirror the orginal measurements and are the following:

Averaged mean of Body and gravity acceleration signals:
* tbodyaccmeanx
* tbodyaccmeany
* tbodyaccmeanz
* tgravityaccmeanx
* tgravityaccmeany
* tgravityaccmeanz

Averages of the mean of Jerk signals (derived from the body linear acceleration and angular velocity)

* tbodyaccjerkmeanx
* tbodyaccjerkmeany
* tbodyaccjerkmeanz
* tbodygyromeanx
* tbodygyromeany
* tbodygyromeanz
* tbodygyrojerkmeanx
* tbodygyrojerkmeany
* tbodygyrojerkmeanz


Average  of the means of the magnitude of the previous three-dimensional signals calculated using the Euclidean norm:
 
* tbodyaccmagmean
* tgravityaccmagmean
* tbodyaccjerkmagmean
* tbodygyromagmean
* tbodygyrojerkmagmean

Average of the means of Fast Fourier Transform (FFT) applied to the results.

* fbodyaccmeanx
* fbodyaccmeany
* fbodyaccmeanz
* fbodyaccjerkmeanx
* fbodyaccjerkmeany
* fbodyaccjerkmeanz
* fbodygyromeanx
* fbodygyromeany
* fbodygyromeanz
* fbodyaccmagmean
* fbodybodyaccjerkmagmean
* fbodybodygyromagmean
* fbodybodygyrojerkmagmean

Averaged standard deviation of Body and gravity acceleration signals:

* tbodyaccstdx
* tbodyaccstdy
* tbodyaccstdz
* tgravityaccstdx
* tgravityaccstdy
* tgravityaccstdz

Averages of the mean of Jerk signals (derived from the body linear acceleration and angular velocity)

* tbodyaccjerkstdx
* tbodyaccjerkstdy
* tbodyaccjerkstdz
* tbodygyrostdx
* tbodygyrostdy
* tbodygyrostdz
* tbodygyrojerkstdx
* tbodygyrojerkstdy
* tbodygyrojerkstdz

Average  of the means of the magnitude of the previous three-dimensional signals calculated using the Euclidean norm:

* tbodyaccmagstd
* tgravityaccmagstd
* tbodyaccjerkmagstd
* tbodygyromagstd
* tbodygyrojerkmagstd

Average of the standard deviations of Fast Fourier Transform (FFT) applied to the results.

* fbodyaccstdx
* fbodyaccstdy
* fbodyaccstdz
* fbodyaccjerkstdx
* fbodyaccjerkstdy
* fbodyaccjerkstdz
* fbodygyrostdx
* fbodygyrostdy
* fbodygyrostdz
* fbodyaccmagstd
* fbodybodyaccjerkmagstd
* fbodybodygyromagstd
* fbodybodygyrojerkmagstd
