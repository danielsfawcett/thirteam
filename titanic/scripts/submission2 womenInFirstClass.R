train <- read.csv("train.csv", stringsAsFactors=FALSE) #load the training data
test <- read.csv("test.csv", stringsAsFactors=FALSE) #load the test data
prop.table(table(Class = train$Pclass, Sex = train$Sex, Survived = train$Survived), 1) #show the relationship between gender and survival based on the different classes
test$Survived <- rep(0,418) #predict that everyone dies
test$Survived[test$Sex == "female" & test$Pclass == "1"] <- 1 #predict that all women in 1st class survived
data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "submissions/submission2.csv", row.names = FALSE)

