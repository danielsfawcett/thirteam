## Add the family size, title and familyName columns to train and test

## load the data
train <- read.csv("~/github/thirteam/titanic/train.csv", stringsAsFactors=FALSE)
test <- read.csv("~/github/thirteam/titanic/test.csv", stringsAsFactors=FALSE)

# add the survived column to the test data
test$Survived <- NA

# create a new data.frame that combines both train and test
combi <- rbind(train, test)

# ensure we are dealing with char type
combi$Name <- as.character(combi$Name)

######### Extract and normalise the titles first ###########

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

######## Extract the family name ##########

# extract the surname from each observation and place it in a new column
combi$Surname <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})

######## Add the family size ########

# add the familySize column
combi$FamilySize <- combi$SibSp + combi$Parch + 1

####### Add a family category #########
combi$FamilyCat[combi$FamilySize <= 2] <- 'Small'
combi$FamilyCat[combi$FamilySize > 2 & combi$FamilySize <= 4] <- 'Medium'
combi$FamilyCat[combi$FamilySize > 4] <- 'Large'


######## Restore the train and test datasets with the new data #########

train <- combi[1:891,]
test <- combi[892:1309,]

# make sure the title columns are factors in both sets
train$Title <- factor(train$Title)
test$Title <- factor(test$Title)
train$FamilyCat <- factor(train$FamilyCat)
test$FamilyCat <- factor(test$FamilyCat)

## remove the combi data frame
##rm(combi)