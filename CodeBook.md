Human Activity Recognition Using Smartphones Data Set:
 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
The data is downloaded from:
 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Those files are used:

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The R code does the following:

- checks for the presence of the data set and downloads it if necessary
- creates training data by consolidating the training set file with the training labels file and the training subjects file
- creates test data by consolidating the test set file with the test labels file and the test subjects file
- merges the training data with the test data
- renames the columns of the merged data using the features file
- extracts from the merged data the columns that contain mean or standard deviation data, including the subject and activity columns
- substitutes the label numbers in the extracted data by the corresponding activity names according to the 'activity_labels.txt' file
- uses the data after all the steps above as input to filtering by activity and subject and calculating the mean of the columns (plyr package is required)
- creates a file called "tidyData.txt" with the output
