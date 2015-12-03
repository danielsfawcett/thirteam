### Submission 3 - Simple proportions of categories in each district

## Load and clean the data
source('scripts/preprocess_data.R')

## Get a vector of categories
categories <- sort(unique(train$Category))

### Get a vector of attrribute names
header <- c('Id')
header <- append(header, categories)

### Create a matrix of the proportion of each category in each district in the train set
prop_matrix <- matrix(prop.table(table(PdDistrict = train$PdDistrict, Category = train$Category), 1), ncol = 39)

### Round the values to 5 places to reduce final file size
prop_matrix <- round(prop_matrix, 5)

### Convert the matrix to a data frame
prop_df <- as.data.frame(prop_matrix)

### Name the attributes
names(prop_df) <- categories

### Add the PdDistrict column in first position
prop_df <- cbind(PdDistrict = unique(train$PdDistrict), prop_df)

### Create an matrix for our submission and convert to data frame immediately
submit <- matrix(nrow = 884262)
submit <- data.frame(submit)

### Add the Id numbers for each record in test
submit$Id <- test$Id

### Remove the unrequired attribute that was created when we created the data frame
submit$submit <- NULL

### Add the PdDistrict column
submit$PdDistrict <- test$PdDistrict

### Create the submission by joining the proportion data from for each district with the submission frame
submit <- merge(submit,submit, by = 'PdDistrict')

### Remove the PdDistric column that was used to join the data from the final submisssion
submit$PdDistrict <- NULL

## Create the csv file
write.csv(submit, file = "submissions/submission3.csv", row.names=FALSE,quote=FALSE)