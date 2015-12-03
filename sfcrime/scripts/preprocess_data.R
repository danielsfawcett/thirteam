### Pre-processing cleaning of data

## Load both train and test data
source('scripts/load_data.R')

## Change DayOfWeek to orderd factors
train$DayOfWeek <- factor(train$DayOfWeek, ordered = TRUE, levels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'))
test$DayOfWeek <- factor(test$DayOfWeek, ordered = TRUE, levels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'))

## Change PdDistrict to factors
train$PdDistrict <- factor(train$PdDistrict)
test$PdDistrict <- factor(test$PdDistrict)

## Remove attributes not in test
train$Descript <- NULL
train$Resolution <- NULL

## Change Dates to time and engineer new time based attributes
train$Dates <- as.POSIXct(train$Dates, format = "%Y-%m-%d %T")
train$Date <- format(train$Dates, "%Y-%m-%d")
train$Time <- format(train$Dates, "%T")
train$AmPm <- format(train$Dates, "%p")

test$Dates <- as.POSIXct(test$Dates, format = "%Y-%m-%d %T")
test$Date <- format(test$Dates, "%Y-%m-%d")
test$Time <- format(test$Dates, "%T")
test$AmPm <- format(test$Dates, "%p")

