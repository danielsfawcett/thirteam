##Submission11 - Tree using Class, Sex, Age, SibSp, Parch, Fare and FamilyCat

# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

## call the familySize script
source('scripts/familyInfo.R')

# load the required libraries for trees
source('scripts/install_libraries.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + FamilyCat, data=train, method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission11.csv", row.names = FALSE)