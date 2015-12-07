suppressMessages(library("neuralnet"))
codePath = "/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/" 
source(paste0(codePath, "Regression.r"))

#Going to create a neural network to perform sqare rooting
#Type ?neuralnet for more information on the neuralnet library
 
#Generate 50 random numbers uniformly distributed between 0 and 100
#And store them as a dataframe
traininginput <-  as.data.frame(runif(50, min=0, max=100))
trainingoutput <- sqrt(traininginput)
 
#Column bind the data into one variable
trainingdata <- cbind(traininginput,trainingoutput)
colnames(trainingdata) <- c("Input","Output")
 
#Train the neural network
#Going to have 10 hidden layers
#Threshold is a numeric value specifying the threshold for the partial
#derivatives of the error function as stopping criteria.
model <- neuralnet(Output~Input,trainingdata, hidden=10, threshold=0.01)
 
#Plot the neural network
# plot(model)
 
#Test the neural network on some training data
# testdata <- as.data.frame((1:10)^2) #Generate some squared numbers
# net.results <- compute(model, testdata) #Run them through the neural network
 
#Lets see what properties model has
# print("net.results")
# ls(net.results)
# y_predicted_test = net.results$net.result 


#Lets see the results
y_predicted = as.vector(compute(model, traininginput)$net.result)
y = trainingdata$Output
metric = getRegressionMetric(y, y_predicted)
print(paste("Rsq: ", metric$Rsq))
print(paste("RMSE: ", metric$RMSE))

#Lets display a better version of the results
# cleanoutput <- cbind(testdata,sqrt(testdata), as.data.frame(net.results$net.result))
# colnames(cleanoutput) <- c("Input","Expected Output","Neural Net Output")
# print(cleanoutput)