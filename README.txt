##before running the script, remember to:
#1 setwd
#2 install and run library tidyr and dplyr

## download and unzip data

## 1. Merges the training and the test sets to create one data set.
	## downloads all data sets;
	## combines training data set by results, activities, subject;
	## further combines data test and train

## 3. Uses descriptive activity names to name the activities in the data set
	## attachs full activities description to activities 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	## keeps all columns that has the name "mean", "std", "Activities", "Subject"

## 4. Appropriately labels the data set with descriptive variable names.
	## use function gsub to change abbreviations to full description based on dataset documentation
	## use function gsub to remove miscellenous characters "[-()]"

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject.
	## group data by activities and subject to get average of all activies
	## write result to tidy.txt