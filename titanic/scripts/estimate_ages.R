## Script to create bands of ages (Child 16 and under, everyone else Adult, inc missing age values)

# add the survived column to the test data
test$Survived <- NA

# load the required libraries for trees
source('scripts/install_libraries.R')
# Getting "Title" from extrat_titles
source('scripts/extract_titles.R')

# create a new data.frame that combines both train and test
combi <- rbind(train, test)

# Buldiing the Age Model   
# In data on rpart check only the rows that are in train and are not NA 
AgeModel <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Title, data=train[!is.na(train$Age),], method="anova")    
              
# make the prediction using the model
combi$EstAge <- predict(AgeModel, combi, type = "vector")
combi$Age[is.na(combi$Age)] <- combi$EstAge[is.na(combi$Age)]

combi$EstAge <- NULL



# split the data back into train and test
train <- combi[1:891,]
test <- combi[892:1309,]