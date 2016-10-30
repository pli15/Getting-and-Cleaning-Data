# prepare & download files
install.packages("downloader",repos=c("http://rstudio.org/_packages","http://cran.rstudio.com"))
library(downloader)
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="./courseproject.zip")
unzip("courseproject.zip")
list.files("./UCI HAR Dataset")

library(data.table)
path<-setwd("D:\\clean data")

# read data
path_sub <- file.path(path, "UCI HAR Dataset")
data_subject_train <- fread(file.path(path_sub, "train", "subject_train.txt"))
data_X_train <- fread(file.path(path_sub, "train", "X_train.txt"))
data_y_train <- fread(file.path(path_sub, "train", "y_train.txt"))
data_subject_test <- fread(file.path(path_sub, "test", "subject_test.txt"))
data_X_test <- fread(file.path(path_sub, "test", "X_test.txt"))
data_y_test <- fread(file.path(path_sub, "test", "y_test.txt"))

# 1. Merges the training and the test sets to create one data set
## rename variables
setnames(data_subject_train,"V1","Subject")
setnames(data_subject_test,"V1","Subject")
head(data_subject_train)
head(data_subject_test)

## merge
data_subject<-merge(data_subject_train,data_subject_test,all=TRUE,by=c("Subject"))

## rename variables
setnames(data_y_train,"V1","Activity")
setnames(data_y_test,"V1","Activity")
head(data_y_train)
head(data_y_test)

## merge
data_y<-rbind(data_y_train,data_y_test)
data_X<-rbind(data_X_train,data_X_test)
data_step1<-cbind(data_subject,data_y)
data<-cbind(data_step1,data_X) 

# 2.Extracts only the measurements on the mean and standard deviation for each measurement
## read file
data_features <- fread(file.path(path_sub, "features.txt"))
head(data_features)

## search for key words mean & std and identify qualified variables
data_features$metric<-grepl("mean|std",data_features$V2)
head(data_features)
data_features_selected<-data_features[grepl("mean|std",data_features$V2),]
data_features_selected$variable<-data_features_selected[,paste("V",V1)]
data_features_selected$variable_trim<-sub(" ","",data_features_selected$variable)
head(data_features_selected)
table(data_features_selected$metric,data_features_selected$variable_trim)
data_features_selected$variable_trim
setkey(data_features_selected,V1,V2,variable_trim)

## subset data by selecting qualified variables (mean & std)
final_metric<-c(data_features_selected$variable_trim)
setkey(data,Subject,Activity)
final_metric<-c(key(data),final_metric)
data_selected<-data[,final_metric, with=FALSE]
head(data_selected)

# 3. Uses descriptive activity names to name the activities in the data set
activity_label<-fread(file.path(path_sub, "activity_labels.txt"))
head(activity_label)
setnames(activity_label,c("V1","V2"),c("Activity","Activity_Name"))
setkey(activity_label,Activity)
setkey(data_selected,Subject,Activity)
data_activity<-merge(data_selected,activity_label)

# 4. Appropriately labels the data set with descriptive variable names
setkey(data_activity,Subject,Activity,Activity_Name)
data_melt<-melt(data_activity,key(data_activity),variable.name="variable_trim")
data_melt_Var<-cbind(data_melt,data_features_selected)
setnames(data_melt_Var,c("V1","V2"),c("Var_No","Var"))
table(data_melt_Var$metric,data_melt_Var$variable_trim)
head(data_melt_Var)

## add descriptive labels
data_melt_Var$time_freq<-ifelse(substr(data_melt_Var$Var, 1, 1)=="t","Time","Freq")
data_melt_Var$Acc_Gyro<-ifelse(grepl("Acc",data_melt_Var$Var)==c("TRUE"),"Accelerometer","Gyroscope")
data_melt_Var$Body_Gravity<-ifelse(grepl("Body",data_melt_Var$Var)==c("TRUE"),"Body","Gravity")
data_melt_Var$Jerk<-ifelse(grepl("Jerk",data_melt_Var$Var)==c("TRUE"),"Yes","No")
data_melt_Var$Magnitude<-ifelse(grepl("Mag",data_melt_Var$Var)==c("TRUE"),"Yes","No")
data_melt_Var$Calculation<-ifelse(grepl("mean",data_melt_Var$Var)==c("TRUE"),"Mean","SD")
data_melt_Var$Axial<-ifelse(grepl("X",data_melt_Var$Var)==c("TRUE"),"X",ifelse(grepl("Y",data_melt_Var$Var)==c("TRUE"),"Y","Z"))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
setkey(data_melt_Var,Subject,Activity,Activity_Name,Var,time_freq,Acc_Gyro,Body_Gravity,Jerk,Magnitude,Calculation,Axial,value)
final_metric<-c(key(data_melt_Var))
data_tidy<-data_melt_Var[,final_metric, with=FALSE]
setkey(data_tidy,Subject,Activity,Activity_Name,Var,time_freq,Acc_Gyro,Body_Gravity,Jerk,Magnitude,Calculation,Axial,value)

data_tidy <- data_tidy[, list(Average = mean(value)), by = key(data_tidy)]
head(data_tidy)

# save the data as txt
write.csv(data_tidy, file = "CourseProject_TidyData.txt",row.names = FALSE)
