train <- read.csv("train.csv", stringsAsFactors=FALSE) #load the training data
test <- read.csv("test.csv", stringsAsFactors=FALSE) #load the test data
test$Survived <- NA
combined<-rbind(train,test)

#Code for function taken from: https://github.com/wehrley/wehrley.github.io/blob/master/SOUPTONUTS.md
imputeMedian <- function(impute.var, filter.var, var.levels) {
  for (v in var.levels) {
    impute.var[ which( filter.var == v)] <- impute(impute.var[ 
      which( filter.var == v)])
  }
  return (impute.var)
}
#--------------------

getDeck<-substr(combined$Cabin, 0, 1)
df<-data.frame(Fare = combined$Fare, Ticket = combined$Ticket, Deck = getDeck, Cabin = combined$Cabin, PClass = combined$Pclass)

# Code for computing the missing fares taken from: https://github.com/wehrley/wehrley.github.io/blob/master/SOUPTONUTS.md
df$Fare[df$Fare == 0] <- NA
df$Fare <- imputeMedian(df$Fare, df$PClass, 
                        as.numeric(levels(df$PClass)))
#------------------

#following code displays records where the deck is known and takes the median of the fares for each deck
knownDecks<-subset(df, df$Deck!="")
deckFares<-numeric()
avgdeckFares<-numeric()
minmaxDF<-numeric()
for (d in c("A", "B", "C", "D", "E", "F", "G"))
{
  deckFares <-c(deckFares, median(knownDecks$Fare[which(knownDecks$Deck==d & knownDecks$Fare!="NA")]))
  avgdeckFares <-c(avgdeckFares, mean(knownDecks$Fare[which(knownDecks$Deck==d & knownDecks$Fare!="NA")]))
  minmaxDF<-c(minmaxDF, c(min(knownDecks$Fare[which(knownDecks$Deck==d & knownDecks$Fare!="NA")]), max(knownDecks$Fare[which(knownDecks$Deck==d & knownDecks$Fare!="NA")])))
}
deckFares
avgdeckFares
names(minmaxDF)<-c("minA", "maxA", "minB", "maxB", "minC", "maxC", "minD", "maxD", "minE", "maxE", "minF", "maxF", "minG", "maxG")
minmaxDF
#--------------

#Based on the fare range, assigns missing decks
df$Deck[df$Deck=="" & df$Fare >= minmaxDF["minA"] & df$Fare <= minmaxDF["maxA"]]<-"A"
df$Deck[df$Deck=="" & df$Fare >= minmaxDF["minB"] & df$Fare <= minmaxDF["maxB"]]<-"B"
df$Deck[df$Deck=="" & df$Fare >= minmaxDF["minC"] & df$Fare <= minmaxDF["maxC"]]<-"C"
df$Deck[df$Deck=="" & df$Fare >= minmaxDF["minD"] & df$Fare <= minmaxDF["maxD"]]<-"D"
df$Deck[df$Deck=="" & df$Fare >= minmaxDF["minE"] & df$Fare <= minmaxDF["maxE"]]<-"E"
df$Deck[df$Deck=="" & df$Fare >= minmaxDF["minF"] & df$Fare <= minmaxDF["maxF"]]<-"F"
df$Deck[df$Deck=="" & df$Fare >= minmaxDF["minG"] & df$Fare <= minmaxDF["maxG"]]<-"G"
#------------------

combined[, "Deck"]<-df$Deck
factor(combined$Deck)
train <- combined[1:891,]
test <- combined[892:1309,]

# remove the combined data frame
rm(combined)
rm(df)
rm(knownDecks)
