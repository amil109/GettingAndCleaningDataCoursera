## This script will merge, average (and find std dev), provide
## human readable names for the activities recorded, and
## label all variables. From this a new txt data file will
## be created.

## First we check which OS we are using

if(.Platform$OS.type=="windows"){
    test_dir <- ".\\UCI HAR Dataset\\test\\"
    train_dir <- ".\\UCI HAR Dataset\\train\\"
    UCI_dir <- ".\\UCI HAR Dataset\\"
} else {
    test_dir <- "./UCI HAR Dataset/test/"
    train_dir <- "./UCI HAR Dataset/train/"
    UCI_dir <- "./UCI HAR Dataset/"
}

## Next, we pull the training and test data sets
Xtest <- read.table(paste(test_dir,"X_test.txt",sep=""))
ytest <- read.table(paste(test_dir,"y_test.txt",sep=""))
Xtrain <- read.table(paste(train_dir,"X_train.txt",sep=""))
ytrain <- read.table(paste(train_dir,"y_train.txt",sep=""))

# Now get the column names:
column_names <- read.table(paste(UCI_dir,"features.txt",sep=""))[,2]

# Pull in the activity and test names:
activity_names <- read.table(paste(UCI_dir,"activity_labels.txt",sep=""))
test_subjects <- read.table(paste(test_dir,"subject_test.txt",sep=""))[,1]
train_subjects <- read.table(paste(train_dir,"subject_train.txt",sep=""))[,1]
colnames(activity_names) <- c("REF","ACTIVITY")
test_labels <- merge(ytest, activity_names, by.x = "V1", by.y = "REF", all.x = TRUE)[,2]
train_labels <- merge(ytrain, activity_names, by.x = "V1", by.y = "REF", all.x = TRUE)[,2]


# Then apply them:
colnames(Xtest) <- column_names
colnames(Xtrain) <- column_names
Xtest$Activty_Name <- test_labels
Xtrain$Activty_Name <- train_labels
Xtest$Subject <- test_subjects
Xtrain$Subject <- train_subjects

Xfulldata <- rbind(Xtest,Xtrain)

## Next, we extract only the mean and standard deviation
## for each measurement
meanref <- grep("mean", column_names, ignore.case = TRUE)
stdref <- grep("std", column_names, ignore.case = TRUE)
# Columns 562 and 563 are the activity name and subject
ref <- c(stdref,meanref,562:563)

Xfiltered <- Xfulldata[,ref]

## Finally, we write the data to a text file and store it
write.table(Xfiltered, "tidydata.txt")

## Clean up the workspace
# rm(list = ls())
