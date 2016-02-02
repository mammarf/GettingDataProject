The purpose of this project is to find the mean and std of each subject within each activity of the various mean and std values. 

First I read in the test data as well as the labels; the labels identify which activity was being done in each observation.
I merge the two datasets together to create testdata dataframe. 
Next I read in the subject_test file whih corresponds to the subject ID to each row of the observation and merge this too with the testdata dataframe. 
Now I have testdata; a dataframe that contains all the values completed by each subject within each activity.  

I repeat the above steps for the train data to create a dataframe called traindata.

I then merge in the testdata and traindata dataframes to create a single dataframe projdata. 

I then label all the columns of projdata using the features text file. 

After that, I subset out all the mean and std values to create the subprojdata dataframe. 

Then I replace all the activity id's with the appropriate labels. 

Penultimately I then create a dataframe that is first grouped by subjectID and then Activity. 

Lastly, I create a tidy data set file with the findings. 

