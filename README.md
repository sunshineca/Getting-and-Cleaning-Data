## Getting and cleaning Data - Course project
###	run_analysis.R is the script to create a tidy dataset combining train and test data together. 
Each column has its descriptive invariable names. Finally, bases this clean dataset, a 
second, independent tidy data set with the average of each variable for each activity and each subject 
is extracted. This script works on the local dataset which is already downloaded from the web and was unzipped into local disk. 
This contains the following steps:	

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 