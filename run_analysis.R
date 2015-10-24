## 1>  Load Packages

        library(data.table)

##2> Read in Data Sets

        mainDataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
        mainDataTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
        activityDataTrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
        activityDataTest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
        subjectDataTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        subjectDataTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        mainDataNames <- read.table("./UCI HAR Dataset/features.txt")

## 3> begin Processing
        mainDataNamesVect <- as.vector(mainDataNames[ ,2])      ##  Convert 2nd colum of original data.frame to Vector for use as column names
        extraDataNames <- c("subject","activity")               ## Add data names for suject and activity
        dataNamesVect <- append(mainDataNamesVect, extraDataNames, after = 561)     ##  Add subject and activities to end of Vector to name 2 appended data columns 

        comboData <- rbind(cbind(mainDataTrain, subjectDataTrain, activityDataTrain),cbind(mainDataTest,subjectDataTest, activityDataTest))  ## Create master data set by adding Subject and Activities column to the end of Train & Test and then merging Train and Test
        names(comboData) <- c(dataNamesVect)                    ## Add column Names to Master data set
        namesFiltered <- grep("mean|std|subject|activity" ,dataNamesVect, ignore.case=TRUE, value=TRUE)           ## Use grep to select mean and standard deviation related metrics as well as retain activity column
        filteredData1 <- comboData[,namesFiltered]                                      ##  subset data.frame by the columns identified in namesFiltered

        activityLab <- c( WALKING=1, WALKING_UPSTAIRS=2, WALKING_DOWNSTAIRS=3, SITTING=4,  STANDING=5, LAYING=6)        ## Set up Look-up table for Activity Names

        filteredData1$activityName <- names(activityLab)[match(filteredData1$activity, activityLab)]  ## read Activity Names into filteredData1 frame

        filterData1DT <- data.table(filteredData1,keep.rownames=TRUE)  ## Conver filteredData1 into  a data.table for aggregation

        filterData3DT <- with(filterData1DT, aggregate (filterData1DT, by = list(filterData1DT$activityName,filterData1DT$subject), FUN = mean)) ## Sort & Aggregate data into filteredData3DT data.table summarized by variable mean for each subject & activity

        ## read in friendly variable names
        friendlyNames <- c("Activity_Name",
                   "Subject",
                   "rn",
                   "Mean_Body_Acceleration-X_Axis"
                   ,"Mean_Body_Acceleration-Y_Axis"
                   ,"Mean_Body_Acceleration-Z_Axis"
                   ,"STD_Body_Acceleration-X_Axis"
                   ,"STD_Body_Acceleration-Y_Axis"
                   ,"STD_Body_Acceleration-Z_Axis"
                   ,"Mean_Gravity_Acceleration-X_Axis"
                   ,"Mean_Gravity_Acceleration-Y_Axis"
                   ,"Mean_Gravity_Acceleration-Z_Axis"
                   ,"STD_Gravity_Acceleration-X_Axis"
                   ,"STD_Gravity_Acceleration-Y_Axis"
                   ,"STD_Gravity_Acceleration-Z_Axis"
                   ,"Mean_Body_Acceleration_Jerk-X_Axis"
                   ,"Mean_Body_Acceleration_Jerk-Y_Axis"
                   ,"Mean_Body_Acceleration_Jerk-Z_Axis"
                   ,"STD_Body_Acceleration_Jerk-X_Axis"
                   ,"STD_Body_Acceleration_Jerk-Y_Axis"
                   ,"STD_Body_Acceleration_Jerk-Z_Axis"
                   ,"Mean_Body_Gyroscopic-X_Axis"
                   ,"Mean_Body_Gyroscopic-Y_Axis"
                   ,"Mean_Body_Gyroscopic-Z_Axis"
                   ,"STD_Body_Gyroscopic-X_Axis"
                   ,"STD_Body_Gyroscopic-Y_Axis"
                   ,"STD_Body_Gyroscopic-Z_Axis"
                   ,"Mean_Body_Gyroscopic_Jerk-X_Axis"
                   ,"Mean_Body_Gyroscopic_Jerk-Y_Axis"
                   ,"Mean_Body_Gyroscopic_Jerk-Z_Axis"
                   ,"STD_Body_Gyroscopic_Jerk-X_Axis"
                   ,"STD_Body_Gyroscopic_Jerk-Y_Axis"
                   ,"STD_Body_Gyroscopic_Jerk-Z_Axis"
                   ,"Mean_Body_Acceleration_Magnitude"
                   ,"STD_Body_Acceleration_Magnitude"
                   ,"Mean_Gravity_Acceleration_Magnitude"
                   ,"STD_Gravity_Acceleration_Magnitude"
                   ,"Mean_Body_Acceleration_Jerk_Magnitude"
                   ,"STD_Body_Acceleration_Jerk_Magnitude"
                   ,"Mean_Body_Gyroscopic_Magnitude"
                   ,"STD_Body_Gyroscopic_Magnitude"
                   ,"Mean_Body_Gyroscopic_Jerk_Magnitude"
                   ,"STD_Body_Gyroscopic_Jerk_Magnitude"
                   ,"Mean_Body_Acceleration-X_Axis_FFT"
                   ,"Mean_Body_Acceleration-Y_Axis_FFT"
                   ,"Mean_Body_Acceleration-Z_Axis_FFT"
                   ,"STD_Body_Acceleration-X_Axis_FFT"
                   ,"STD_Body_Acceleration-Y_Axis_FFT"
                   ,"STD_Body_Acceleration-Z_Axis_FFT"
                   ,"fBodyAcc-meanFreq()-X"
                   ,"fBodyAcc-meanFreq()-Y"
                   ,"fBodyAcc-meanFreq()-Z"
                   ,"Mean_Body_Acceleration_Jerk-X_Axis_FFT"
                   ,"Mean_Body_Acceleration_Jerk-Y_Axis_FFT"
                   ,"Mean_Body_Acceleration_Jerk-Z_Axis_FFT"
                   ,"STD_Body_Acceleration_Jerk-X_Axis_FFT"
                   ,"STD_Body_Acceleration_Jerk-Y_Axis_FFT"
                   ,"STD_Body_Acceleration_Jerk-Z_Axis_FFT"
                   ,"fBodyAccJerk-meanFreq()-X"
                   ,"fBodyAccJerk-meanFreq()-Y"
                   ,"fBodyAccJerk-meanFreq()-Z"
                   ,"Mean_Body_Gyroscopic-X_Axis_FFT"
                   ,"Mean_Body_Gyroscopic-Y_Axis_FFT"
                   ,"Mean_Body_Gyroscopic-Z_Axis_FFT"
                   ,"STD_Body_Gyroscopic-X_Axis_FFT"
                   ,"STD_Body_Gyroscopic-Y_Axis_FFT"
                   ,"STD_Body_Gyroscopic-Z_Axis_FFT"
                   ,"fBodyGyro-meanFreq()-X"
                   ,"fBodyGyro-meanFreq()-Y"
                   ,"fBodyGyro-meanFreq()-Z"
                   ,"Mean_Body_Acceleration_Magnitude_FFT"
                   ,"STD_Body_Acceleration_Magnitude_FFT"
                   ,"fBodyAccMag-meanFreq()"
                   ,"Mean_Body_Acceleration_Jerk_Magnitude_FFT"
                   ,"STD_Body_Acceleration_Jerk_Magnitude_FFT"
                   ,"fBodyBodyAccJerkMag-meanFreq()"
                   ,"Mean_Body_Gyroscopic_Magnitude_FFT"
                   ,"STD_Body_Gyroscopic_Magnitude_FFT"
                   ,"fBodyBodyGyroMag-meanFreq()"
                   ,"Mean_Body_Gyroscopic_Jerk_Magnitude_FFT"
                   ,"STD_Body_Gyroscopic_Jerk_Magnitude_FFT"
                   ,"fBodyBodyGyroJerkMag-meanFreq()"
                   ,"angle(tBodyAccMean,gravity)"
                   ,"angle(tBodyAccJerkMean),gravityMean)"
                   ,"angle(tBodyGyroMean,gravityMean)"
                   ,"angle(tBodyGyroJerkMean,gravityMean)"
                   ,"angle(X,gravityMean)"
                   ,"angle(Y,gravityMean)"
                   ,"angle(Z,gravityMean)"
                   ,"subject"
                   ,"activity"
                   ,"activityName")
        
names(filterData3DT) <- c(friendlyNames)        ## use friendly data names on table filterData3DT
namesFilteredSecondary <- grep("Mean_|STD_|Subject|Activity_Name" ,friendlyNames, ignore.case=FALSE, value=TRUE)  ## subset friendly page names to remove ancillary mean columns

## Create final Tidy Data table by removing ancilary columns 
tidyData <- filterData3DT[,namesFilteredSecondary]
write.table(tidyData, file="samsungDataSummary",sep = ",",row.names = FALSE, col.names = TRUE)