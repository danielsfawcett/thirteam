## Calculates and adds family size to the data
## Assumes that train and test have been loaded already

# add the survived column to the test data
test$Survived <- NA

# create a new data.frame that combines both train and test
combi <- rbind(train, test)

# add the familySize column
combi$familySize <- combi$SibSp + combi$Parch + 1

# split the data back into train and test
train <- combi[1:891,]
test <- combi[892:1309,]