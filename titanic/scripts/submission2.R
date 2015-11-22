##Submission2 - Tree using Title, Class and Sex

# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

# load the required libraries for trees
source('scripts/install_libraries.R')

# extract the Title information we need
source('scripts/extract_titles.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + Title, data=train, method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission2.csv", row.names = FALSE)