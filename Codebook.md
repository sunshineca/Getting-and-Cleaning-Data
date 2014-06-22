## Getting and cleaning Data Course project -  Codebook 
###	This file describes the data, variables and performing procedures that I used to clean up the data.

- Download the data from the website: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The full description of this dataset is avaiable as this website 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

- run_analysis.R is the script to create a tidy dataset combining train and test data together. Each column has its descriptive invariable names. Finally, bases this clean dataset, a second, independent tidy data set with the average of each variable for each activity and each subject is extracted. This script works on the local dataset which is already downloaded from the web and was unzipped into local disk. This contains the following steps:	

1. Merges the training and the test sets to create one data set. Firstly set working directory to the location where the UCI HAR Dataset was downloaded, and read in the data from files including the train and test dataset. Then, names each column of train and test data. If the dimension of the train data match, combine the seperate training data files into a single training data by merging yTrain, subjectTrain, and xTrain. In the same way, combine the seperate test data files into a single test data by merging yTest, subjectTest, and xTest. Finally, create a final data set via combining training and test data together.

2. Extracts only the measurements on the mean and standard deviation for each measurement. Firstly, find the columns for means and standard deviations, and get rid of the unnecessary columns and set the names.

3. Use descriptive activity names to name the activities in the data set. Update the first colname name to "Activity" and in the mean while, update the colNames vector.

4. Appropriately label the data set with descriptive activity names. Firstly, clean the lable names with descriptive activity names, including: removed parentheses, expand prefixes, expand abbreviated words. Secondly, reassigning the new descriptive column names to the finalData set. The cleaned and merged data is outputed into file "merged_tidy_data.txt".

5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. The library "data.table" is used. Firstly, set the keys as "activity and subject", then summarize data basd on the keys. Finally, save the results in 'tidy-dataset-summarized.txt' with the average of each variable for each activity and each subject.

- Each variable are described in "features_info.txt", and fully listed in "features.txt".