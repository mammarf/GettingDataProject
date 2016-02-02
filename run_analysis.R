####   TEST DATA    ####

## IMPORTANT - move to folder containing test data

library(data.table)
## read in data 
testdata = fread("X_test.txt")
##read in labels
testlabels = fread("y_test.txt")
names(testlabels) = "Activity"
##join labels which is the activity being performed
testdata = cbind(testlabels, testdata)
rm(testlabels)
##read in test subject labels
subjecttest = fread("subject_test.txt")
names(subjecttest) = "SubjectID"
##join subject ids to testdata
testdata = cbind(subjecttest, testdata)
rm(subjecttest)

####   TRAIN DATA    ####

## IMPORTANT - move to folder containing train_set data

##read in TRAIN DATA
traindata = fread("X_train.txt")
##read in labels
trainlabels = fread("y_train.txt")
names(trainlabels) = "Activity"
##join labels which is the activity being performed
traindata = cbind(trainlabels, traindata)
rm(trainlabels)
##read in test subject labels
subjecttrain = fread("subject_train.txt")
names(subjecttrain) = "SubjectID"
##join subject ids to testdata
traindata = cbind(subjecttrain, traindata)
rm(subjecttrain)

####    MERGE TRAINDATA AND TESTDATA and remove old data   ####
projdata = rbind(traindata, testdata)
rm(testdata)
rm(traindata)

#### ADD COLUMN LABELS (features) TO PROJDATA  ####

## IMPORTANT - move to folder containing features data

## read in features data and label PROJDATA
features = fread("features.txt")
names(projdata) = c("SubjectID", "Activity", features$V2)
rm(features)

#### Extract only mean and std columns ####

subprojdata = subset(projdata, select = c("SubjectID", "Activity", grep("[Mm]ean", names(projdata), value = TRUE)))
subprojdata = cbind(subprojdata, subset(projdata, select = grep("std", names(projdata), value = TRUE)))
rm(projdata)

#### Descriptive activity names to name the activities ####

activity = fread("activity_labels.txt")
activity
subprojdata$Activity = gsub(1, replacement = "WALKING", subprojdata$Activity)
subprojdata$Activity = gsub(2, replacement = "WALKING_UPSTAIRS", subprojdata$Activity)
subprojdata$Activity = gsub(3, replacement = "WALKING_DOWNSTAIRS", subprojdata$Activity)
subprojdata$Activity = gsub(4, replacement = "SITTING", subprojdata$Activity)
subprojdata$Activity = gsub(5, replacement = "STANDING", subprojdata$Activity)
subprojdata$Activity = gsub(6, replacement = "LAYING", subprojdata$Activity)
subprojdata$Activity = as.factor(subprojdata$Activity)
rm(activity)

#### Average of each variable for each activity and each subject ####

by_groups = group_by(subprojdata, SubjectID, Activity)
Averages = summarise_each(by_groups, funs(mean))

#### Create the tidy data set file ####
write.table(Averages, file = "TidyDataSet.txt", row.names = FALSE)
