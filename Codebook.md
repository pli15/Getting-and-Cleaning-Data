# Codebook
This codebook will give you an overview of the dataset, including the definitions of the variables, dataset summary, variable attributes, etc.

## Variable Definitions
The variables here are all from the final tidy dataset.

CODE TO LIST VARIABLES: 

key(data_tidy)

|Variable	|Definitions												    |
|---------------|:---------------------------------------------------------------------------------------------------------:|
|Subject	|Observaions											    	    |
|Activity	|Activity No.												    |
|Activity_Name	|Activity Name												    |
|Var		|Calculated Metrics											    |
|time_freq	|Identify whether this metric is calculated as time domain signals or frequency				    |
|Acc_Gyro	|Identify whether this metric is calculated as accelerometer and gyroscope				    |
|Body_Gravity	|Identify whether this metric is calculated as body acceleration signals or gravity acceleration signals    |
|Jerk		|Identify whether this metric shows jerk signals							    |
|Magnitude	|Identify whether this metric is calculated based on magnitude of these three-dimensional signals           |
|Calculation	|Identify how this metric is calculated									    |
|Axial		|Identify which 3-axial signal (X, Y and Z directions) this metric shows 				    |
|value		|Value of the metric											    |
|average	|Average value of the metric										    |

## Dataset Summary
	summary(data_tidy)

    Subject         Activity     Activity_Name          Var             time_freq           Acc_Gyro         Body_Gravity           Jerk            Magnitude         Calculation           Axial               value         
 Min.   : 1.00   Min.   :1.000   Length:813615      Length:813615      Length:813615      Length:813615      Length:813615      Length:813615      Length:813615      Length:813615      Length:813615      Min.   :-1.00000  
 1st Qu.: 9.00   1st Qu.:2.000   Class :character   Class :character   Class :character   Class :character   Class :character   Class :character   Class :character   Class :character   Class :character   1st Qu.:-0.97211  
 Median :17.00   Median :4.000   Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character   Mode  :character   Median :-0.39936  
 Mean   :16.15   Mean   :3.625                                                                                                                                                                              Mean   :-0.43398  
 3rd Qu.:24.00   3rd Qu.:5.000                                                                                                                                                                              3rd Qu.:-0.04308  
 Max.   :30.00   Max.   :6.000                                                                                                                                                                              Max.   : 1.00000  
    Average        
 Min.   :-1.00000  
 1st Qu.:-0.97211  
 Median :-0.39936  
 Mean   :-0.43398  
 3rd Qu.:-0.04308  
 Max.   : 1.00000  


## Variable Attributes
	str(data_tidy)

Classes ¡®data.table¡¯ and 'data.frame':  813615 obs. of  13 variables:
 $ Subject      : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity     : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity_Name: chr  "WALKING" "WALKING" "WALKING" "WALKING" ...
 $ Var          : chr  "fBodyAcc-mean()-X" "fBodyAcc-mean()-X" "fBodyAcc-mean()-X" "fBodyAcc-mean()-X" ...
 $ time_freq    : chr  "Freq" "Freq" "Freq" "Freq" ...
 $ Acc_Gyro     : chr  "Accelerometer" "Accelerometer" "Accelerometer" "Accelerometer" ...
 $ Body_Gravity : chr  "Body" "Body" "Body" "Body" ...
 $ Jerk         : chr  "No" "No" "No" "No" ...
 $ Magnitude    : chr  "No" "No" "No" "No" ...
 $ Calculation  : chr  "Mean" "Mean" "Mean" "Mean" ...
 $ Axial        : chr  "X" "X" "X" "X" ...
 $ value        : num  -0.983 -0.978 -0.954 -0.531 -0.523 ...
 $ Average      : num  -0.983 -0.978 -0.954 -0.531 -0.523 ...
 - attr(*, "sorted")= chr  "Subject" "Activity" "Activity_Name" "Var" ...
 - attr(*, ".internal.selfref")=<externalptr> 
