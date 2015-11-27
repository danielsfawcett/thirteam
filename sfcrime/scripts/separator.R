train <- read.csv("train.csv", stringsAsFactors=FALSE)
test <- read.csv("test.csv", stringsAsFactors=FALSE)

comb<-data.frame(Dates=c(train$Dates, test$Dates), Address=c(train$Address, test$Address), DayOfWeek=c(train$DayOfWeek, test$DayOfWeek), PDDistrict=c(train$PdDistrict, test$PdDistrict))

#Separate the Date column into 'Time' and 'Date' of the crime
comb$Time<-sapply(as.character(comb$Dates), FUN=function(x){strsplit(x, split=' ')[[1]][2]})
comb$Dates<-sapply(as.character(comb$Dates), FUN=function(x){strsplit(x, split=' ')[[1]][1]})
comb$Day<-sapply(as.character(comb$Dates), FUN=function(x){strsplit(x, split='-')[[1]][3]})
comb$Month<-sapply(as.character(comb$Dates), FUN=function(x){strsplit(x, split='-')[[1]][2]})
comb$Year<-sapply(as.character(comb$Dates), FUN=function(x){strsplit(x, split='-')[[1]][1]})
#------------------------


#Add a column indicating whether the crime occurred at a block or behind a corner
comb$BlockOrCorner<-sapply(as.character(comb$Address), FUN=function(x){
  addr<-strsplit(x, split=' ')[[1]]
  if ('/' %in% addr)
    return ('corner')
  else
    return ('block')})
#------------------------

#Extracts the exact street(location) from the address and places it in a new column
comb$ExactPlace[comb$BlockOrCorner=='block']<-sapply(as.character(comb$Address[comb$BlockOrCorner=='block']), FUN=function(x){
  addr<-strsplit(x, split=' ')[[1]]
  return (addr[length(addr)-1])})

comb$ExactPlace[comb$BlockOrCorner=='corner']<-sapply(as.character(comb$Address[comb$BlockOrCorner=='corner']), FUN=function(x){
  addr<-strsplit(x, split=' ')[[1]]
  return (paste (addr[length(addr)-4], addr[length(addr)-1], sep = ', ' , collapse = NULL))})
#------------------------

#Split train and test back:
train<-cbind(train[,2:9], comb[1:878049,5:10])
test<-cbind(test, comb[878050:1762311,5:10])




