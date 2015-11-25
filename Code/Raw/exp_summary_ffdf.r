library(ff)
library(ffbase)
require(ggplot2)
require(grid)

# get data
load.ffdf(dir="/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Data/Raw/test_ffdf")
  
summaryStatisticPlotting = function(i, histo = TRUE, box = TRUE){
  # start.log()
  featureName = colnames(test)[i]
  feature_df <<- data.frame(featureName = test[, i])
  featureSummary = summary(feature_df$featureName)
  featureLimits = c(min(feature_df$featureName) , max(feature_df$featureName))
  print("data frame loaded")

  png(paste0("Figures/Raw/test_ffdf/test_", featureName,".png", sp = ""))
  # tiff(paste0("Figures/Raw/exp_ffdf/exp_", featureName,".tiff", sp = ""), compression = "lzw")

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
  featureName = colnames(test)[i]
  # no of NA's
  if (any(is.na(test[, i]))) {
    print(paste0(featureName, " has : ", sum(is.na(
      test[, i]
    )), " NA", sp = ""))
    
  }else{
    print(paste0(featureName, " has ZERO NA", sp = ""))
  }
  
  # summary
  print(summary(test[, i]))
}