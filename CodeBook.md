##General Description
This file contains a general description of the code, a description of the part of the raw data that interests us, a short explanation of the transformations the raw data underwent, and a list of the variables present in the new dataset (AveragedFeaturesPerSubjectAndActivity.txt)

Starting with data collected from the accelerometers from the Samsung Galaxy S smartphone (available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), I averaged the value of the features per subject and activity and created a new data set depicting one value per subject and activity.

The raw data consists of 3 separate folders, one with information and labels, and another two with the data, divided between the test subjects and the training subjects. The code assumes that these three folders are in R's working directory.  

##Description of the raw data
The description of the variables is taken from raw data feature_info file: 

The variables selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity accelerationsignals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

- Data of triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration and triaxial Angular velocity from the gyroscope were used to calculate subsequent data. 
 
- The body linear acceleration and angular velocity were derived in time to obtain Jerk signals(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

- Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

- For each of these variables, mean value 'mean()' and standard deviation 'std()' were calculated


- These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


##Transformations performed on raw data
1. The X_test and X_train data were merged into one data frame

2. The new data frame was given variable names taken from features.txt

3. The columns with calculated mean() and std() were subset. This was done using partial matching of the variable name.

4. The subject_test and subject_train were merged and transformed into a factor: subject_ID

5. The y_test and y_train sets were merged and transformed into a factor: activity

6. subject_ID and activity are added to the subset (step 3)

7. Using 'melt' and 'dcast' from the reshape2 package, the subset is reshaped: First by establishing ID variables ("activity" and "subject_ID") and measure variables (rest), secondly by creating a dataframe with the average of every measure variable per id variable. 


##Description of the variables
The final dataset, FeaturesAveragedPerSubjectAndActivity.txt consists of 80 variables. The variables describe the average of the calculated means and standard deviations of each of the features available in the accelerometer data: 

 
$ subject_ID	factor with 30 levels (1 level per subject of the experiment)

$ activity	factor with 6 levels (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

and the average value of the mean() and std() of: 

tBodyAcc-XYZ      

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ		

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag
