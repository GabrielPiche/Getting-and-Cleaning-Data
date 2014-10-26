#Loading the libraries I will be using
library(reshape)
library(plyr)

#Importing all the different datafiles I need
subject_train <- read.table("subject_train.txt", header=F)
x_test <- read.table("X_test.txt", header=F)
x_train <- read.table("X_train.txt", header=F)
y_test <- read.table("y_test.txt", header=F)
y_train <- read.table("y_train.txt", header=F)
activity_label <- read.table("activity_labels.txt", header=F)
features <- read.table("features.txt", header=F)

#Assigning the correct Variable labels for each files
colnames(subject_train) = "respondentID"
colnames(subject_test) = "respondentID"
colnames(y_train) = "activity"
colnames(x_train) = features[,2]
colnames(y_test) = "activity"
colnames(x_test) = features[,2]

#Making sure the labelling worked
head(subject_train)
head(subjest_test)
head(y_train)
head(x_train)

#Merging the training data frames in a single one using the cbind function
Training <- cbind(y_train, subject_train, x_train)

#Merging the testing data frames in a single one using the cbind function
Testing = cbind(y_test,subject_test,x_test);

#Merging the training and testing data frames in a single one using the rbind function this time.
DataF = rbind(Training,Testing);

# Keeping the activity and respondentID columns and keeping only the measurement names (mean and standard deviation)

variablesF = "mean|std|respondentID|activity"
DataF2 = DataF[,grep(variablesF , names(DataF), value=TRUE)]
LabelsF= gsub("\\(|\\)|-|,", "", names(DataF2))
names(DataF2) <- tolower(LabelsF)

#Summarize the data into the tidayDataF file
tidyDataF = ddply(DataF2, .(activity, respondentid), numcolwise(mean))

#Create a new .txt file containing the asked output.
write.table(tidyDataF, file="CourseProjectData.txt", sep = "\t", append=F, row.name=F)
