Here you'll find the Run.Analysis.R script which depicts all steps made for the creation of a tidy dataset
of the data provided in the coursera

First the dataset was extracted from a website and saved in a folder
After it was unzipped and each of the datasets in the folder were assigned a name:

Features: List of all features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
Activity Labels: The list of all activities performed during the measurements
Subject Test: Contains observations of the test group 9/30 volunteers
x test: Contains all the test data of each feature
y test: Contains all the test data of each activity
Subject Train: Contains observations of the train group 21/30 volunteers
x train:Contains Contains all the train data of each feature
y test: Contains all the traindata of each activity

After assigning names to all datasets these were merged as follows:

X_Data contains all feature data for test and train groups
Y_Data contains all activity data for test and train groups
Subject_Data is the merged subject test and train data
Merged_Data is all three datasets combined

After merging the data, Extracted_Data was created selecting only the subject and code columns
with the mean and standard deviation for each measurement

The next step was to change the code column with the name of the activities in the data set
which were taken from the activity labels dataset

Then, using the gsub function, the dataset labels were changed to be more descriptive and readable

Finally, a Final Tidy Data set was created summerizing the Extracted_Data and grouping it by subject and activity.
Furthermore the mean was taken from each variable and the data was stored in a txt. file called Final Data Set.txt
