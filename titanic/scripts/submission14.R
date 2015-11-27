#### Submission 14 - Clean data and then create random forest using AgeCat
#### instead of Age.

## CLean data
source('scripts/cleanData.R')

# load the required libraries for trees
source('scripts/install_libraries.R')

# create the model
fit <- randomForest(Survived ~ Pclass + Sex + AgeCat + SibSp + Parch + Fare, data = train)

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission14.csv", row.names = FALSE)