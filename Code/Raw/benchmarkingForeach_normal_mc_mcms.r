library(bigmemory)
library(foreach)
library(parallel)
library(doSNOW)
library(doMPI)


TESTING = F

sink("m.txt")

doForeach = function(){
  gc(reset = T)
  start.time<-proc.time()
  m = matrix(byrow = T, nrow = n)
  x = train[1:n, ]
  
  m = foreach(i = 1:n) %do% {
    sum(x[, "Id"] == i)
  }
  end.time<-proc.time()
  save.time<-end.time-start.time
  cat("FOREACH >> Number of minutes running:", save.time[3]/60, "\n")
  
   return(save.time[3])
}

doForeachMulticore = function(){
  numParallelCores = max(1, detectCores())
  cl = makeCluster(rep("localhost", numParallelCores), type = "SOCK")
  registerDoSNOW(cl)
  
  gc(reset = T)
  start.time<-proc.time()
  m = matrix(byrow = T, nrow = n)
  x = train[1:n, ]
  
  m = foreach(i = 1:n) %dopar% {
    sum(x[, "Id"] == i)
  }
  end.time<-proc.time()
  save.time<-end.time-start.time
  cat("FOREACH_MC >> Number of minutes running:", save.time[3]/60, "\n")
  
  return(save.time[3])
}

doForeachMutlicoreMultiSystem = function(){
  # create and register a doMPI cluster if necessary
  if (!identical(getDoParName(), 'doMPI')) {
    cl <- startMPIcluster()
    registerDoMPI(cl)
  }
  
  gc(reset = T)
  start.time<-proc.time()
  m = matrix(byrow = T, nrow = n)
  x = train[1:n, ]
  
  m = foreach(i = 1:n) %dopar% {
    sum(x[, "Id"] == i)
  }
  end.time<-proc.time()
  save.time<-end.time-start.time
  cat("FOREACH_MCMS >> Number of minutes running:", save.time[3]/60, "\n")
  
  return(save.time[3])
}


if (!exists("train"))
  train = attach.big.matrix("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/rainTrain.desc") 

noOfRowsUsedVector = c(10, 100, 1000, 10000)
results = matrix(byrow = T, ncol = 4 , c(noOfRowsUsedVector[1], NA, NA, NA
                         , noOfRowsUsedVector[2], NA, NA, NA
                         , noOfRowsUsedVector[3], NA, NA, NA
                         , noOfRowsUsedVector[4], NA, NA, NA
                        ))
colnames(results) = c("n", "foreach", "foreach_mc", "foreach_mcms")


for(n in noOfRowsUsedVector){
  cat("Number of rows: ", n, "\n")

  ## FOREACH
  results[results[,"n"] == n, "foreach"] = doForeach()
  gc()

  ## FOREACH Multicore
  # Multicore
  results[results[,"n"] == n, "foreach_mc"] = doForeachMulticore()
  gc()
  
  ## FOREACH Multicore Mutli-System
  results[results[,"n"] == n, "foreach_mcms"] = doForeachMutlicoreMultiSystem()
  gc()

}

results