# Merging the coordinates together and then finding the total of all the crimes in that area


## Prevalent Crimes in San Francisco

# Will need to install these packages to run the code
#install.packages("plyr", repos = "http://cran.r-project.org")
#install.packages("dplyr", repos = "http://cran.r-project.org")
#install.packages("ggplot2", repos = "http://cran.r-project.org")
#install.packages("readr", repos = "http://cran.r-project.org")

# https://www.kaggle.com/ifness/sf-crime/prevalent-crimes-in-san-francisco/code   Use code from this link

library(plyr)
library(dplyr)
library(ggplot2)
library(readr)

## Load data
trainSF <- read_csv("train.csv")

## Filter categories
trainSF <- filter(trainSF, Category != "OTHER OFFENSES",
                Category != "NON-CRIMINAL")


## Create area factor by rounding lon e lat
trainSF$X_round <- round_any(trainSF$X, 0.005)
trainSF$Y_round <- round_any(trainSF$Y, 0.005)
trainSF$X_Y <- as.factor(paste(trainSF$X_round, trainSF$Y_round, sep = " "))


## Prevalent category by area, connecting the category of crime to the area in which it had taken place
prevalent <- function(x){as.character(
  unique(
    x$Category[x$Category == names(which.max(table(x$Category)))
               ]
  )
)
}

prevalent_crime <- ddply(trainSF, .(X_Y, X_round, Y_round), prevalent)
names(prevalent_crime) <- c("X_Y", "X", "Y", "Category")
prevalent_crime$Category <- as.factor(prevalent_crime$Category)

## Filter areas with less than 50 Crimes
counts <- ddply(trainSF, .(X_Y), dim)$V1
prevalent_crime <- mutate(prevalent_crime, counts = counts)
prevalent_crime <- filter(prevalent_crime, counts > 100)
prevalent_crime <- arrange(prevalent_crime, X_Y)


sum(prevalent_crime$counts)