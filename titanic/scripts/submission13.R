#### Submission 13 - Clean data and then create tree as in submission 3 except using AgeCat
#### instead of Age.

## Clean data
source('scripts/cleanData.R')

# load the required libraries for trees
source('scripts/install_libraries.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + Fare, data=train, method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission13.csv", row.names = FALSE)