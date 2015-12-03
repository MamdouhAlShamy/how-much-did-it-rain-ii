library(biglm)

order = c(4, 5, 9, 14, 15, 19, 23, 20, 21, 13, 8, 7, 18, 10, 22, 17, 6, 16, 11, 12)

reg1 = function(data){
	for(i in 4: (ncol(data)-1) ){
		form = paste("Expected", "~"
			, paste(paste0("", colnames(data)[4:i], ""), collapse = " + "))
		print(form)
						
		model1 = bigglm(data = data
			, formula= as.formula(form))
		print(summary(model1)$rsq)
	}
}

reg2 = function(data){
	form = paste("Expected", "~"
			, paste(paste0("", colnames(data)[order[1:6]], ""), collapse = " + "))
	print(form)
						
	model1 = bigglm(data = data, formula= as.formula(form))
	summary(model1)
	print(summary(model1)$rsq)
}

reg3 = function(data){
	form = paste("Expected", "~"
		, paste(paste0("", colnames(data)[4:(ncol(data)-1)], ""), collapse = " + "))
	print(form)
					
	model = bigglm(data = data
		, formula= as.formula(form))
	predict()
}
