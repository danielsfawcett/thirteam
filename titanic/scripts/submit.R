##Source code from: http://trevorstephens.com/post/72918760617/titanic-getting-started-with-r-part-1-booting

## Add a column called "Survived" to the test data frame that holds your prediction
## and then run the following.
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "submission.csv", row.names = FALSE)