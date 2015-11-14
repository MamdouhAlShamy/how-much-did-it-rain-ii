library(bigmemory)
library(RColorBrewer)

TESTING = F

if (!exists("train"))
  train = attach.big.matrix("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/rainTrain.desc") 

noOfObservations = length(train[,1])

noOfEmptyValues = c()
countingVector = c()

if(TESTING){
  countingVector = 20:24
}else{
  countingVector = 1:length(colnames(train))
}

# Get number of Empty Values
for (i in countingVector){
  noOfEmptyValues[i] = sum(is.na(train[,i]))
}

if(TESTING){
  Kdp = c(noOfEmptyValues[20], noOfObservations - noOfEmptyValues[20])
  Kdp_5x5_10th = c(noOfEmptyValues[21], noOfObservations - noOfEmptyValues[21])
  Kdp_5x5_50th = c(noOfEmptyValues[22], noOfObservations - noOfEmptyValues[22])
  Kdp_5x5_90th = c(noOfEmptyValues[23], noOfObservations - noOfEmptyValues[23])
  Expected = c(noOfEmptyValues[24], noOfObservations - noOfEmptyValues[24])
}else{
  Id = c(noOfEmptyValues[1], noOfObservations - noOfEmptyValues[1])
  minutes_past = c(noOfEmptyValues[2], noOfObservations - noOfEmptyValues[2])
  radardist_km = c(noOfEmptyValues[3], noOfObservations - noOfEmptyValues[3])
  
  Ref = c(noOfEmptyValues[4], noOfObservations - noOfEmptyValues[4])
  Ref_5x5_10th = c(noOfEmptyValues[5], noOfObservations - noOfEmptyValues[5])
  Ref_5x5_50th = c(noOfEmptyValues[6], noOfObservations - noOfEmptyValues[6])
  Ref_5x5_90th = c(noOfEmptyValues[7], noOfObservations - noOfEmptyValues[7])
  RefComposite = c(noOfEmptyValues[8], noOfObservations - noOfEmptyValues[8])
  RefComposite_5x5_10th = c(noOfEmptyValues[9], noOfObservations - noOfEmptyValues[9])
  RefComposite_5x5_50th = c(noOfEmptyValues[10], noOfObservations - noOfEmptyValues[10])
  RefComposite_5x5_90th = c(noOfEmptyValues[11], noOfObservations - noOfEmptyValues[11])
  
  RhoHV = c(noOfEmptyValues[12], noOfObservations - noOfEmptyValues[12])
  RhoHV_5x5_10th = c(noOfEmptyValues[13], noOfObservations - noOfEmptyValues[13])
  RhoHV_5x5_50th = c(noOfEmptyValues[14], noOfObservations - noOfEmptyValues[14])
  RhoHV_5x5_90th = c(noOfEmptyValues[15], noOfObservations - noOfEmptyValues[15])
  
  Zdr = c(noOfEmptyValues[16], noOfObservations - noOfEmptyValues[16])
  Zdr_5x5_10th = c(noOfEmptyValues[17], noOfObservations - noOfEmptyValues[17])
  Zdr_5x5_50th = c(noOfEmptyValues[18], noOfObservations - noOfEmptyValues[18])
  Zdr_5x5_90th = c(noOfEmptyValues[19], noOfObservations - noOfEmptyValues[19])
  
  Kdp = c(noOfEmptyValues[20], noOfObservations - noOfEmptyValues[20])
  Kdp_5x5_10th = c(noOfEmptyValues[21], noOfObservations - noOfEmptyValues[21])
  Kdp_5x5_50th = c(noOfEmptyValues[22], noOfObservations - noOfEmptyValues[22])
  Kdp_5x5_90th = c(noOfEmptyValues[23], noOfObservations - noOfEmptyValues[23])
  
  Expected = c(noOfEmptyValues[24], noOfObservations - noOfEmptyValues[24])
}

if(TESTING)
{ 
  df = data.frame(Kdp, Kdp_5x5_10th, Kdp_5x5_50th, Kdp_5x5_90th, Expected)
}else
  df= data.frame(Id, minutes_past, radardist_km, Ref, Ref_5x5_10th, Ref_5x5_50th, Ref_5x5_90th
                 , RefComposite, RefComposite_5x5_10th, RefComposite_5x5_50th, RefComposite_5x5_90th
                 , RhoHV, RhoHV_5x5_10th, RhoHV_5x5_50th, RhoHV_5x5_90th
                 , Zdr, Zdr_5x5_10th, Zdr_5x5_50th, Zdr_5x5_90th
                 , Kdp, Kdp_5x5_10th, Kdp_5x5_50th, Kdp_5x5_90th, Expected)
  

m = as.matrix(df)
par(oma = c(0,3,0,0))
barplot(m
        , main = "Na Percentage"
        , horiz = T
        , axes = F
        , col = brewer.pal(2, "Paired")
        , las = 2)
