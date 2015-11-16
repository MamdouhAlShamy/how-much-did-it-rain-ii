source("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/Functions.R")
require(ggplot2)
require(grid)

summaryStatistic = function(i, histo = TRUE, box = TRUE){
  # start.log()
  
  # get data
  train = loadTrainInBigMatrix()
  featureName = colnames(train)[i]
  # featureName = "kdr"
  feature_df <<- data.frame(featureName = train[, i])
  # feature_df <<- data.frame(featureName = c(1,2,4,5,6,9,9,2,2,3,4,2,4,5,3,1))
  featureSummary = summary(feature_df$featureName)
  featureLimits = c(min(feature_df$featureName) , max(feature_df$featureName))
  print("data frame loaded")
  rm(train)
  gc()
  
  png(paste0("Figures/Raw/exp_", featureName,".png", sp = ""))
  
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
      ylim(featureLimits) +
      coord_flip() +
      geom_hline(yintercept = featureSummary["Mean"]
                 , color = "red"
                 , size = 1)	+
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
  
  # no of NA's
  if (any(is.na(feature_df$featureName))) {
    print(paste0(featureName, " has : ", sum(is.na(
      feature_df$featureName
    )), " NA", sp = ""))
    
  }else{
    print(paste0(featureName, " has ZERO NA", sp = ""))
  }
  
  # summary
  print(featureSummary)
  
  # end.log()
}