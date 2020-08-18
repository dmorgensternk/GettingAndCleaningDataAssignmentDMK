#Downloading the dataset and loading the data

library(dplyr)
file1<- "GettingAndCleaningDataFinal"

if(!file.exists(file1)){
  URL1<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL1, file1)
}
if(!file.exists("UCI HAR Dataset")){
  unzip(file1)
}

#Unzipping and reading all datasets into R

features<- read.table("UCI HAR Dataset/features.txt", 
                      col.names = c("n", "functions"))
activitylabels<- read.table("UCI HAR Dataset/activity_labels.txt", 
                            col.names = c("code", "activity"))
subject_test<- read.table("UCI HAR Dataset/test/subject_test.txt", 
                          col.names = ("subject"))
X_test<- read.table("UCI HAR Dataset/test/X_test.txt", 
                    col.names = features$functions)
Y_test<- read.table("UCI HAR Dataset/test/y_test.txt", 
                    col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names = "code")

#Merge Data Sets into one
X_Data <- rbind(x_train, X_test)
Y_Data <- rbind(y_train, Y_test)
Subject_Data <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject_Data, Y_Data, X_Data)

#Extract only the measurements on the mean and standard deviation

Extracted_Data<- Merged_Data %>% 
  select(subject, code, contains("mean"), contains ("std"))

#Uses descriptive activity names to name the activities in the data set

Extracted_Data$code<- activitylabels[Extracted_Data$code, 2]

#Appropriately labels the data set with descriptive variable names

names(Extracted_Data)[2]<- "activity" 
names(Extracted_Data)<- gsub("^t", "Time", names(Extracted_Data))
names(Extracted_Data)<- gsub("Acc", "Accelerometer", names(Extracted_Data))
names(Extracted_Data)<- gsub("BodyBody", "Body", names(Extracted_Data))
names(Extracted_Data)<- gsub("Gryo", "Gyroscope", names(Extracted_Data))
names(Extracted_Data)<- gsub("^f", "Frequency", names(Extracted_Data))
names(Extracted_Data)<- gsub("Mag", "Magnitude", names(Extracted_Data))
names(Extracted_Data)<- gsub("-mean()", "Mean", names(Extracted_Data))
names(Extracted_Data)<- gsub("tBody", "TimeBody", names(Extracted_Data))
names(Extracted_Data)<- gsub("-freq()", "Frequency", names(Extracted_Data))

#From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.

FinalDataSet<- Extracted_Data %>%
  group_by(subject, activity)%>%
  summarise_all(funs(mean))

write.table(FinalDataSet, "Final Data Set.txt", row.name=FALSE) 
