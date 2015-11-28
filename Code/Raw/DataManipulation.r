# compact training data
suppressMessages(library(ff))
suppressMessages(library(ffbase))
suppressMessages(library(ffbase2))
suppressMessages(library(magrittr))

dataPath = "/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Data/Raw/"

removeEmptyRef = function(src, dest ){
	load.ffdf(dir = paste0(dataPath, src) )

	data = data %>% 
		filter(!is.na(Ref))

	save.ffdf(data, dir=paste0(dataPath, dest) )

}

compactObservationsToOneRow = function(src, dest){
	load.ffdf(dir = paste0(dataPath, src) )
	
	data = data %>%
		tbl_ffdf() %>%
		group_by(Id) %>%
		summarise(avg = mean(data[,4]))

	save.ffdf(data, dir = paste0(dataPath, dest))
}