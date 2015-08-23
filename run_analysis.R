##
# Anthony Bateman abateman@gwu.edu
# run_analysis.R
# 22, AUG, 2015
#
# This script creates text file called "myTidyData.txt" containing tidy data as
# my course project submision for Getting and Cleaning Data. It takes the file
# "getdata_projectfiles_UCI_HAR_Dataset.zip" as input and returns test the text
# file.
#
# The data can be read into R by running:
# myTidyData <- read.table("myTidyDataSet.txt", header = TRUE)
#
# If you need to download source files, uncomment the block of code below.

# Get me the input files!
# if(!file.exists("./UCI_HAR_Dataset")){dir.create("./UCI_HAR_Dataset")
#   fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#   download.file(fileUrl, destfile="./UCI_HAR_Dataset/getdata_projectfiles_UCI_HAR_Dataset.zip",method="curl")
#   unzip ("./UCI_HAR_Dataset/getdata_projectfiles_UCI_HAR_Dataset.zip", exdir = "./UCI_HAR_Dataset")
#   dateDownloaded <- date()
# }
#
##

library(data.table)
library(dplyr)
library(reshape2)

#Meta Data, Names and Labels
activityLabels <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/activity_labels.txt",col.names = c("id","activity"), header = FALSE
  )
features <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/features.txt" ,col.names = c("id","feature"), header = FALSE
  )
cols <- c(rep('numeric', 561))

#get the TestGroup Data. Set matching Feature names as column names
tempDataTest <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/test/X_test.txt", colClasses = cols, header = FALSE
  )
colnames(tempDataTest) <- features$feature

#get the TestGroup subject IDs
tempSubjectIDTest  <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/test/subject_test.txt",col.names = c("subjectId"), header = FALSE
  )

#get the TestGroup activity ID and match to activivty names
tempActivityTest  <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/test/Y_test.txt",col.names = c("id"), header = FALSE
  )
activityPlusLabelsTest = inner_join(tempActivityTest,activityLabels)

#bind activityID, activityName to temp data frame
tempDataTest = cbind(tempDataTest, activityID = activityPlusLabelsTest$id, activityName = activityPlusLabelsTest$activity)

#bind subjectID to temp data frame
tempDataTest = cbind(tempDataTest, subjectID = tempSubjectIDTest$subjectId)

#Repeat the above for the "train" data
#get the TrainGroup Data. Set matching Feature names as column names
tempDataTrain <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/train/X_train.txt", colClasses = cols, header = FALSE
  )
colnames(tempDataTrain) <- features$feature

#get the TrainGroup subject IDs
tempSubjectIDTrain  <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/train/subject_train.txt",col.names = c("subjectId"), header = FALSE
  )

#get the TrainGroup activityID and match to activivty names
tempActivityTrain  <-
  read.table(
    "./UCI_HAR_Dataset/UCI HAR Dataset/train/Y_train.txt",col.names = c("id"), header = FALSE
  )
activityPlusLabelsTrain = inner_join(tempActivityTrain,activityLabels)

#bind activityID, activityName to data frame
tempDataTrain = cbind(tempDataTrain, activityID = activityPlusLabelsTrain$id, activityName = activityPlusLabelsTrain$activity)

#bind subjectID to data frame
tempDataTrain = cbind(tempDataTrain, subjectID = tempSubjectIDTrain$subjectId)

#bind  the "test" data and the "train" data into one BigTable
bigTable = rbind(tempDataTest,tempDataTrain)

#make a grepable list from the features data frame to find column names that contain "mean" and "std"
p <- as.character(factor(features$feature))
q <- c("subjectID","activityName",grep("(mean|std)", p, value = TRUE))

#subset bigTable, selecting columns from result of grep, to create table for Step 4 of the assignment
stepFourTable <- bigTable[,q]

#get the column names from stepFourTable. Split, clean, and rejoins as names for tidyData set
idVars <- names(stepFourTable)[c(1,2)]
tidyNames <-
  c(idVars,paste(gsub("[()|()-]", "",names(stepFourTable)[-c(1,2)]),"-Mean",sep = ""))

#Group stepFourTable ID vars and summarize measure vars
tidyData <- stepFourTable %>%
  group_by(subjectID,activityName) %>%
  summarise_each(funs(mean))

#apply tidy column names to tidyData
names(tidyData) <- tidyNames

#Clean up to recover some memory
rm(
  bigTable, tempActivityTest, tempDataTest, tempDataTrain, tempSubjectIDTest, activityPlusLabelsTest, activityPlusLabelsTrain, tempActivityTrain, tempSubjectIDTrain, activityLabels, features, stepFourTable, cols,idVars, p, q,tidyNames
)

#Save my Tidy Data Set Woooo Hoooooo!
write.table(tidyData , file = "myTidyDataSet.txt", row.names = FALSE)
