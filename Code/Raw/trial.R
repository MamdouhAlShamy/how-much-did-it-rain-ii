library(doParallel)
# cl = makeCluster(2)
registerDoParallel()

gc(reset = T)
start.time<-proc.time()
getDoParWorkers()
foreach(i  = 1:300) %dopar% {
  x = sqrt(i)
}
end.time<-proc.time()
save.time<-end.time-start.time
cat("\n Number of minutes running:", save.time[3]/60, "\n\n")
gc()
