
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
