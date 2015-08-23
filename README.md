---
title: "README.md"
subtitle: "Course project submision for Getting and Cleaning Data"
author: "Anthony Bateman"
date: "Aug 22, 2015"
---

# README.md
# 
## run_analysis.R

### Description

An R script that takes the raw data files file "getdata_projectfiles_UCI_HAR_Dataset.zip" as input, and returns a text file called "myTidyDataSet.txt".

## Running the script
Provided that you have downloaded the raw data set "getdata_projectfiles_UCI_HAR_Dataset.zip", the script can be sourced in to R and run. If you need to download source files, uncomment the block of code in under "Get me the input files!" and the script will attempt to get the files for you. Alternatively, the Raw data set is also available at [Human Activity Recognition Using Smart phones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The output (myTidyDataSet.txt) can be read into R, creating a tidy data set by running:

    myTidyData <- read.table("myTidyDataSet.txt", header = TRUE)

## How it works

1. For both the "test" data and the "train" data, numeric vector variables representing the observational data are created from the raw data files X_train.txt and X_test.txt
2. The values are then added to two temporary data frames.
3. A factor variable is create from the features.txt file and added to the temporary data frames to create column names.
4. Factor variables are created representing the subject ID from both subject_train.txt and subject_test.txt respectively, and these value column bound to the temporary data frames.
5. Variables are created from Y_train.txt and Y_test.txt files that contained integer values representing the various activities.
6. These values are then matched to the labels provided in activity_labels.txt.
7. The resulting "Friendly" activity labels are then column bound to the temporary data frames.
8. The temporary data frames, one for "test" and one for "train" are merged into one big data frame.
9. A list of column names with names that contain "mean" and "std" is created by grepping the data frame's column names.
10. The data frame is subsetted to include only columns that's names that match the list values from step 9.
11. The data in then grouped by both subjectID and activityName.
12. The features values are summarized, to returned the aggregated mean (average) for each activities/test subjects pair.
13. "Freindly" column names are then applied to the tidy data set.
14. The tidy data set is saved to a file.

## Also
Please see [codeBook.md](./codeBook.md) for additional infornation about the tiday data set.
