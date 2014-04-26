library(plyr)
library(reshape2)

# We read the information on the x_test and x_train data.

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

# We label the columns with the information available in the features file.
# This requires reading the features file.

column_labels <- read.table("UCI HAR Dataset/features.txt")
column_labels <- column_labels$V2
colnames(x_test) <- column_labels
colnames(x_train) <- column_labels

# We subset the columns where the variables are mean() and std()

x_test <- x_test[,c(grep("mean()",colnames(x_test),fixed=TRUE),grep("std()",colnames(x_test),fixed=TRUE))]
x_train <- x_train[,c(grep("mean()",colnames(x_train),fixed=TRUE),grep("std()",colnames(x_train),fixed=TRUE))]

#We read the activity indicators for each set

test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")

#We join the activity indicators with the activity labels, and then just keep the labels.

test_activity <- join(test_activity,activity_names,by = "V1")
test_activity <- test_activity$V2

train_activity <- join(train_activity,activity_names,by = "V1")
train_activity <- train_activity$V2

#We get the subject id

test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

# To later identify the source set, we generate two vectors indicating the set name.

set_test <- rep("test",nrow(x_test))
set_train <- rep("train",nrow(x_train))

# We merge the set name, subject ID, the activity labels, and the measurents for each set.
 

test_merged <- cbind(set_test,test_subject,test_activity,x_test)
train_merged <- cbind(set_train,train_subject,train_activity,x_train)

#We name the columns that contain the set name, Subject IDs and the Activity labels.

colnames(test_merged)[1] <- "Set"
colnames(train_merged)[1] <- "Set"
colnames(test_merged)[2] <- "Subject_ID"
colnames(train_merged)[2] <- "Subject_ID"
colnames(test_merged)[3] <- "Activity"
colnames(train_merged)[3] <- "Activity"

#We merge the data in one big merged data_set

merged_dataset <- rbind(test_merged,train_merged)

#Now we proceed to reshape as requested for the tidy data set

tidy_dataset <- melt(merged_dataset, id=c(1:3),measure.vars=-c(1:3))
tidy_dataset <- dcast(tidy_dataset,Activity + Subject_ID ~ variable,mean)

#We modify the names of the column to reflect that is the mean of pre-existing variable.

for (i in 3:ncol(tidy_dataset)){colnames(tidy_dataset)[i] <- (paste("mean(",colnames(tidy_dataset)[i],")",sep = ""))}

write.table(tidy_dataset,"tidy_dataset.txt", sep="\t", row.names = FALSE)

## WE ARE DONE! Please find the tidy data set in the file "tidy_dataset.txt" available at your WD.