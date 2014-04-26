===============================================================================
ABOUT THE SCRIPT
===============================================================================

PRE-REQUISITES
---------------------------------------------------------------------------------------------------------------
1) To work the script needs the "UCI HAR Dataset" folder containing the Samsung dataset to be placed in the Working Directory (e.g. "C:/wd/UCI HAR Dataset").

2) The following packages must be installed: (i) plyr, (ii) reshape2

--------------------------------------------------------------------------------------------------------------
HOW DOES THE SCRIPT WORK?
--------------------------------------------------------------------------------------------------------------
Basically, the script performs the following functions:

- Reads the files "UCI HAR Dataset/test/X_test.txt", "UCI HAR Dataset/test/y_test", "UCI HAR Dataset/test/subject_test" for the test set. 
  The same applies for train set.

- It renames  the "X_test" and "X_train" dataframes' columns using the information in "UCI HAR Dataset/features.txt". 

- It drops the columns in the "X_test" and "X_train" dataframes that do not consist in mean() or std() measurements. 

- It replaces activity indexes in the "y_test" and "y_train" dataframes with the activity labels that apply to each 
  number using the information in "UCI HAR Dataset/activity_labels.txt"

- Merges the modified "X_test", "y_test" and "subject_test" dataframes to create a merged_test dataframe. 
  The same applies to the train set. 

- The merged dataframes for test and train are bind together to create an all-inclusive dataframe ("AIDF").

- The AIDF is melted with the id columns "Activity" and "Subject_ID" and the measurements as variables.

- Using the dcast function on the melted AIDF, the final tidy data set is generated. The tidy data set contains the average of each of 
  the measurements per Activity and Subject_ID.

- The final tidy dataset is written down to the text file "tidy_dataset.txt" in the Working Directory.

