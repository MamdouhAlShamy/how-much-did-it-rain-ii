suppressMessages(library(biglm))

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

reg2 = function(train){
	form = paste("Expected", "~"
			, paste(paste0("", colnames(train)[order[1:6]], ""), collapse = " + "))
	print(form)
						
	model1 = bigglm(data = train, formula= as.formula(form))
	summary(model1)
	print(summary(model1)$rsq)
}

reg3 = function(featuresUsed, train, test){
	form = paste("Expected", "~", paste(paste0("", colnames(train)[featuresUsed], ""), collapse = " + "))
	print(form)
					
	model = bigglm(data = train
					, formula= as.formula(form))
	res = predict(model, newdata = test)
	return(res)
}

learnrReg3 = function(featuresUsed, train){
	form = paste("Expected", "~", paste(paste0("", colnames(train)[featuresUsed], ""), collapse = " + "))
	print(form)
					
	model = bigglm(data = train
					, formula= as.formula(form))
	return(model)
}

pred3 = function(model, test){
	res = predict(model, newdata = test)
	return(res)
}


logReg = function(featuresUsed, train, test){
	form = paste("Expected", "~"
		, paste(paste0("", colnames(train)[featuresUsed], ""), collapse = " + "))
	print(form)

	model = glm(data = train
			, formula= as.formula(form)
			, family = binomial(link = "logit")
			)
	res = predict(model, newdata = test)
	return(res)

}