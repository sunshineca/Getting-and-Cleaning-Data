## This script include the works as below:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


## 1. Merges the training and the test sets to create one data set.


# set working directory to the location where the UCI HAR Dataset was downloaded
setwd('/Users/zhixian.yan/Desktop/jing/dataclean')

# Read in the data from files
featurenames <- read.table('./features.txt')
activityType <- read.table('./activity_labels.txt')

# Read in the train and test dataset
subjectTrain <- read.table('./train/subject_train.txt') 
xTrain <- read.table('./train/x_train.txt')
yTrain <- read.table('./train/y_train.txt')

subjectTest <- read.table('./test/subject_test.txt') 
xTest <- read.table('./test/x_test.txt') 
yTest <- read.table('./test/y_test.txt')

# names each column of train and test data
colnames(subjectTrain) <- "subjectId";
colnames(xTrain) <- featurenames[,2]; 
colnames(yTrain) <- "activityId";

colnames(subjectTest) <- "subjectId";
colnames(xTest) <- featurenames[,2]; 
colnames(yTest) <- "activityId";

# test the dimension of the train data match or not
if ( length(yTrain) != length(subjectTrain) || length(yTrain) != dim(xTrain)[1] ) {
        stop('dimensions of train data set inputs do not match')
}

# Combine the seperate training data files into a single training data by merging yTrain, subjectTrain, and xTrain
trainingData <- cbind(yTrain,subjectTrain,xTrain);

# test the dimension of the test data match or not
if ( length(yTest) != length(subjectTest) || length(yTest) != dim(xTest)[1] ) {
        stop('dimensions of test data set inputs do not match')
}

# Combine the seperate test data files into a single test data by merging yTest, subjectTest, and xTest
testData <- cbind(yTest,subjectTest,xTest)

# Create a final data set via combining training and test data together
finalData <- rbind(trainingData,testData)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# Find the columns for means and standard deviations
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", featurenames[, 2])

# Get rid of the unnecessary columns and set the names
finalData <- finalData[, meanStdIndices]


# 3. Use descriptive activity names to name the activities in the data set

activityType[, 2] <- gsub("_", "", tolower(as.character(activityType[, 2])))
finalData[,1] <- activityType[finalData[,1], 2]
# Update the first colname name to "Activity"
colnames(finalData)[1] <- "Activity"
# Update the colNames vector 
colNames  <- colnames(finalData); 


# 4. Appropriately label the data set with descriptive activity names. 

# clean the lable names with descriptive activity names

# Removed parentheses
clean <- gsub('*[()]', '', colNames)

# Expand prefixes
clean <- gsub('^t', 'time.', clean)
clean <- gsub('^f', 'freq.', clean)

# Expand abbreviated words
clean <- gsub('Acc', 'Acceleration', clean)
clean <- gsub('Mag', 'Magnitude', clean)

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) <- clean

# Output the cleaned data 
# write.table(finalData, "merged_tidy_data.txt")

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(data.table)
mergedData <- read.table('merged_tidy_data.txt')
dt <- data.table(mergedData)
# Set the keys
keys <- c('Activity', 'subjectId' )
setkeyv(dt, keys)

# Summarize data basd on activity and subject
sumfinalData <- dt[, lapply(.SD, mean), by=key(dt)]

# Save the results with the average of each variable for each activity and each subject
write.table(sumfinalData, file='tidy-dataset-summarized.txt')

