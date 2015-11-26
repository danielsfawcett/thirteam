######## REQUIRES TRAIN AND TEST SETS TO BE LOADED IN WORKSPACE ALREADY ########

## Extract the surname from each observation and add it as 
## an additional column to both train and test datasets, called Surname.
## Adapted from http://trevorstephens.com/post/73461351896/titanic-getting-started-with-r-part-4-feature

# add the survived column to the test data
test$Survived <- NA

# create a new data.frame that combines both train and test
combi <- rbind(train, test)

# ensure we are dealing with char type
combi$Name <- as.character(combi$Name)

# extract the surname from each observation and place it in a new column
combi$Surname <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})

# split the data back into train and test
train <- combi[1:891,]
test <- combi[892:1309,]

# remove the combined data frame
rm(combi)
