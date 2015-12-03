suppressMessages(library(ff))
suppressMessages(library(ffbase))
suppressMessages(require(ggplot2))
suppressMessages(require(grid))

dataPath = "/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Data/Raw/"


# get data
loadData = function(src){
  load.ffdf(dir = paste0(dataPath, src) )
  return(data)
}

plotting = function(data, i, histo = TRUE, box = TRUE){
  # start.log()
  featureName = colnames(data)[i]
  feature_df <<- data.frame(featureName = data[, i])
  featureSummary = summary(feature_df$featureName)
  featurefeaturesIndexXs = c(min(feature_df$featureName) , max(feature_df$featureName))
  print("data frame loaded")

  png(paste0("Figures/Raw/data/", featureName,".png", sp = ""))

  # define grid
  pushViewport(viewport(layout = grid.layout(3, 1, heights = unit(c(
    1, 4, 4
  ), "null"))))
  grid.text(
    featureName
    , vp = viewport(layout.pos.row = 1, layout.pos.col = 1)
    , gp = gpar(col = "red", fontsize = 24)
  )

  
  if (histo) {
    # Histogram
    histogram = ggplot(data = feature_df
                       , aes(x = feature_df$featureName)) +
      xlab(featureName) +
      ylab("Freq") +
      geom_histogram() +
      geom_vline(xintercept = featureSummary["Mean"]
                 , color = "red"
                 , size = 1) +
      geom_vline(xintercept = featureSummary["Median"]
                 , color = "blue"
                 , size = 1)
    print("Histogram done")
  }

  
  if (box) {
    # # Boxplot
    boxplot = qplot(x = 1
                    , y = feature_df$featureName
                    , geom = "boxplot") +
      ylim(featurefeaturesIndexXs) +
      coord_flip() +
      geom_hline(yintercept = featureSummary["Mean"]
                 , color = "red"
                 , size = 1)  +
      geom_hline(yintercept = featureSummary["Median"]
                 , color = "blue"
                 , size = 1)
    print("Boxplot done")
  }
  
  # Combine plots
  if(histo)
    print(histogram, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
  if(box) 
    print(boxplot, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))
  
  print("plotting Done")
  
  dev.off()
  
}

dataInNumbers = function(i){
  featureName = colnames(data)[i]
  # no of NA's
  if (any(is.na(data[, i]))) {
    print(paste0(featureName, " has : ", sum(is.na(
      data[, i]
    )), " NA", sp = ""))
    
  }else{
    print(paste0(featureName, " has ZERO NA", sp = ""))
  }
  
  # summary
  print(summary(data[, i]))
}


getCorrelation = function(src, featuresIndexX, featuresIndexY){

  data = loadData(src)
  x = matrix()

  for (i in featuresIndexX){
    m = cor(x = data[,i], y = data[, featuresIndexY], use="complete.obs")
    x = rbind(x, m)
    print(paste0(m, " ", i, " column DONE"))
  }
  # print(x)

  # convert Correlation Matrix to DF and ignore the first NA in matrix
  correlation_df = data.frame(featureName = colnames(data)[featuresIndexX]
    , correlation = as.vector(x[-1,]) ) 

  print(correlation_df)

  suppressMessages(library(gridExtra))

  png("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Figures/Raw/CorrelationX.png")

  ggplot(correlation_df
    , aes(x=featureName, y= correlation, fill=correlation))+
  geom_bar(stat="identity")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_color_brewer(type = "div", palette = 2)+
  scale_y_continuous(limits=c(-0.25, 0.25))

  dev.off()
}


## replaced by python code
getNumberOfCompletelyPresentFeaures = function(data){
  numberOfCompletelyPresentFeaures = 0
  for(i in 1:nrow(data)){
    if(any(is.na(data[i,]))){
      numberOfCompletelyPresentFeaures = numberOfCompletelyPresentFeaures + 1
    }
  }

  return(numberOfCompletelyPresentFeaures)
}