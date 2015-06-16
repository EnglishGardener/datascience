This readme file describes how run_analysis.R script works.

1. Download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, rename the folder as "UCIHARDataset".

2. Make sure the folder "UCIHARDataset" and the run_analysis.R script are both in the current working directory.

3. Run source("run_analysis.R") command in RStudio. 

4. This generates two output files in the current working directory: "merged_cleaned_data.txt" containing a data frame cleanData with 10299\*68 dimension; "dataset_with_means.txt" containing a result data frame with 180\*68 dimension. This final dataset contains 180 rows for 30 subjects, 6 activities per subject. Each row also contains the average of each feature per activity per subject and there are 66 features in total. 