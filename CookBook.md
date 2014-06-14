# Cook Book #

This file contains description of:
- original raw data set
- variables in clean data set
- run instructions for reproduction of data cleaning
- transformation steps applied to raw data to obtain clean data set

## Original data set ##

Original data set was obtained from following link:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Description of raw data is provided by its authors in the linked file.

## Clean data description ##

### Clean data ### 

Each data row contains ordinal number of each record and basic infomation about activity and subject of measurement:

activity - activity performed by subject during measurement. Possible values are WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING

subject - number identifying subject performing activity for measurement

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

mean(): Mean value std(): Standard deviation

Data set contains data measure in both train and test phases of project.

### Averages ###

File contains calculated averages based on clean data set for each activity/subject combination.

Average is calculated for each value included in clean data. For their detailed desciprtion see section above.

## Run instructions ##

To reproduce results of this project you'll need to:
1. Download zip file from the link provided in Original data set section
2. Extract raw data zip it to the working directory of your R Studio
3. Download run_analysis.R from this repository to working folder of your R Studio
4. Run run_analysis.R code in R Studio
5. This creates two new files in working directory - clean_data.txt & averages.txt

## Transformations performed ##

Additional information on script internals can be found in detailed comments in the run_analysis.R script itself.

In short, following steps were performed:

* Read features.txt
* Read activity_labels.txt
* Read x_test.txt
* Read y_test.txt
* Read subject_test.txt
* Combine x_test and y_test data to single data set test - only include mean and std columns
* Read x_train.txt
* Read y_train.txt
* Read subject_train.txt
* Combine x_train and y_train data to single data set train - only include mean and std columns
* Merge data from train and test data sets into single clean data set
* Save it in clean_data.txt
* Calculated averages from clean data and save it to averages.txt

