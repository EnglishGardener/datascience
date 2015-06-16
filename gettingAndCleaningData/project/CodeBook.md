---
title:  Getting and Cleaning Data - Project CodeBook 
author: "English Garden"
date: "June 15, 2015"
output: html_document
---
=================================================


This codebook describes the variables and the steps performed in the run_analysis.R to clean up the data. 

### Input data
* The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* The data for the project is downloaded from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

### Cleaning the data

We perform the following steps in the run_analysis.R script to clean the data and generate a second independent clean dataset. 

Task 1: Merges the training and the test sets to create one data set.

 1. Read the data files associated with training set: X_train.txt, y_train.txt and subject_train.txt from the "./UCIHARDataset/train" folder and store them in *trainData*, *trainLabel* and *trainSubject* variables respectively.   
 
 2. Read the data files associated with the testing set: X_test.txt, y_test.txt and subject_test.txt from the "./UCIHARDataset/test" folder and store them in *testData*, *testLabel* and *testsubject* variables respectively.  
 
 3. Row-bind the *testData* to *trainData* to generate a 10299x561 data frame, *joinData*; concatenate *testLabel* to *trainLabel* to generate a 10299x1 data frame, *joinLabel*; concatenate *testSubject* to *trainSubject* to generate a 10299x1 data frame, *joinSubject*.  
 
Task 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
 
 4. Read the features.txt file from the "/UCIHARDataset" folder and store the data in a variable called *featureSet*. Select the measurements on the mean and standard deviation and store the selected indices as *meanStdIndices*, containing 66 indices. Using the 66 indices, we select the corresponding 66 columns from *joinData* to form the *joinDataSelect*, containing 10299 rows and 66 columns. 
 
 5. Clean the column names of the subset, by removing the "()" and "-" symbols in the names, and capitalising the first alphabet of "mean" and "std" in each name.   
 
 Task 3: Uses descriptive activity names to name the activities in the data set
 
 6. Read the activity_labels.txt file from the "./UCIHARDataset"" folder and store the data in a *activity* variable. 
 
 7. Clean the activity names in the second column of *activity*. Make all activity names to lower cases. Remove the underscore between letters in the name, if there is one and capitalize the alphabet immediately after the underscore.  
 
 Task 4: Appropriately labels the data set with descriptive variable names. 
 
 8. Transform the values of *joinLabel* according to the *activity* data frame.  
 
 9. Combine the *joinSubject*, *joinLabel* and *joinData* by column to get a new *cleanData* with 10299x68 dimension. The "subject" column contains integers representing subject ID ranging from 1 to 30 inclusively. The "activity" column contains 6 activity names. The last 66 columns are made up of measurements or features.  
 
 10. Write the *cleanData* out to "merged_cleaned_data.txt" file in current working directory.  

Task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 11. Based on the data cleaning described above, we know there are 30 unique subjects, 6 unique activities per subject. For each activity per subject we compute the mean of each feature for all 66 features. We loop through all the subjects with i as the i-th subject from the 30 subjects. As an inner loop, for each subject, we loop through all the activities to compute the means of all features. We initialise the *result* data frame with the NumSubject*NumActivity as number of rows and NumColumn as the number of columns. After these two layered for loop, we fill the *result* dataframe (180*68) with newly computed results.
 
 12. Write the *result* out to "dataset_with_means.txt" file in current working directory. 