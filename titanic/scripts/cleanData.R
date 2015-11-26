# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

# add the survived column to the test data
test$Survived <- NA

# create a new data.frame that combines both train and test
combi <- rbind(train, test)

# assume that missing embarakation data is for Southampton passengers given name
combi$Embarked[combi$PassengerId == 62 | combi$PassengerId == 830] <- 'S'

######### Extract and normalise the titles ###########

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

###################################################

## class as adult or child
##combi$AgeCat <- as.character(combi$AgeCat)
combi$AgeCat[combi$Age >= 18 | combi$Title == 'Mrs' | combi$Title == 'Mr' | combi$Title == 'Dr' | combi$Title == 'Ms'] <- 'Adult'
combi$AgeCat[combi$Age < 18] <- 'Child'
combi$AgeCat[combi$Title == 'Master'] <- 'Child'
combi$AgeCat[is.na(combi$Age) & combi$Parch > 2] <- 'Adult'
combi$AgeCat[is.na(combi$Age) & combi$SibSp > 1] <- 'Child'
combi$AgeCat[is.na(combi$Age) & combi$Parch == 0 & combi$SibSp == 0] <- 'Adult'
combi$AgeCat[is.na(combi$Age) & combi$Parch > 0 & combi$Title == 'Miss'] <- 'Adult'
combi$AgeCat[is.na(combi$AgeCat)] <- 'Unknown'

# update to factors
combi$Pclass <- factor(combi$Pclass)
combi$Sex <- factor(combi$Sex)
combi$Embarked <- factor(combi$Embarked)
combi$AgeCat <- factor(combi$AgeCat)
combi$Title <- factor(combi$Title)
combi$Survived <- factor(combi$Survived)


# split the data back into train and test
train <- combi[1:891,]
test <- combi[892:1309,]

