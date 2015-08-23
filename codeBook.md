z---
title: "codeBook.md"
subtitle: "myTidyDataSet for Getting and Cleaning Data"
author: "Anthony Bateman"
date: "Aug 22, 2015"
output:
  html_document:
    keep_md: yes
---

## Project Description
Develop an R script to collect and clean data from the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) raw data set and process that data to prepare tidy data that can be used for later analysis.


##Study design and data processing
>"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smart phone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details." 
>
><cite>Davide Anguita</cite>, <cite>Alessandro Ghio</cite>, <cite>Luca Oneto</cite>, <cite>Xavier Parra</cite> and <cite>Jorge L. Reyes-Ortiz</cite>[*](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

###Notes on the original (raw) data
The raw data is contained in a zip file and structured in a way that is consistent, in part with a relational database model.
Observational data is split into two groups, "test" and "train" (See: Study design and data processing). Additionally, each group also contain data collected from the smart phones internal sensors which is not considered for the purposes of this project. Meta-data including activity labels and field names for observed values are provided in separate files and are keyed to observed data. Each observation within the data set can be match to both a test subject and a specific activity for which the observation was made. These values are not however keyed to the data itself and therefore is necessary to assume that the relationship among these data is preserved by the order of the observations. This assumption is supported by a matching numbers of lines in the respective files. 



##Creating the tidy datafile
###Guide to create the tidy data file
The raw data was downloaded from the link provided in the instructions.
Following a preliminary review of the raw data files in a text editor in order to understand the format of the raw data and to understand the relationships among the various files, the tidy data set was created using an R script. The basic process is outlined below. 
Please see [README.md](https://github.com/abatemangwu/gettingAndCleaningData/blob/master/README.md) for details.

1. Temporary data frames were created and data was added to produce the structure of the tidy data set
2. The data was subsetted to include only fields which contain values reporting Mean and Standard Deviations information.
3. The data was grouped by the fields that represented independent variables, namely by activities and test subjects.
4. The dependent variables (Features) were summarized, to returned the aggregated mean (average) for each activities/test subjects pair.
5. "Freindly" column names were then applied to the tidy data set.
6. The tidy data set was saved to a file: myTidtDataSet.txt


##Description of the variables in the myTidtDataSet.txt

180 observations of 81 variables.
The data is a single table following the "long" tidy data format.

###Variables present in the dataset are:

- subjectID
- activityName
- tBodyAccmeanX-Mean
- tBodyAccmeanY-Mean
- tBodyAccmeanZ-Mean
- tBodyAccstdX-Mean
- tBodyAccstdY-Mean
- tBodyAccstdZ-Mean
- tGravityAccmeanX-Mean
- tGravityAccmeanY-Mean
- tGravityAccmeanZ-Mean
- tGravityAccstdX-Mean
- tGravityAccstdY-Mean
- tGravityAccstdZ-Mean
- tBodyAccJerkmeanX-Mean
- tBodyAccJerkmeanY-Mean
- tBodyAccJerkmeanZ-Mean
- tBodyAccJerkstdX-Mean
- tBodyAccJerkstdY-Mean
- tBodyAccJerkstdZ-Mean
- tBodyGyromeanX-Mean
- tBodyGyromeanY-Mean
- tBodyGyromeanZ-Mean
- tBodyGyrostdX-Mean
- tBodyGyrostdY-Mean
- tBodyGyrostdZ-Mean
- tBodyGyroJerkmeanX-Mean
- tBodyGyroJerkmeanY-Mean
- tBodyGyroJerkmeanZ-Mean
- tBodyGyroJerkstdX-Mean
- tBodyGyroJerkstdY-Mean
- tBodyGyroJerkstdZ-Mean
- tBodyAccMagmean-Mean
- tBodyAccMagstd-Mean
- tGravityAccMagmean-Mean
- tGravityAccMagstd-Mean
- tBodyAccJerkMagmean-Mean
- tBodyAccJerkMagstd-Mean
- tBodyGyroMagmean-Mean
- tBodyGyroMagstd-Mean
- tBodyGyroJerkMagmean-Mean
- tBodyGyroJerkMagstd-Mean
- fBodyAccmeanX-Mean
- fBodyAccmeanY-Mean
- fBodyAccmeanZ-Mean
- fBodyAccstdX-Mean
- fBodyAccstdY-Mean
- fBodyAccstdZ-Mean
- fBodyAccmeanFreqX-Mean
- fBodyAccmeanFreqY-Mean
- fBodyAccmeanFreqZ-Mean
- fBodyAccJerkmeanX-Mean
- fBodyAccJerkmeanY-Mean
- fBodyAccJerkmeanZ-Mean
- fBodyAccJerkstdX-Mean
- fBodyAccJerkstdY-Mean
- fBodyAccJerkstdZ-Mean
- fBodyAccJerkmeanFreqX-Mean
- fBodyAccJerkmeanFreqY-Mean
- fBodyAccJerkmeanFreqZ-Mean
- fBodyGyromeanX-Mean
- fBodyGyromeanY-Mean
- fBodyGyromeanZ-Mean
- fBodyGyrostdX-Mean
- fBodyGyrostdY-Mean
- fBodyGyrostdZ-Mean
- fBodyGyromeanFreqX-Mean
- fBodyGyromeanFreqY-Mean
- fBodyGyromeanFreqZ-Mean
- fBodyAccMagmean-Mean
- fBodyAccMagstd-Mean
- fBodyAccMagmeanFreq-Mean
- fBodyBodyAccJerkMagmean-Mean
- fBodyBodyAccJerkMagstd-Mean
- fBodyBodyAccJerkMagmeanFreq-Mean
- fBodyBodyGyroMagmean-Mean
- fBodyBodyGyroMagstd-Mean
- fBodyBodyGyroMagmeanFreq-Mean
- fBodyBodyGyroJerkMagmean-Mean
- fBodyBodyGyroJerkMagstd-Mean
- fBodyBodyGyroJerkMagmeanFreq-M


### subjectID
An int value representing the subject (person) to whom the observation applies (range: 1-30).

### activityName
A Factor w/ 6 levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.

"Friendly" names for the activity to which the observation applies.

### tBodyAccmeanX-Mean (*)

A numeric vector representing an aggregated mean for each subjectID/activityName pair.
The portion of the variables name before "-Mean" refers to similarly named "Freature" variable in the raw data set. The suffix indicates the variable is a derived value representing the mean of a range for values contained in raw data set.

(*)The same applies for each additional variable in the tidy data set.

##Sources
- [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
- [Xing's Course notes](https://github.com/sux13/DataScienceSpCourseNotes)
- [Sean C. Anderson, An Introduction to reshape2](http://seananderson.ca/2013/10/19/reshape.html)
- [stackoverflow](http://stackoverflow.com/) many many times.
- [Hadley Wickham's Tidy  Data](http://vita.had.co.nz/papers/tidy-data.pdf)
- [Joris Schut's code book template](https://gist.github.com/JorisSchut)
