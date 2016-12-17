library(mlbench)
library(caret)
library(plyr)
library(dplyr)
library(ggplot2)
library(reshape2)
library(lubridate)
library(parallel)
library(doParallel)
library(RANN)
##download training data
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", 
              "C:/Users/dbrow/datasciencecoursera/Machine Learning/Data/trainingdata.csv")

##download testing data
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", 
              "C:/Users/dbrow/datasciencecoursera/Machine Learning/Data/testingdata.csv")
##read in data
setwd("C:/Users/dbrow/datasciencecoursera/Machine Learning/Data")
testing <- read.csv("testingdata.csv", na.strings = c("", "NA", "#DIV/0!"))
training <- read.csv("trainingdata.csv", na.strings = c("", "NA", "#DIV/0!"))

df <- data.frame(testing = sapply(testing, class), 
                 training = sapply(training, class))
df[!df$testing == df$training, ]

training[,c(8:159)] <- apply(training[,c(8:159)], 2, as.numeric)
testing[,c(8:159)] <- apply(testing[,c(8:159)], 2, as.numeric)

##unecessary
testing$cvtd_timestamp <- as.Date(dmy_hm(testing$cvtd_timestamp))
training$cvtd_timestamp <- as.Date(dmy_hm(training$cvtd_timestamp))
levels(testing$new_window) <- levels(training$new_window)

training <- training[,-c(1:7)]
testing <- testing[,-c(1:7)]

training <- training[,colSums(is.na(training)) < (dim(training)[2])/2]
testing <- testing[, which(names(testing) %in% names(training))]

x <- training[,-53]
y <- training[,53]

set.seed(1234)

cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)

fitControl <- trainControl(method = "cv",
                           number = 10,
                           allowParallel = TRUE)
fit <- train(x, y, method="rf", preProcess = c("knnImpute", "center", "scale", "BoxCox"), trControl = fitControl)

stopCluster(cluster)

fit
fit$resample
confusionMatrix.train(fit)

pred <- predict(fit, newdata = testing)
data.frame(Question = seq(from = 1, to = 20), prediction = pred)
