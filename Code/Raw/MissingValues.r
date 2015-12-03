suppressMessages(require(ggplot2))
suppressMessages(require(grid))

xplot = function(data){
	for(i in 4:4){
		df = data.frame(feature = data[, i], Expected = data[, 24])
		featureName = colnames(data)[i]
		# png(paste0("Figures/Raw/features/", featureName, "_vs_Exp.png", sp = ""))
		
		# p = qplot(df$Expected
		# 	, df$feature
		# 	# , method="lm"
		# 	, formula= y ~ x
	 #   		, main = paste0(featureName," vs Expected") 
		# 	, data = df
		# 	, xlab = "Expected"
		# 	, ylab = featureName
		# 	, geom = c("point"))

		png(paste0("Figures/Raw/featuresLog/", featureName, "_vs_Exp.png", sp = ""))

		p = ggplot(df, aes(x = Expected, y = feature)) +
		 		xlab("Expected (LogScale10)") + 
 				ylab(featureName) +
 				geom_dotplot() +
 				scale_x_log10()
		print(p)
		dev.off()
	}
}