##Submission22 - Tree using Class, Sex, AgeCategory, SibSp, Parch and Fare
## with rpart minbucket = 10 for pruning

# load the data
source('scripts/cleanData.R')

# load the required libraries for trees
source('scripts/install_libraries.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + AgeCat + Fare, data=train, control = rpart.control(minbucket = 10), method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission22.csv", row.names = FALSE)