##Submission4 - Tree using Class, Sex, AgeCategory, SibSp, Parch and Fare

# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

# load the required libraries for trees
source('scripts/install_libraries.R')

# Band the Ages to Category
source('scripts/band_ages_child_adult.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + AgeCategory + SibSp + Parch + Fare, data=train, method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission4.csv", row.names = FALSE)