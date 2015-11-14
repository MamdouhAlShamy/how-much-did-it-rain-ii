start.time = 0

loadTrainInBigMatrix = function(){
  library(bigmemory)
  
  if (!exists("train"))
    train = attach.big.matrix("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Data/Raw/rainTrain.desc") 
  print(">> train bigmemory loaded")
  return(train)
}

start.log = function(){
  gc(reset = T)
  start.time<-proc.time()
}


end.log = function(){
  end.time<-proc.time()
  save.time<-end.time-start.time
  cat("\n Number of minutes running:", save.time[3]/60, "\n\n")
  gc()
}
