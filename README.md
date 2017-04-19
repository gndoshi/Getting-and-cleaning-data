# Getting-and-cleaning-data
Course Project for the Coursera class - Getting and Cleaning Data
=====================4===============================================
Gautam Doshi
====================================================================
The purpose of this project is to generate a tidy data set that meets and follows the principles provided on Coursera. 

The UCI Human Activity Recognition Using Smartphones dataset was provided with multiple data sources. There were 561 measurements taken of a single volunteer performing each of the 6 activities. These measurements were taken multiple times. In total, there were 30 Volunteers and each of them performed 6 physical activities which are further described below. Coming back to the data sources; they are: 
(a) The training set containing the measurements of each feature. 
(b) The test set containing the measurements of each feature. 
(c) The Activity labels (for eg: Standing, Walking, Laying, etc.)
(d) subject_train: The identifier of the volunteers corresponding to the measurements
(e) subject_test : The identifier of the volunteers corresponding to the test data measureents 
(f) y_train and y_test: Which contains the identifier of the activity performed the corresponding descriptions to which are contained in te Activity labels file. 
(g) features: which contains the variables of the measurements taken. 

========================================================================

The script provided generates the tidy dataset and this could be divided into 4 general portions: 
(1) Reading the data sources: Multiple data tables have been read into the R-environment to check their dimensions. This provides the user with a better understanding of how the data was collected and how it aligns together. 
The feature names have been imported too and following this, the variable names of the 561-feature vectors have been renamed to the corresponding feature names. (before renaming, the variable names were V1, V2,..etc.)

(2) Extracting only the measurements on the mean and Standard Deviation for each measurement: 
The use of "grep()" to get the indices of the column names (which were renamed in the previous step) was essential. 
Using this vector of indices, the measurements data (2 in number) is now subsetted and a new data set is generated which contains the mean and the Standard Deviation of each measurement. 

(3) Activity labels and Merging the data: 
The y_train and the y_test columns have been merged using 'rbind()' to create one 10299-dimensional column vector where each value is the identifier of the activity performed. 
Now, on this column vector (which is treated like a dataset), through a series of for loops and conditional programming while considering the activity_labels dataset (imported earlier on), a new variable is created which corresponds to the activity label (standing, walking, etc.) to the identifier in adjacent column. 

Before and after the conditional programming step, the training and test data has been merged using rbind(). Also, once all the neccessary rows are merged, columns of these intermediary data sets have been merged to create the Final dataset namely, final_data. 

(4) Now to create an independent data set with the average of each variable for each activity and each subject, the use of the 'dplyr' package has been called. Through the pipeline command and grouping the data by the 'Volunteer_Num' and 'Activity', the desired tidy data set that meets the goals of the project is generated. (For this I had to first acquire the knowledge of the 'summarise_all' statement within the dplyr package). 
