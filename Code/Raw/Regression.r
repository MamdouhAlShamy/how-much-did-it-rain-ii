suppressMessages(library(biglm))
suppressMessages(library(neuralnet))

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


regressionMultipleForms = function(featuresUsed, type, train){
	for(i in featuresUsed){
		
		form = paste("Expected", "~", paste(paste0("", colnames(train)[featuresUsed[1]:i], ""), collapse = " + "))
		print(form)

		regression(form, type, train)
	}
	return("NONE")
}

regression = function(form, type, train){	
	model = glm(data = train
			, formula= as.formula(form)
			, family = type
			)
	modelObjectName = "regressionModel.rds"
	saveRDS(model, modelObjectName)
	print(paste(modelObjectName, " created"))
}

measureModelPerformance = function(model, y){
	y_predicted = predict(model)

	metric = getRegressionMetric(y, y_predicted)
	print(paste("Rsq: ", metric$Rsq))
	print(paste("RMSE: ", metric$RMSE))
	print("----------------------------------------------------")
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


neuralNetwork = function(featuresUsed, hiddenLayersParameters, rep, train){
	form = paste("Expected", "~", paste(paste0("", colnames(train)[featuresUsed], ""), collapse = " + "))
	print(form)

	print("Modelling")
	model = neuralnet(data = train
						, formula = as.formula(form)
						, hidden = hiddenLayersParameters
					)
	# plot(model)
	print("Getting y_predicted")
	y_predicted = as.vector(compute(model, train[, featuresUsed])$net.result)
	y = train[, 24]

	print("Getting Metric")
	metric = getRegressionMetric(y, y_predicted, rep = rep)
	print(paste("Rsq: ", metric$Rsq))
	print(paste("RMSE: ", metric$RMSE))	

}

getRegressionMetric = function(y, y_predicted){
	n = length(y)
	# print(n)
	res = y - y_predicted	
	SSres = sum((res)^2)
	SStot = sum((y - mean(y))^2)
	Rsq = 1 - (SSres/SStot)	
	RMSE = sqrt(SSres/n)
	Rsq2 <- cor(y,y_predicted)^2	
	metric = list(RMSE = RMSE, Rsq = Rsq, Rsq2 = Rsq2, SStot = SStot, SSres = SSres, n = n)
	return(metric)
}