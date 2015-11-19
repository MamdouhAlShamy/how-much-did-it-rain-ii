require(ff)
require(ffbase)

train <-  read.csv.ffdf(file ="Data/Raw/train.csv"
						, header = T
						, VERBOSE=TRUE)

save.ffdf(train, dir="Data/Raw/train_ffdf")