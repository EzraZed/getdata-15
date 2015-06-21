## README for run_analysis.R


The data used in this script is from the UCI HAR Dataset file.  This file should be in the working directory for the run_analysis.R scrip to function correctly.  

The following files from UCI HAR Dataset are used in this script:

UCI HAR Dataset/train/X_train.txt"
UCI HAR Dataset/train/y_train.txt"
UCI HAR Dataset/train/subject_train.txt"
UCI HAR Dataset/test/X_test.txt"
UCI HAR Dataset/test/y_test.txt"
UCI HAR Dataset/test/subject_test.txt"
UCI HAR Dataset/features.txt"

In addition, information from features_info was used in creating the script, though the file itself is never called.

For more information on this raw data, see the README and features_info files in the UCI HAR Dataset folder.

The purpose of run_analysis.R is to combine the above mentioned raw data sets, extract only the columns that contain information about the mean and standard deviation of the given measurements, and then find the mean for each subject doing each activity for each of these extracted columns.  As there are only 30 subjects and 6 activities, there will be 180 rows in the final data set.

The file run_analysis.R starts by taking the raw files and combined them into a data frame.  For each component, the train data and test data is stacked using rbind.

The X_train is combined with X_ test, giving all of the measurements in one data frame.  The features.text file is used to generate the headings for the this data 

Subject_train is combined with subject_test to get a list of all subjects.  The column is named "subject".

The y_train is combined with y_test, which shows numbers corresponding the activity being performed.  This column is renamed "activity".

These three sets are then combined into one data frame using cbind, with the subject as the first column, the activity as the second, and then the measurements from the X sets as the remaining columns.

Only the columns with mean or std are of interest, so only those are extracted.  Columns for mean frequency are ignored as frequency is not of interest for this analysis.

The activity column is altered using the gsub function so the the actual activity being performed is given instead of a number to represent each of the 6 activities.   

The aggregate function is used to get the mean of each feature for each subject doing each activity.  As aggregate alters the order of the final data set, the columns are rearranged back to subject/activity/etc...
