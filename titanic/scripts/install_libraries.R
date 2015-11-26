## Make sure the required libraries are installed and loaded

## rattle
if(!require('rattle')){
  install.packages('rattle')
  library('rattle')
}

## rpart
if(!require('rpart')){
  install.packages('rpart')
  library('rpart')
}

## rpart.plot
if(!require('rpart.plot')){
  install.packages('rpart.plot')
  library('rpart.plot')
}

## RColorBrewer
if(!require('RColorBrewer')){
  install.packages('RColorBrewer')
  library('RColorBrewer')
}

## randomForest
if(!require('randomForest')){
  install.packages('randomForest')
  library('randomForest')
}