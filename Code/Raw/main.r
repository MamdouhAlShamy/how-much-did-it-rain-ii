#main.r
codePath = "/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/"
# source(paste0(codePath, "ReadCsvSaveffdf.r"))
# source(paste0(codePath, "DataManipulation.r"))
source(paste0(codePath, "SummaryStatistics.r"))


# readCsvSaveffdf("train.csv", "train")

# getObservations("trainCleaned", "trainPart", 100000)

# compactObservationsToOneRow("testCleaned", "testCleanedCompact")
# print(readData("trainPart"))

# nrow(readData("testCleanedCompact"))

getCorrelation()