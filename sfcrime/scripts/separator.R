train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

comb<-data.frame(Dates=c(train$Dates, test$Dates), Address=c(train$Address, test$Address), DayOfWeek=c(train$DayOfWeek, test$DayOfWeek), PDDistrict=c(train$PdDistrict, test$PdDistrict))

comb$Time<-sapply(as.character(comb$Dates), FUN=function(x){strsplit(x, split=' ')[[1]][2]})
comb$Dates<-sapply(as.character(comb$Dates), FUN=function(x){strsplit(x, split=' ')[[1]][1]})
