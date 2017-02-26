# Code Book

Analysis is done using run_analysis.R. Raw data from ./UCI HAR Dataset/ is cleaned and a tidy data set is created.

code book that describes the variables, the data, and any transformations 
or work that you performed to clean up the data called CodeBook.md. 

## Data
* `subject_test` `X_test` `Y_test` `subject_train` `X_train` `Y_train` `activity_labels` and `features` are raw data variables loaded from ./UCI HAR Dataset/.
* `subject_table` `X_table` `Y_table` are a merge from the 'train' and 'test' data from 'subject', 'X', and 'Y' respectively.
* `X_table_ms` extracts the measurements on the mean and standarddeviation from 'X_table'.
* `full_table` merges `subject_table` `Y_table` and `X_table_ms`.
* `tidy_dataset` is the tidy dataset that is the output from run_Analysis.R. The average of each variable for each activity and subject from `full_table` is represented in 'tidy_dataset`.

## Variables
The variables in the data come from accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. The variables represent both data in the time domain representation and in the frequency domain representation (Fourier Transform). Below is a short summary of the variables.
* `t` or `Time` stands for 'time' and `f` or `Freq` stands for 'frequency'.
* `BodyAcc` and `GravityAcc` stand for 'body accelartion' and 'gravity acceleration'
* `-XYZ` is used to denote 3-axial signals in the X, Y and Z directions.
* Two examples from the set of variables that were estimated from these signals are: `mean`: 'Mean value' `std`: Standard deviation.
* A more detailed description of the variables is given in `features_info.txt` which can be found in the data directory and a complete list of the raw data variables can be found in `features.txt`.

## Transformations
* `read.table` is used to read the raw data.
* `bind_rows` and `bind_cols` is used to merge data.
* `colnames` is used to change the names of the variables (columns).
* `grepl` is used to filter table based on a part of the variable names (containing mean or std)
* `factor` is used to insert the activity names from `activity_labels` into the `Activity` variable from `full_table` based on the activity number.
* `ddply` is used to apply a function (take average (or more specific: 'colwise(mean)' to take the avergae in column direction)) for a combination of variables ('Activity' and 'Subject').
* finally `write.table` is used to save the output.
