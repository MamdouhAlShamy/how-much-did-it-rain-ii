#main.r
codePath = "/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/"
source(paste0(codePath, "ReadCsvSaveffdf.r"))
# source(paste0(codePath, "DataManipulation.r"))
source(paste0(codePath, "Regression.r"))
# source(paste0(codePath, "SummaryStatistics.r"))
# source(paste0(codePath, "MissingValues.r"))

# compactObservationsToOneRow("test", "testCompact")
# print(readData("trainPart"))

# modelValues = predict(object = model1, newdata = data)

# res = data$Expected - modelValues

# rmse = sqrt(rmse = sqrt( (1/nrow(data)) * sum(res^2 ) ))
# print(rmse)

# library(DAAG)
# cv.lm(df = data, model1, m=3)

# data = readData("testCleanedCompact")
# df = data.frame(Id = as.data.frame(data[1]), Expected = 1)
# write.csv(df, "data.csv", row.names=FALSE)


#################################################
 
# data = readData("trainCleanedCompact")
# reg1(data)

#1
# data = readData("trainCleanedCompact")
# x = getNumberOfCompletelyPresentFeaures(data)
# print(x)

#2
# removeEmptyFeature("trainCleaned", "trainExtraCleaned")
#3
# compactObservationsToOneRow("trainExtraCleaned", "trainExtraCleanedCompact")




# if not in testCleanedCompact set value to zero
# sample = readData("sample")
# data = readData("testCleanedCompact")

# df = data.frame()
# Id = c()
# Expected = c()
# for(i in 1:10){
# 	if(sample[i,1] %in% data[, 1]){
# 		df = rbind(df, data.frame(sample[i,]))
# 	}else{
# 		df = rbind(df, data.frame(Id = i, Expected = 0))
# 	}
# }


####################


# head(df)


# data = readData("trainCleaned")
# write.csv(data, "trainCleaned.csv", row.names=FALSE)


# readCsvSaveffdf("trainIgnoreNATuples.csv", "trainIgnoreNATuples")

# replaceNaForEachFeatureWithItsMean("trainCleaned", "trainCleanedMeaned")


# data = readData("trainCleanedMeaned")
# reg1(data)


# compactObservationsToOneRow("trainCleanedMeaned", "trainCleanedMeanedCompact")


# data = readData("trainCleanedMeanedCompact")
df = data.frame(Id = c(1,2,3,4), v = c(1,5,10,15), exp = c(22,33,44,55))
reg3(data)

