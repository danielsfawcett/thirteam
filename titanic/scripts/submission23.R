##Submission23 - Tree using Class, Sex, AgeCategory

# load the data
source('scripts/cleanData.R')

# load the required libraries for trees
source('scripts/install_libraries.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + AgeCat, data=train, method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission23.csv", row.names = FALSE)