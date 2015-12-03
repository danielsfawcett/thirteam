### Submission 2 - Simple proportions of categories in each district

## Load and clean the data
source('scripts/preprocess_data.R')

## Create the submit data frame
categories <- sort(unique(train$Category))
header <- c('Id')
header <- append(header, categories)
submit_matrix <- matrix(prop.table(table(PdDistrict = train$PdDistrict, Category = train$Category), 1), ncol = 39)
submit_matrix <- round(submit_matrix, 5)
submit <- as.data.frame(submit_matrix)
names(submit) <- categories
submit <- cbind(PdDistrict = unique(train$PdDistrict), submit)

final <- matrix(nrow = 884262)
final <- data.frame(final)
final$Id <- test$Id
final$final <- NULL
final$PdDistrict <- test$PdDistrict
final <- merge(final,submit, by = 'PdDistrict')
final$PdDistrict <- NULL

## Create the csv file
write.csv(final, file = "submissions/submission3.csv", row.names=FALSE,quote=FALSE)