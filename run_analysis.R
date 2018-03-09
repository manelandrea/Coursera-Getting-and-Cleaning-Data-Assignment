
library(reshape2)

#load features table
featureNames <- read.table("features.txt")
#load activity labels
activityLabels <- read.table("activity_labels.txt", header = FALSE)
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
meanSTD <- grep(".*Mean.*|.*Std.*", featureNames[,2], ignore.case=TRUE)
meanSTD.names <-featureNames[meanSTD,2]

#TO DO NO. 3: Use descriptive activity names to name the activities in the data set
# update values with correct activity names
meanSTD.names = gsub('-mean', 'Mean', meanSTD.names)
meanSTD.names = gsub('-std', 'Std', meanSTD.names)
meanSTD.names <- gsub('[-()]', '', meanSTD.names)

train <- x_train[meanSTD]
train <- cbind(subject_train, y_train , train)
test <- x_test[meanSTD]
test <-  cbind(subject_test , y_test , test)
# merge datasets and add labels
newData <-rbind(train, test)
colnames(newData) <- c("subject", "activity", meanSTD.names)

newData[,1] <- as.factor(newData[,1])
#TO DO NO. 4: Appropriately label the data set with descriptive variable names.
names(newData)<-gsub("Acc", "Accelerometer", names(newData))
names(newData)<-gsub("Gyro", "Gyroscope", names(newData))
names(newData)<-gsub("BodyBody", "Body", names(newData))
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
# turn activities & subjects into factors
newData$activity <-  factor(newData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
newData$subject  <- as.factor(newData$subject)

newData.melted <- melt(newData, id = c("subject", "activity"))
newData.mean <- dcast(newData.melted, subject + activity ~ variable, mean)

write.table(newData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)
