##Source code from: http://trevorstephens.com/post/72918760617/titanic-getting-started-with-r-part-1-booting

## Create data.frame called submit and then run this to create
## a file called submission.csv in your working directory
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "submission.csv", row.names = FALSE)