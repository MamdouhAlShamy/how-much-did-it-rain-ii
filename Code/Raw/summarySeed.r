## get Number of observations for each Id
library(doMPI)
library(foreach)

source("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/Functions.R")

sink("result.txt")

PARALLEL = TRUE

train = loadTrainInBigMatrix()

if(PARALLEL)
  if (!identical(getDoParName(), 'doMPI')) {
    cl <- startMPIcluster()
    registerDoMPI(cl)
  }

n = max(train[, "Id"])
print(n)
start.log()

m = foreach(i = 1:n, .combine = 'rbind') %do% {
  sum(train[, "Id"] == i)
}

print(">> Foreach Done")
write.csv(m, file="m.csv")
print(">> m.csv saved")
end.log()
sink()

