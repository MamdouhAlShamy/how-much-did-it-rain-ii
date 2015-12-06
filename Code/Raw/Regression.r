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


regression = function(featuresUsed, type, train){
	for(i in featuresUsed){
		form = paste("Expected", "~", paste(paste0("", colnames(train)[featuresUsed[1]:i], ""), collapse = " + "))
		print(form)

		model = glm(data = train
				, formula= as.formula(form)
				, family = type
				)
		y_predicted = predict(model)
		y = train[, 24]
		metric = getRegressionMetric(y, y_predicted)
		print(paste("Rsq: ", metric$Rsq))
		print(paste("RMSE: ", metric$RMSE))
		print("----------------------------------------------------")
	}
	return("NONE")
}

func = function(featuresUsed, train){
	suppressMessages(library(relaimpo))
	form = paste("Expected", "~"
		, paste(paste0("", colnames(train)[featuresUsed], ""), collapse = " + "))
	print(form)

	model = lm(form, data = train)
	print("model done")
	calc.relimp(model,type=c("lmg","last","first","pratt"),
	            rela=TRUE)
	
	print("calc.relimp done")
	# Bootstrap Measures of Relative Importance (1000 samples)
	boot <- boot.relimp(model
	                    , b = 1000
	                    , type = c("lmg","last", "first", "pratt")
	                    , rank = TRUE
	                    ,diff = TRUE
	                    , rela = TRUE)
	print("boot generated")
	booteval.relimp(boot) # print result
	print("ready to plot")
	png("featureRelativeImportance.png")
	p = plot(booteval.relimp(boot,sort=TRUE)) # plot result 
	print(p)
	dev.off()
}


getRegressionMetric = function(y, y_predicted){
	res = y - y_predicted
	n = length(y)
	SSres = sum((res)^2)
	SStot = sum((y - mean(y))^2)
	Rsq = 1 - (SSres/SStot)	
	RMSE = sqrt(SSres/n)	
	metric = list(RMSE = RMSE, Rsq = Rsq, SStot = SStot, SSres = SSres, n = n, res = res)
	return(metric)
}