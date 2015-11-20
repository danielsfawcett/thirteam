##Submission1 - Gender based model
train <- read.csv("train.csv", stringsAsFactors=FALSE) #load the training data
test <- read.csv("test.csv", stringsAsFactors=FALSE) #load the test data
prop.table(table(Sex = train$Sex, Survived = train$Survived), 1) #show the relationship between gender and survival
test$Survived <- rep(0,418) #predict that everyone dies
test$Survived[test$Sex == "female"] <- 1 #predict that all women survived

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived) # create the submission file
write.csv(submit, file = "submissions/submission1.csv", row.names = FALSE)