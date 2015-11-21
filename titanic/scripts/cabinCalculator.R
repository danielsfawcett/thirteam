train <- read.csv("train.csv", stringsAsFactors=FALSE) #load the training data
test <- read.csv("test.csv", stringsAsFactors=FALSE) #load the test data

getDeck<-substr(train$Cabin, 0, 1)

#Code for function taken from: https://github.com/wehrley/wehrley.github.io/blob/master/SOUPTONUTS.md
imputeMedian <- function(impute.var, filter.var, var.levels) {
  for (v in var.levels) {
    impute.var[ which( filter.var == v)] <- impute(impute.var[ 
      which( filter.var == v)])
  }
  return (impute.var)
}
#--------------------

df<-data.frame(Survived = train$Survived, Fare = train$Fare, Ticket = train$Ticket, Deck = getDeck, PClass = train$Pclass)

# Code for computing the missing fares taken from: https://github.com/wehrley/wehrley.github.io/blob/master/SOUPTONUTS.md
df$Fare[df$Fare == 0] <- NA
df$Fare <- imputeMedian(df$Fare, df$PClass, 
                              as.numeric(levels(df$PClass)))
#------------------

df<-df[order(df$Fare),]

#df

#following code displays records where the deck is known and takes the median of the fares for each deck
knownDecks<-subset(df, df$Deck!="")
knownDecks[order(knownDecks$Deck),]
deckFares<-numeric()
for (d in c("A", "B", "C", "D", "E", "F", "G"))
{
  deckFares <-c(deckFares, median(knownDecks$Fare[which(knownDecks$Deck==d & knownDecks$Fare!="NA")]))
}
deckFares
#--------------

#prop.table(table(Deck = getDeck, Survived = train$Survived), 1)

