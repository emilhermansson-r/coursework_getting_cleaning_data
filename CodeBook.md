GitHub contains a code book that modifies and updates the available codebooks
with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

# Code Book
## About the Source Data:

The source data for this project comes from the Human Activity Recognition Using a Smartphones Data Set. The dataset is described at: [Human Activity Recognition Using Smartphones Data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## About the R Script:

The R script, "run_analysis.R," performs the following steps:

1. **Merges the training and the test sets to create one data set:**
   - Reads the training and testing data
   - Reading feature vectors and activity labels.
   - Assigning the variable names.
   - Combining the data

2. **Extracts only the measurements on the mean and standard deviation for each measurement:**
   - Selects mean and standard deviation for each feature.

3. **Uses descriptive activity names to name the activities in the data set:**
   - Uses activity names to label activities in the dataset.

4. **Appropriately labels the data set with descriptive variable names:**
   - Re-labeling the variable names to improve readability.

5. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:**
   - Generates and writes a tidy data set with the average of each variable for each activity and each subject.

## Variables:

- `x_train`, `y_train`, `x_test`, `y_test`,  are the raw-data from the downloaded files.
- `subject_train`, `features`, `subject_test`, are meta-data for the raw-data, these are combined to get the full dataset.
- `x_data`, `y_data`, and `subject_data` merge the above datasets for further analysis.
- `features` contains the meta-data for the test and train datasets, applied to the column names for detailed reference.

