# Getting and Cleaning Data  Course project

# Step 0 - Download the dataset

DataSetFileName <- "getdata_projectfiles_UCI HAR Dataset.zip" # filename of the whole dataset
if(!file.exists(DataSetFileName))  # if the dataset is not already downloaded, download it
{
        DataSetURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(DataSetURL, DataSetFileName)        
}
if(!file.exists("UCI HAR Dataset")) # if the dataset is not already unzipped, unzip it
{
        unzip(DataSetFileName)        
}

# Step 1 - Merges the training and the test sets to create one data set.

TrainingSet <- read.table("UCI HAR Dataset/train/X_train.txt") # load training set
TrainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt") # load training labels
TrainingSubject <- read.table("UCI HAR Dataset/train/subject_train.txt") # load training subject

TrainingData <- cbind(TrainingSet,TrainingLabels,TrainingSubject) # consolidate training data

TestingSet <- read.table("UCI HAR Dataset/test/X_test.txt") # load testing set
TestingLabels <- read.table("UCI HAR Dataset/test/y_test.txt") # load testing labels
TestingSubject <- read.table("UCI HAR Dataset/test/subject_test.txt") # load testing subject

TestingData <- cbind(TestingSet,TestingLabels,TestingSubject) # consolidate testing data

MergedDataSet <- rbind(TrainingData,TestingData) # merge training data with testing data

FeaturesNames <- read.table("UCI HAR Dataset/features.txt")[,2] # get column names for data set from features file
colnames(MergedDataSet) <- FeaturesNames # apply column names to  merged data set
colnames(MergedDataSet)[562] <- "label" # rename column with label data
colnames(MergedDataSet)[563] <- "subject" # rename column with subject data

# Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

SelectedColumns <- grep("mean|std|label|subject", names(MergedDataSet)) # extract number of each column that contains mean or std, including the label and subject columns
SelectedData <- MergedDataSet[,SelectedColumns] # extract the columns

# Step 3 - Uses descriptive activity names to name the activities in the data set

activityNames <- read.table("UCI HAR Dataset/activity_labels.txt") # load activity labels
labelColumn <- grep("label", names(SelectedData)) # get number of activity label column
SelectedData[,labelColumn] <- activityNames[SelectedData[,labelColumn],2] # update activity label column with activity names
colnames(SelectedData)[labelColumn] <- "activity" # renames label column as activity

# Step 4 - Appropriately labels the data set with descriptive variable names. 

# done just before step 2

# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

averageByActivityAndSubject <- ddply(SelectedData, .(subject, activity), function(x) colMeans(x[, 1:79])) # USES plyr PACKAGE to filter data by activity and subject and calculate the mean of the variable columns
write.table(averageByActivityAndSubject, file="tidyData.txt",row.names = FALSE) # write the data as required
