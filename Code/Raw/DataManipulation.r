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
		# summarise(Ref = mean(Ref))
		summarise(
			minutes_past = mean(minutes_past, na.rm = T)
			, radardist_km = mean(radardist_km, na.rm = T)
			, Ref = mean(Ref, na.rm = T)
			, Ref_5x5_10th = mean(Ref_5x5_10th, na.rm = T)
			, Ref_5x5_50th = mean(Ref_5x5_50th, na.rm = T)
			, Ref_5x5_90th = mean(Ref_5x5_90th, na.rm = T)
			, RefComposite = mean(RefComposite, na.rm = T)
			, RefComposite_5x5_10th = mean(RefComposite_5x5_10th, na.rm = T)
			, RefComposite_5x5_50th = mean(RefComposite_5x5_50th, na.rm = T)
			, RefComposite_5x5_90th = mean(RefComposite_5x5_90th, na.rm = T)
			, RhoHV = mean(RhoHV, na.rm = T)
			, RhoHV_5x5_10th = mean(RhoHV_5x5_10th, na.rm = T)
			, RhoHV_5x5_50th = mean(RhoHV_5x5_50th, na.rm = T)
			, RhoHV_5x5_90th = mean(RhoHV_5x5_90th, na.rm = T)
			, Zdr = mean(Zdr, na.rm = T)
			, Zdr_5x5_10th = mean(Zdr_5x5_10th, na.rm = T)
			, Zdr_5x5_50th = mean(Zdr_5x5_50th, na.rm = T)
			, Zdr_5x5_90th = mean(Zdr_5x5_90th, na.rm = T)
			, Kdp = mean(Kdp, na.rm = T)
			, Kdp_5x5_10th = mean(Kdp_5x5_10th, na.rm = T)
			, Kdp_5x5_50th = mean(Kdp_5x5_50th, na.rm = T)
			, Kdp_5x5_90th = mean(Kdp_5x5_90th, na.rm = T)
			, Expected = mean(Expected, na.rm = T)
			)

	save.ffdf(data, dir = paste0(dataPath, dest))
}

 getObservations = function(src, dest, n){
 	load.ffdf(dir = paste0(dataPath, src) )

	data = data %>% 
		filter(Id <= n)

	save.ffdf(data, dir=paste0(dataPath, dest) )

 }