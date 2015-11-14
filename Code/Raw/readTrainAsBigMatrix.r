# read Train -only made once-
library(bigmemory)

train = read.big.matrix("Data/Raw/train.csv"
                , header = T
                , backingfile = "rainTrain.bin"
                , descriptorfile = "rainTrain.desc"
                , type = "integer")
