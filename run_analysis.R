## Getting and Cleaning Data - Course Project
setwd() #Where ever you downloaded and stored the data. 

#Reading the data and seeing how the dimensions match up

#Reading in the measurements

trial_run <- read.table('./train/X_train.txt')
trial_run2 <- read.table('./test/X_test.txt')

#Reading in the feature names. 

feature_names <- read.table('./features.txt')
feature_names$V2 <- as.character(feature_names$V2)

#Renaming the column names of the measurements

names(trial_run) <- feature_names$V2
names(trial_run2) <- feature_names$V2

#Reading the Subject and Activity Labels

subject_traindata <- read.table('./train/subject_train.txt')
subject_testdata <- read.table('./test/subject_test.txt')

y_train <- read.table('./train/y_train.txt')
y_test <- read.table('./test/y_test.txt')

# After just seeing through the data the 'subject_train" and "subject_test"
#data set contain the Volunteer ID #'s (running from 1-30) and the "y_train"
# and "y_test" data sets contain the Activity labels (labelled 1 - 6) for each 
# observation of the training and test data set. Getting a clearer idea now.

#Extracting only the measurements on the mean and the SD for each measurement: 

indices <- grep("mean()*|std()*", feature_names$V2)

extracted_measurements <- trial_run[, indices] 
 
extracted_test <- trial_run2[, indices]

#Confirming the range of activity labels: 

unique(y_test$V1) 
unique(y_train$V1)

merged_activities <- rbind(y_train, y_test)

activity_labels <- read.table('./activity_labels.txt')
activity_labels$V2 <- as.character(activity_labels$V2)

#Creating a new variable which describes the Activity performed through For Loop

merged_activities$activity_label <- NULL
merged_activities$activity_label <- as.character(merged_activities$activity_label)

for(i in 1:dim(merged_activities)[1]) {
  for(j in 1:6){
    if(merged_activities[i,1] == activity_labels[j,1])
    merged_activities$activity_label[i] <- activity_labels[j,2]
  }
}

#Merging the train and test data for each type. 

volunteer_num <- rbind(subject_traindata, subject_testdata)

measurements <- rbind(extracted_measurements, extracted_test)

final_data <- cbind(volunteer_num, merged_activities[,2], measurements)

#Changing the column names of the first two columns: 

colnames(final_data)
colnames(final_data)[1] <- "Volunteer_Num"
colnames(final_data)[2] <- "Activity"
View(final_data)

#Independent data set with the average of each variable for each activity and 
# each subject. 

library(dplyr)

new_data <- final_data %>%
  group_by(Volunteer_Num, Activity) %>%
  summarise_all( funs(mean))
 
 View(new_data)
 
 ## ====== END ================
