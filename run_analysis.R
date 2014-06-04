## Note: Set your working folder befor running the batch
## so that the script is in root of the folder
## and data is extracted in 'UCI HAR Dataset' subfolder

######################################################################################
## Start by reading common data from files
######################################################################################

###########################################
## Read features.txt

## this data set contains column names for xtest/xtrain data sets
urlfeatures <- "./UCI HAR Dataset/features.txt"
features <- read.csv(urlfeatures, header=FALSE, sep="")

###########################################
## Read activity_labels.txt

## this data contains labels for activities
urlactivity = "./UCI HAR Dataset/activity_labels.txt"
activity = read.csv(urlactivity, header=FALSE, sep="")
names(activity) <- c("id", "label")

######################################################################################
## Read test data sets
######################################################################################

###########################################
## Read x_test data set

## this data set contains measured data
urlxtest <- "./UCI HAR Dataset/test/X_test.txt"
xtest <- read.csv(urlxtest, header=FALSE, sep="")

## set xtest column names
names(xtest) <- features[,2]

###########################################
## Read y_test data set

## this dataset identifies activity performed by subject
urlytest <- "./UCI HAR Dataset/test/y_test.txt"
ytest <- read.csv(urlytest, header = FALSE)
names(ytest) <- c("activityid")

# merge ytest with activity labels to get pretty names
ytestactivity = merge(ytest, activity, by.x = "activityid", by.y="id", all=TRUE)

###########################################
## Read subject test data set

urlsubjecttest <- "./UCI HAR Dataset/test/subject_test.txt"
subjecttest <- read.csv(urlsubjecttest, header = FALSE)

###########################################
## Combine xtest, ytest to single test
test <- cbind(ytestactivity[,2], subjecttest, xtest)
names(test)[1] <- c("activity")
names(test)[2] <- c("subject")

###########################################
## We're only interested in mean and std columns

# get vector for columns names containing mean() and std()
m <- grep("mean\\(\\)", names(test))
s <- grep("std\\(\\)", names(test))
ms <- sort(c(1,2,m,s))

test <- test[,ms]

######################################################################################
## Read test data sets
######################################################################################

###########################################
## Read x_train data set

## this data set contains measured data
urlxtrain <- "./UCI HAR Dataset/train/X_train.txt"
xtrain <- read.csv(urlxtrain, header=FALSE, sep="")

## set xtrain column names
names(xtrain) <- features[,2]

###########################################
## Read y_train data set

## this dataset identifies activity performed by subject
urlytrain <- "./UCI HAR Dataset/train/y_train.txt"
ytrain <- read.csv(urlytrain, header = FALSE)
names(ytrain) <- c("activityid")

# merge ytrain with activity labels to get pretty names
ytrainactivity = merge(ytrain, activity, by.x = "activityid", by.y="id", all=TRUE)

###########################################
## Read subject train data set

urlsubjecttrain <- "./UCI HAR Dataset/train/subject_train.txt"
subjecttrain <- read.csv(urlsubjecttrain, header = FALSE)

###########################################
## Combine xtrain, ytrain to single train
train <- cbind(ytrainactivity[,2], subjecttrain, xtrain)
names(train)[1] <- c("activity")
names(train)[2] <- c("subject")

###########################################
## We're only interested in mean and std columns

# get vector for columns names containing mean() and std()
m <- grep("mean\\(\\)", names(train))
s <- grep("std\\(\\)", names(train))
ms <- sort(c(1,2,m,s))

train <- train[,ms]

######################################################################################
## Merge test and train data sets together and save to file clean_data.csv
######################################################################################

merged <- rbind(train, test)
write.csv(merged, "clean_data.txt")

######################################################################################
## Get the summary data
######################################################################################

## Calculate average values for each subject/activity
## Do this in a loop so each column is calculated

averages <- aggregate(merged[,3], list(subject=merged$subject, activity=merged$activity), mean)
names(averages)[3] <- names(merged)[3]
for (i in 4:dim(merged)[2]) {
  ai <- aggregate(merged[,i], list(subject=merged$subject, activity=merged$activity), mean)
  names(ai)[3] <- names(merged)[i]
  
  averages <- merge(averages, ai, by.x = c("subject", "activity"), by.y=c("subject", "activity"), all=TRUE)
}

write.csv(averages, "averages.txt")


