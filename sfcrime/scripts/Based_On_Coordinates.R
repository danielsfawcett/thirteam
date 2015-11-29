library(dplyr)
library(reshape2)
library(readr)
library(ggplot2)

#https://www.kaggle.com/petercooman/sf-crime/odds-based-on-pddistrict/files

# Read in the training data
data <- read.csv("train.csv")
# Combine X and Y columns and round to one decimal place 
data$X <- round(data$X, digits = 1)
data$Y <- round(data$Y, digits = 1)
data$X_Y <- as.factor(paste(data$X, data$Y, sep = " "))



# count of each crime category for each district
crimes_by_coordinate <- table(data$X_Y,data$Category)
# normalize the counts by the sum of the rows
crimes_by_coordinate_norm <- t(scale(t(crimes_by_coordinate), center = FALSE, scale = colSums(t(crimes_by_coordinate))))
# save as a data frame
crimes_by_coordinate_norm <- as.data.frame.matrix(crimes_by_coordinate_norm) 
# Round to four digits to reduce submission file size?
crimes_by_coordinate_norm <- round(crimes_by_coordinate_norm, digits = 4)

# add a a column with the PdDistrict (for merging later)
crimes_by_coordinate_norm$X_Y <- rownames(crimes_by_coordinate_norm)

# Read in the test data
test <- read.csv("test.csv")
# Combine X and Y columns and round to one decimal place 
test$X <- round(test$X, digits = 1)
test$Y <- round(test$Y, digits = 1)
test$X_Y <- as.factor(paste(test$X, test$Y, sep = " "))

# Only keep the Id and the X_Y column
submission <- subset(test, select = c("Id","X_Y"))
# Merge the test data with the normalized crimes_by_coordinates
submission <- merge(submission,crimes_by_coordinate_norm, by = "X_Y")
# Drop the X_Y column
submission$X_Y <- NULL

# Remove variables from submission file
rm(data)
rm(crimes_by_coordinate)
rm(crimes_by_coordinate_norm)
rm(test)

head(submission)
names(submission)

# Create the submission file
write.csv(submission, file = "Submission2.csv", row.names=FALSE,quote=FALSE)

