# Getting And Cleaning Data Course Project
Repository for the Getting and Cleaning Data Course Project

This repository contains a script which will read, label and filter the raw data from the movement study data.

The script should be placed in a directory containing the 'UCI HAR Dataset' folder. The resulting tidy data set will be saved as 'tidydata.txt'.

The script functions by first finding out the operating environment, and creating variables with the paths to the required folders. This is needed so the script will work in both Windows and OSX/*nix. The code has only been tested on Windows.

The next operation is reading in the test and training data using read.table().

The column names are then read in from 'features.txt', and stored as a vector. 

Activity names and their reference number are read in from 'activity_labels.txt'.

Subject numbers for the test and training data sets are read in from 'subject_test.txt' and 'subject_train.txt'.

The activity_names dataframe is then given column names for ease of understanding, but this is not strictly necessary - the names are only used to merge the data with the test types.

Merging the activity names and the ytest and ytrain data is the next step. A merge method was used that matches a the human readable name (ACTIVITY) to the y values (REF).

Next, the columns of Xtest and Xtrain are labelled using the column_names vector read in earlier.

After this, the activity name and subject columns are appended to the Xtest and Xtrain data frames.

Immediately after this, the two data frames are combined using rbind.

In order to pull out the mean and std deviation related variables only, a reference vector is created using the grep function to find any column names with 'mean', then any with 'std'. These two vectors are combined, then the last two columns (activity name and subject (562, 563)) are appended. The data is filtered by applying this vector to the combined data set.

The write.table() command is used to write this filtered data frame to 'tidydata.txt'.

The script contains a line to clean up the workspace that is commented by default, but if the user wished to clean up their workspace and free up memory after the import, they can do this by uncommenting the last line.
