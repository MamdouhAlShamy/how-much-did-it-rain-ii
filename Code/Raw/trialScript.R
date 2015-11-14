library(bigmemory)
library(foreach)
library(parallel)
library(doSNOW)

TESTING = F

if (!exists("train"))
  train = attach.big.matrix("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/rainTrain.desc") 


library(magrittr)
library(dplyr)

  

library(ff)
df = read.csv.ffdf(file = "Data/Raw/train.csv", header = T)

head(df)

df_tbl = tbl_df(df)

df %>%
  filter(df$Id == 1)
str(train)
rm(df)

#### Get number of Observations for each Id

# FOR
gc(reset = T)
start.time<-proc.time()
n = 100
# n = max(train[,"Id"])
m = matrix(byrow = T, nrow = n)
x = train[1:n,]
# id = unique(train[,"Id"])
for (i in 1:n){
  z = nrow(x[x[,"Id"] == i,])
  m[i] = z  
}
m
end.time<-proc.time()
save.time<-end.time-start.time
cat("\n Number of minutes running:", save.time[3]/60, "\n\n")
gc()

## SUM
gc(reset = T)
start.time<-proc.time()
n= 100
m = matrix(byrow = T, nrow = n)
x = train[1:n, ]
for( i in 1:n)
  m[i] = sum(x[,"Id"] == i)
m
end.time<-proc.time()
save.time<-end.time-start.time
cat("\n Number of minutes running:", save.time[3]/60, "\n\n")
gc()

## FOREACH
gc(reset = T)
start.time<-proc.time()
n= 100
m = matrix(byrow = T, nrow = n)
x = train[1:n, ]

m = foreach(i = 1:n) %do% {
  sum(x[, "Id"] == i)
}
m
end.time<-proc.time()
save.time<-end.time-start.time
cat("\n Number of minutes running:", save.time[3]/60, "\n\n")
gc()


## FOREACH PARALLEL
# Parallel
numParallelCores = max(1, detectCores() - 1)
cl = makeCluster(rep("localhost", numParallelCores), type = "SOCK")
registerDoSNOW(cl)

gc(reset = T)
start.time<-proc.time()
n= 100
m = matrix(byrow = T, nrow = n)
x = train[1:n, ]

m = foreach(i = 1:n) %dopar% {
  sum(x[, "Id"] == i)
}
m
end.time<-proc.time()
save.time<-end.time-start.time
cat("\n Number of minutes running:", save.time[3]/60, "\n\n")
gc()


#

start.log()
n = max(train[,"Id"])
m = matrix(byrow = T, ncol = 2)
id = unique(train[,"Id"])
for (i in id){
  cnt = nrow(train[train[,"Id"] == i,])
  m = rbind(m, c(i, cnt))  
}
end.log()
