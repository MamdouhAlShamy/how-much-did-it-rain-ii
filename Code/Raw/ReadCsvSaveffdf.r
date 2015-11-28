suppressMessages(library(ff))
suppressMessages(library(ffbase))

dataPath = "/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Data/Raw/"

readCsvSaveffdf = function(src, dest){
	data <-  read.csv.ffdf(file =paste0(dataPath, src)
						, header = T
						, VERBOSE=TRUE)

	save.ffdf(data, dir=paste0(dataPath, dest))	
}

