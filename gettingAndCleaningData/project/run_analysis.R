### Task 1: Merges the training and the test sets to create one data set.
setwd("~/datascience/gettingAndCleaningData/project")

## training data
trainData <- read.table("./UCIHARDataset/train/X_train.txt")
head(trainData)
dim(trainData) # 7352*561
trainLabel <- read.table("./UCIHARDataset/train/y_train.txt")
table(trainLabel) 
#   1    2    3    4    5    6 
#1226 1073  986 1286 1374 1407
trainSubject <- read.table("./UCIHARDataset/train/subject_train.txt")
dim(trainSubject) #7352*1

## test data
testData <- read.table("./UCIHARDataset/test/X_test.txt")
head(testData)
dim(testData) # 2947*561

testLabel <- read.table("./UCIHARDataset/test/y_test.txt") 
table(testLabel) 
#  1   2   3   4   5   6 
# 496 471 420 491 532 537 
testSubject <- read.table("./UCIHARDataset/test/subject_test.txt")
dim(testSubject) #2947*1

## merge the data
joinData <- rbind(trainData, testData)
dim(joinData) # 10299*561
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) # 10299*1
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # 10299*1

### Task 2: Extracts only the measurements on the mean and standard deviation for each measurement.

featureSet <- read.table("./UCIHARDataset/features.txt")
dim(featureSet)  # 561*2
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", featureSet[, 2])
length(meanStdIndices) # 66
joinDataSelect <- joinData[, meanStdIndices]
dim(joinDataSelect) # 10299*66
names(joinDataSelect) <- gsub("\\(\\)", "", featureSet[meanStdIndices, 2]) # remove "()"
names(joinDataSelect) <- gsub("-", "", names(joinDataSelect)) # remove "-" in column names 
names(joinDataSelect) <- gsub("mean", "Mean", names(joinDataSelect)) # capitalize M
names(joinDataSelect) <- gsub("std", "Std", names(joinDataSelect)) # capitalize S

### Task 3: Uses descriptive activity names to name the activities in the data set
activity <- read.table("./UCIHARDataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
#"walkingupstairs" -> "walkingUpstairs"
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
#"walkingdownstairs" -> "walkingDownstairs"
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

### Task 4: Appropriately labels the data set with descriptive variable names. 

activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"
names(joinSubject) <- "subject"
cleanData <- cbind(joinSubject, joinLabel, joinDataSelect)
dim(cleanData) # 10299*68
write.table(cleanData, "merged_cleaned_data.txt") # write out the 1st dataset

### Task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

NumSubject <- length(table(joinSubject)) # number of subjects is 30
NumActivity <- dim(activity)[1] # number of activies is 6
NumColumn <- dim(cleanData)[2] # number of columns is 68
result <- matrix(NA, nrow=NumSubject*NumActivity, ncol=NumColumn) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanData)
row <- 1
# loop through all the subjects with i as the i-th subject from the 30 subjects
for(i in 1:NumSubject) { 
      # for each subject, loop through all the activities
      for(j in 1:NumActivity) { 
            result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
            result[row, 2] <- activity[j, 2]
            bool1 <- i == cleanData$subject
            bool2 <- activity[j, 2] == cleanData$activity
            result[row, 3:NumColumn] <- colMeans(cleanData[bool1&bool2, 3:NumColumn])
            row <- row + 1
      }
}
head(result)
write.table(result, "dataset_with_means.txt") # write out the 2nd dataset

#data <- read.table("./dataset_with_means.txt")
#dim(data) # 180 * 68
#head(data)
#dataset_with_means.txt contains records for 30 subjects, 6 activities each; 180 rows for data entries, 66 features for each entry. 

