##Submission17 - Bayes using Class, Sex, Age, SibSp, Parch and Fare

# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

# clean the data
source('scripts/cleanData.R')

# load the required library for Bayes
if(!require('e1071')){
  install.packages('e1071')
  library('e1071')
}

# create the model
fit <- naiveBayes(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare, data=train)

# make the prediction using the model
Prediction <- predict(fit, test)

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission17.csv", row.names = FALSE)
