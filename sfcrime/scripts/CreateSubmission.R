samp<-read.csv("~/Documents/Crime/sampleSubmission.csv")
samp$WARRANTS<-0


#Load files here


write.csv(samp, file = "~/Documents/Crime/Submission.csv")
