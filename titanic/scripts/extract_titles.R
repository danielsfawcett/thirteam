######## REQUIRES TRAIN AND TEST SETS TO BE LOADED IN WORKSPACE ALREADY ########

## Extract the title from each observation and add it as 
## an additional column to both train and test datasets, called Title.
## Adapted from http://trevorstephens.com/post/73461351896/titanic-getting-started-with-r-part-4-feature

# add the survived column to the test data
test$Survived <- NA

# create a new data.frame that combines both train and test
combi <- rbind(train, test)

# ensure we are dealing with char type
combi$Name <- as.character(combi$Name)

# extract the title from each observation and place it in a new column
combi$Title <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][2]})

# repalce the first space with an empty string to strip whitespace
combi$Title <- sub(' ', '', combi$Title)

# replace Mme (Madame) with Mrs
combi$Title[combi$Title == 'Mme'] <- 'Mrs'

# replace Mlle (Madamoiselle) with Miss
combi$Title[combi$Title == 'Mlle'] <- 'Miss'

# replace Jonkheer and Don with Sir
combi$Title[combi$Title %in% c('Jonkheer','Don')] <- 'Sir'

# replace Dona with Lady
combi$Title[combi$Title == 'Dona'] <- 'Lady'

# split the data back into train and test
train <- combi[1:891,]
test <- combi[892:1309,]

# make sure the title columns are factors in both sets
train$Title <- factor(train$Title)
test$Title <- factor(test$Title)

# remove the combined data frame
rm(combi)
