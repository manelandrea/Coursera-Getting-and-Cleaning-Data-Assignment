# Code Book

This code book reference to the variables used in creating the TidyData.txt

## Activity Labels

* `1` `WALKING` : subject was walking during the test
* `2` `WALKING_UPSTAIRS` : subject was walking up a staircase during the test
* `3` `WALKING_DOWNSTAIRS` : subject was walking down a staircase during the test
* `4` `SITTING` : subject was sitting during the test
* `5` `STANDING` : subject was standing during the test
* `6` `LAYING` : subject was laying down during the test

## Variables
* `subject_train` : loaded dataset from subject_train.txt
* `y_train` : loaded dataset from y_train.txt
* `x_train` : loaded dataset from X_train.txt
* `subject_test` : loaded dataset from subject_test.txt
* `y_test` : loaded dataset from y_test.txt
* `x_test` : loaded dataset from x_test.txt
* `subject_merge` : merged subject train and test
* `y_merge` : merged y train and test
* `x_merge` : merged x train and test
* `completeData` : merged subject, x and y datasets
* `meanSTD` : extract the column indices that have either mean or std in them.
* `cols` : add activity and subject columns to the list 
* `newData` : create newData with the selected columns in cols
* `featureNames`: load features table
* `activityLabels`: load activity labels
* `tidyData` : tidy data set with the average of each variable for each activity and each subject.
