train<-read.csv("~/Documents/Crime/train.csv")
test<-read.csv("~/Documents/Crime/test.csv")

comb<-data.frame(Dates=c(as.character(train$Dates), as.character(test$Dates)), Address=c(as.character(train$Address), as.character(test$Address)), DayOfWeek=c(as.character(train$DayOfWeek), as.character(test$DayOfWeek)), PDDistrict=c(as.character(train$PdDistrict), as.character(test$PdDistrict)))


comb$Time<-sapply(comb$Dates, FUN=function(x){strsplit(x, split=" ")[[1]][2]})
comb$Dates<-sapply(comb$Dates, FUN=function(x){strsplit(x, split=' ')[[1]][1]})