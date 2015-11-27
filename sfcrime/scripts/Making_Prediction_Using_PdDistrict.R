library(dplyr)
library(reshape2)
library(readr)
library(ggplot2)

# Read in the training data
data <- read_csv("train.csv")

# count of each crime category for each district
crimes_by_district <- table(data$PdDistrict,data$Category)
# normalize the counts by the sum of the rows
crimes_by_district_norm <- t(scale(t(crimes_by_district), center = FALSE, scale = colSums(t(crimes_by_district))))
# save as a data frame
crimes_by_district_norm <- as.data.frame.matrix(crimes_by_district_norm) 
# Round to four digits to reduce submission file size?
crimes_by_district_norm <- round(crimes_by_district_norm, digits = 4)

# add a a column with the PdDistrict (for merging later)
crimes_by_district_norm$PdDistrict <- rownames(crimes_by_district_norm)

# Read in the test data
test <- read_csv("test.csv")

# Only retain the Id and the PdDistrict
submission <- subset(test, select = c("Id","PdDistrict"))
# Merge the test data with the normalized crimes_by_district
submission <- merge(submission,crimes_by_district_norm, by = "PdDistrict")
# Drop the PdDistrict column
submission$PdDistrict <- NULL

# Remove variables from the workspace to create enough space to create the submission file
rm(data)
rm(crimes_by_district)
rm(crimes_by_district_norm)
rm(test)

head(submission)
names(submission)

# Create the submission file
write.csv(submission, file = "Based_on_PdDistrict.csv", row.names=FALSE,quote=FALSE)
file.info("Based_on_PdDistrict.csv")$size