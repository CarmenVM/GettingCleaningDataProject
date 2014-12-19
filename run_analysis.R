##You should create one R script called run_analysis.R
##that does the following. 
library(reshape2)
## 1. Merges the training and the test sets to create one data set.
# 1.1 load test set
x_train<-read.table("./train/X_train.txt")

# 1.2 load training set
x_test<-read.table("./test/X_test.txt")

# 1.3 use row bind to merge train and test sets
merged_data<-rbind(x_train, x_test)

## 2. Extracts only the measurements on the mean and standard deviation 
# 2.1 Load features to add column names
features<-read.table("./UCI HAR Dataset/features.txt")
colnames(merged_data)<-features$V2

# 2.2 grepl matches a given string to the names of the merged data frame and creates a subset 
mean.subset<-merged_data[, grepl("mean", names(merged_data))]
std.subset<-merged_data[, grepl("std", names(merged_data))]

# 2.3 we bind the selected columns into one dataset
data.of.interest<-cbind(mean.subset, std.subset)

## 3. Uses descriptive activity names to name the activities in the data set
# 3.1 Load the activities from test and train sets and merge them
y_train<-read.table("./train/y_train.txt")
y_test<-read.table("./test/y_test.txt")
activity<-rbind(y_train, y_test)

# 3.2 Load the activity labels
labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
label_names<-as.character(labels$V2)

# 3.2 Transform the label data.frame into a factor with levels
activity<-factor(activity$V1, levels=1:6, labels=label_names)

# 3.3 add the "activity" to the dataset as a column. 
data.of.interest$activity<-activity

## 4. Appropriately labels the data set with descriptive variable names. 
# Column names were added earlier -see 2.1-


## 5. From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.

# 5.1 load the subject information for the train and test sets and merge them
subject_train<-read.table("./train/subject_train.txt")
subject_test<-read.table("./test/subject_test.txt")
subjects<-rbind(subject_train, subject_test)

# 5.2 Transform subjects into 1 variable type factor with 30 levels and add to 
#data.of.interest as a column
subject_ID<-factor(subjects$V1, levels=1:30)
data.of.interest$subject_ID<-subject_ID

#5.3 reshape the dataset: 
#select id variables (subject_ID and activity) and measure.variables (rest)
measure.var<-as.character(colnames(data.of.interest[1:78])) 

#reshape data in two steps: first melt, then shape according to the id variables. 
melted.data<-melt(data.of.interest, id.vars=c("activity", "subject_ID"), measure.var=measure.var)
meanFeatures<-dcast(melted.data, subject_ID + activity ~ variable, mean)

##txt file created with write.table() using row.name=FALSE. 
write.table(meanFeatures, "FeaturesAveragedPerSubjectAndActivity.txt", sep="\t", row.name=FALSE)
##Include readme.md : how the script works
##Include codebook describing the variables.


