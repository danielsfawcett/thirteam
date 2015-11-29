##Submission18 - Bayes using Class, Sex, Age, SibSp, Parch and Fare
## with laplace smoothing

# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

# clean the data
source('scripts/cleanData.R')

# estimate ages
source('scripts/estimate_Ages.R')

# load the required library for Bayes
if(!require('e1071')){
  install.packages('e1071')
  library('e1071')
}

# create the model
fit <- naiveBayes(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare, data=train, laplace = 3)

# make the prediction using the model
Prediction18 <- predict(fit, test)

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction18)
write.csv(submit, file = "submissions/submission18.csv", row.names = FALSE)
