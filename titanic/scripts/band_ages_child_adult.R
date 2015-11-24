## Script to create bands of ages (Child 16 and under, everyone else Adult, inc missing age values)

# add the survived column to the test data
test$Survived <- NA

# create a new data.frame that combines both train and test
combi <- rbind(train, test)

# assign Adult to all passengers (inc missing values in Age)
combi$AgeCategory <- "Adult"

# find passengers 16 and under and mark as children
combi$AgeCategory[combi$Age <= 16] <- "Child"

# split the data back into train and test
train <- combi[1:891,]
test <- combi[892:1309,]

# make sure the AgeCategory columns are factors in both sets
train$AgeCategory <- factor(train$AgeCategory)
test$AgeCategory <- factor(test$AgeCategory)