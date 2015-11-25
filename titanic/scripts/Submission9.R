##Submission9 - Tree using Class, Deck, Sex and Age

# load the data
train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

# load the required libraries for trees
source('scripts/install_libraries.R')

# predict the ages
source('scripts/estimate_ages.R')

# extract the age category information we need
source('scripts/band_age_C_YC_A_YA.R')

# extract the Deck information we need
source('scripts/deck_finder.R')

# create the model
fit <- rpart(Survived ~ Pclass + Sex + Deck + AgeCategory, data=train, method="class")

# make the prediction using the model
Prediction <- predict(fit, test, type = "class")

# create the submission file
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "submissions/submission9.csv", row.names = FALSE)