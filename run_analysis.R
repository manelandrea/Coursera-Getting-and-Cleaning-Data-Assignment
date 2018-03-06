
library(plyr)

# Read training data
subject_train <-  read.table("train/subject_train.txt", header = FALSE)
y_train <-  read.table("train/y_train.txt", header = FALSE)
x_train <-  read.table("train/X_train.txt", header = FALSE)

# Read test data
subject_test <-  read.table("test/subject_test.txt", header = FALSE)
y_test <-  read.table("test/y_test.txt", header = FALSE)
x_test <-  read.table("test/X_test.txt", header = FALSE)

#TO DO No. 1: Merge the training and the test sets to create one data set.
#create subject dataset
subject_merge <- rbind(subject_train,subject_test)
#create y dataset
y_merge <- rbind(y_train, y_test)
#create x dataset
x_merge <- rbind(x_train, x_test)

# correct column names
colnames(x_merge) <- t(featureNames[2])
colnames(y_merge) <- "Activity"
colnames(subject_merge) <- "Subject"
#merge all 
completeData <- cbind(x_merge,y_merge,subject_merge)

#TO DO No. 2: Extract only the measurements on the mean and standard deviation for each measurement.
meanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
cols <- c(meanSTD, 562, 563)
dim(completeData)

newData <- completeData[,cols]
dim(newData)

#TO DO NO. 3: Use descriptive activity names to name the activities in the data set
# update values with correct activity names
#load features table
featureNames <- read.table("features.txt")
#load activity labels
activityLabels <- read.table("activity_labels.txt", header = FALSE)
newData[,1] <- as.character(newData[,1])
for (i in 1:6){
  newData[,1][newData[,1] == i] <- as.character(activityLabels[i,2])
}

newData[,1] <- as.factor(newData[,1])
#TO DO NO. 4: Appropriately label the data set with descriptive variable names.
names(newData)<-gsub("Acc", "Accelerometer", names(newData))
names(newData)<-gsub("Gyro", "Gyroscope", names(newData))
names(extractedData)<-gsub("BodyBody", "Body", names(newData))
names(newData)<-gsub("Mag", "Magnitude", names(newData))
names(newData)<-gsub("^t", "Time", names(newData))
names(newData)<-gsub("^f", "Frequency", names(newData))
names(newData)<-gsub("tBody", "TimeBody", names(newData))
names(newData)<-gsub("-mean()", "Mean", names(newData), ignore.case = TRUE)
names(newData)<-gsub("-std()", "STD", names(newData), ignore.case = TRUE)
names(newData)<-gsub("-freq()", "Frequency", names(newData), ignore.case = TRUE)
names(newData)<-gsub("angle", "Angle", names(newData))
names(newData)<-gsub("gravity", "Gravity", names(newData))

#TO NO. 5: From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.
newData$Subject <- as.factor(newData$Subject)
newData$Activity <- as.factor(newData$Activity)
tidyData <- aggregate(. ~Subject + Activity, newData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "TidyData.txt", row.names = FALSE)