##An R script for Project in GetData coursera course 

run_analysis.r

tested and created in R-3.1.1
using RStudio Version 0.98.953
in Windows 7 Home Premium

###Folders and data
Before exectuting the code make sure that all files are placed where code expects to find them or modify the code

0.1) The data files submitted with the Project are placed in
and the folder "C:/Coursera/Get data/Project/UCI HAR Dataset"
contains files 
"activity_labels.txt" describing the activities (1 Walking, 2...) 
and "features.txt" describing what each column mean in data sets X_test.txt and X_train.txt

0.2) with subfolder /train containg files X_train.txt - data, Y_train.txt which contains activities for each row in X_train,
and subject_train.txt which contains subjectID for each row in X_train.txt

0.3) with subfolder /test containg files X_test.txt - data, Y_test.txt which contains activities for each row in X_test,
and subject_test.txt which contains subjectID for each row in X_test.txt

### Comments about the script
1. The script does the following
1.1 sets working directory to"C:/Coursera/Get data/Project/UCI HAR Dataset")
1.2 Read activity labels, features
1.3 Read and combine by rows (rbind) X_train and X_test into X_full, Y_train and Y_test into Y_full, subj_train and subj_test into subj_full datasets
1.4 Names the column in X_full data set using names from features.txt
1.5 Filters the list of columns ("features") for columns which names has "std" or "mean" but do not have "meanfreq" as part of their name and
copies all relevant data to X_full_sub dataset
1.5 Merges subject_full, activity and X_full_sub into one tidy data frame
1.6 Saves Full_set to "full_set.csv"
Note: steps 1.1 to 1.6 are rather lengthy and for that reason step script can be restarted from step 2.1 using "full_set.csv" as an initial point given
 that this file was created already

2.1 download dplyr library
2.2 Read the "full_set.csv" into Full_set table
2.3 Filter out all columns which does does not have SubjectID or Activity or mean as part of their name into new table Full_mean_set (35 columns including subjectID and Activity)
2.4 Group Full_mean_set by SubjectID and Activity
2.5 Perform averaging of all variables for each subject(30) and each activity(6) - in total 180 combinations by summarise_each function from dplyr
2.6 Save results to text file "subject_activity_mean_values.txt"
