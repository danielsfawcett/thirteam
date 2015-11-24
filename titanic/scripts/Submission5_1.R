##Submission5 - Tree using Class, Deck and Sex

# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

# load the required libraries for trees
source('scripts/install_libraries.R')

# extract the Title information we need
source('scripts/deck_finder.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + Deck, data=train, method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission5_1.csv", row.names = FALSE)