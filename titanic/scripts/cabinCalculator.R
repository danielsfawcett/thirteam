train <- read.csv("train.csv", stringsAsFactors=FALSE) #load the training data
test <- read.csv("test.csv", stringsAsFactors=FALSE) #load the test data
combined <- rbind(train, test)

getDeck<-substr(combined$Cabin, 0, 1)

#Code for function taken from: https://github.com/wehrley/wehrley.github.io/blob/master/SOUPTONUTS.md
imputeMedian <- function(impute.var, filter.var, var.levels) {
  for (v in var.levels) {
    impute.var[ which( filter.var == v)] <- impute(impute.var[ 
      which( filter.var == v)])
  }
  return (impute.var)
}
#--------------------

df<-data.frame(Fare = combined$Fare, Ticket = combined$Ticket, Deck = getDeck, Cabin = combined$Cabin, PClass = combined$Pclass)

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
minmaxDF
#--------------

#prop.table(table(Deck = getDeck, Survived = train$Survived), 1)

#Function that counts the number of cabins per row and divides the fare by that number
#This gives the price per cabin. there's ambiguity about the number of people in the cabins (children), and wrongly filled in record 
#Later add code for N/A cabins: if ticket is unique, then check where fare would place it. else divide it and then check  
knownCabins<-subset(df, df$Cabin!="")
knownCabins<-subset(knownCabins, !duplicated(knownCabins$Ticket))
knownCabins[order(knownCabins$Cabin),]

cabins<-character()
nCabins<-double()
for (c in knownCabins$Cabin)
{
  cabins<-strsplit(c, " ")[[1]]
  nCabins<-c(nCabins, length(cabins))
}


knownCabins[, "NumberCabins"]<-nCabins
knownCabins

knownCabins[knownCabins$NumberCabins>1 & !duplicated(knownCabins$Ticket),] #Records where a set of cabins is registered for only one person(ticket appears once)
knownCabins[knownCabins$NumberCabins>1 & duplicated(knownCabins$Ticket)] #Records where a set of cabins is registered for multiple people(ticket appears>1)

knownCabins$Fare[is.na(knownCabins$Fare)] <- knownCabins$Fare/knownCabins$NumberCabins
knownCabins[order(knownCabins$Ticket),]

####First count how many times each ticket appears and divide the fare by the number of tickets
##This gives the price per person for that ticket. 
duplicateTickets<-df$Ticket[duplicated(df$Ticket)]
duplicateTickets

numdup<-integer(length(duplicateTickets))
numDuplicated<-data.frame(Ticket=duplicateTickets, NumOfDup = numdup)
numDuplicated

for (t in df$Ticket)
{
  if (t %in% duplicateTickets)
  {
    numDuplicated$NumOfDup[numDuplicated$Ticket==t]<-numDuplicated$NumOfDup+1
  }
}
numDuplicated[order(numDuplicated$Ticket),]
#-----------------------------

for (dt in df$Ticket)
{
  if (dt %in% numDuplicated)
  {
    df$Fare[df$Ticket==dt]<-df$Fare/numDuplicated$NumOfDup[df$Ticket==dt]
  }
  else if(!(dt %in% numDuplicated) & dt %in% knownCabins$Ticket)
  {
    f<-knownCabins[knownCabins$Ticket==dt,]
    df$Fare[df$Ticket==dt]<-f$Fare/numDuplicated$NumOfDup[df$Ticket==dt]
  }
  
}

df[order(df$Ticket),]

