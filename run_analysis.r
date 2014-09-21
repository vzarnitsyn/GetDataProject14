setwd("C:/Coursera/Get data/Project/UCI HAR Dataset")
#read activity labels
activity_labels<-read.table("activity_labels.txt")[,2]
#read features
features<-read.table("features.txt")
# read training set
X_train<-read.table("train/X_train.txt")
# read test set
X_test<-read.table("test/X_test.txt")
#combine the train and test sets by rows
X_full<-rbind(X_train,X_test)
#name columns of X_full
names(X_full)<-features[,2]

#read training activity codes
Y_train<-read.table("train/Y_train.txt")
#read test activity codes
Y_test<-read.table("test/Y_test.txt")
#combine the train and test sets by rows
Y_full<-rbind(Y_train,Y_test)

#read training subject description
Subj_train<-read.table("train/subject_train.txt")
#read test subject description
Subj_test<-read.table("test/subject_test.txt")
#combine the train and test sets by rows
Subj_full<-rbind(Subj_train,Subj_test)

#find features with mean or std but no meanfreq
## find columns with mean as part of a name 
iscolummean<-grepl("mean",features[,2])
## find columns with std as part of a name
iscolumstd<-grepl("std",features[,2])
## find columns with meanfreq as part of the name
iscolummeanfreq<-grepl("meanfreq",ignore.case=TRUE,features[,2])
##finally mark all column of interest
columns_int<-(iscolumstd | iscolummean)& !(iscolummeanfreq)
# select all proper columns
X_full_sub<-X_full[,columns_int]
# creat a tidy data set
# first column with a name Subject ID has subject ID
#second column has description of activity returned by reading activity label using the key from Y_train
#the rest is from select columns from X_train
Full_set<-data.frame(SubjectID=Subj_full[,1],Activity=activity_labels[Y_full[,1]],X_full_sub)
# write tidy set to full_set.csv
write.csv(Full_set,"full_set.csv",row.names=FALSE)

# This code was prepared on later date and some repetions are due to it
library(dplyr)
setwd("C:/Coursera/Get data/Project/UCI HAR Dataset")
Full_set<-read.csv("full_set.csv")
#select all column names with mean present
iscolummean<-grepl("mean",names(Full_set))
#select also 1st column Subject
iscolummean[1]<-TRUE
#select also 2nd column Activity
iscolummean[2]<-TRUE
#Creat separate set with selected columns
Full_mean_set<-Full_set[,iscolummean]
#group rows by SubjectID and Activity
grouped_set<-group_by(Full_mean_set,SubjectID,Activity)
#apply mean and summarise each column except SubjectID and Activity used for grouping
Final_set<-summarise_each(grouped_set,funs(mean))
#results saved to csv file subject_activity_mean_values.csv
write.table(Final_set,"subject_activity_mean_values.txt",row.names=FALSE)
