samp<-read.csv("sampleSubmission.csv")
samp$WARRANTS<-0


#Load files here


write.csv(samp, file = "Submissions/Submission.csv")
