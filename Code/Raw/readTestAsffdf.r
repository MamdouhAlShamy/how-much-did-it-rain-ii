require(ff)
require(ffbase)

test <-  read.csv.ffdf(file ="Data/Raw/test.csv"
						, header = T
						, VERBOSE=TRUE)

save.ffdf(test, dir="Data/Raw/test_ffdf")