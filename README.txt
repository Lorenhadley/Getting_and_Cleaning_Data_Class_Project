======================================================================================
Getting and Cleaning Data Class Project
Prepared by Loren Hadley
Version 1.0
October 23, 2015
--------------------------------------------------
CONTENTS

This project includes:
README.txt - which describes the project and process that is used to trasform the source data 
		into the required data set.

README-OriginalSourceData.txt - which describes the provenance of the intitial data set that
		was the basis of this project

run_analysis.R - the r script prepared with  Version 3.2.2 and the data.table library

CodeBook.txt - describes the variables presented in this project 
-------------------------
PURPOSE

The purpose of this project is to read and transform the original data set Human Activity Recognition 
Using Smartphones Dataset - Version 1.0 described in the README-OriginalSourceData.txt file into a tidy 
summarizing the mean value for each of the mean() and std() type variables in the original data
set for each activity performed by each test subject.  The resulting variables have been renamed for
ease of use.

=====================================================================================
Function of run_analysis.R Script

The R script run_analysis was written with r version 3.2.2 (64 bit) utilizing the data.table library.

The script is designed to operate in a folder along side the un-zipped data folder.

Step 1 - Preperation of the environment
Step 1A. 	Download the original  data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Step 1B. 	Unzip the folder so that the unzipped folder UCI HAR Dataset is located in your working directory along with the run_analysis.R script.
step 1C. 	Make sure that the package data.table for R has been installed for R  it is available at 
			https://cran.r-project.org/web/packages/data.table/index.html 
Step 2 - Run run_analysis.R once the data and data.table package have been installed

Step2A - The primary data folder should contain features.txt which will be actively used by the script along with several supporting files
			that provide background on the data but will not be actively used.  There will also be a "test" and a "train" folder which houses
			the bulk of the data for the project.  run_analysis will read features.txt, the primary data files X_test.txt and X_train.txt, activities data 
			in files Y_test.txt and Y_train.txt and information on the subjects of the test as subject_test.txt and subject_train.txt.
			
Step 2B - Once the data files have been read, features.txt will be used to create the vector mainDataNamesVect that will provide column names for the completed table.
			additional column names "subject" and "activity" are appended creating completed vector  dataNamesVect.
			
Step 2C - Once the column names vector has been created, the subject_test.txt and Y_test.text will be appended as columns on the end of the primary test data set X_test.txt 
			creating the activities and subject columns.  This same process is repeated for the x_train data set and the two resulting data.frames
			are row-bound to create comboData.
			
Step 2D - column names are then applied to comboData with names(comboData) <- c(dataNamesVect) creating a data.frame with 563 columns, 10,299 rows and column names.

Step 2E - dataNamesVect is then processed with grep to subset the vector for variable names including the sub-strings mean, std, activity and subject as a vector names namesFiltered.
			This sub-set of names is then used to eliminate all non-essential columns creating filteredData1, a data.frame of 89 columns, 10,299 rows and column names.
			Please not that at this point variables created based on mean_frequency are still part of the set.  They could be recovered into the final tidy data set if they 
			are required for future analysis.  They will be removed at a later stage to meet the specific requirements of this analysis.

Step 2F - a new column is created at the end of the data.frame comprised of the look-up values for the activity code data.  This provides a user friendly 
			handle for activity data.
			
Step 2G - data.frame filteredData1 is then converted into a data.table filtedData1DT in preperation for the aggregation process.

Step 2H - filteredData1DT is then aggregated by subject and activity using the mean function as data.table filteredData3DT.

Step 2I - a vector of friendly column names friendlyName is created based on the structure of filteredData3DT and applied.

Step 2J - friendlyNames is then filtered to remove frequency mean and activity code column names creating the vector namesFilteredSecondary again 
			employing the grep functionality.  

Step 2K - namesFilteredSecondary is then used to sub-set data.table filteredData3DT	resulting in the final data.table tidyData.

Step 3 -  table tidyData is writen to a text file with the write.table function, producing the final resulting test file as a csv.	

			
			