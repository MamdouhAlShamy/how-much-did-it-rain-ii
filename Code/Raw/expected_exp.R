source("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/Functions.R")
require(ggplot2)
require(grid)

# png("Expected_exp.png")

# define grid
pushViewport(viewport(layout = grid.layout(3, 1, heights = unit(c(1, 4, 4), "null"))))
grid.text("Expected"
	, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))


# get data
train = loadTrainInBigMatrix()
train_df <- data.frame(Expected = train[,24])
train_df_expect_summary = summary(train_df$Expected)
print("data frame loaded")
rm(train)
gc() 


start.log()


histogram = ggplot(train_df, aes(Expected)) +
 xlab("Expected (LogScale10)") + 
 ylab("Freq") +
 geom_histogram() +
 scale_x_log10() +
 geom_vline(xintercept = train_df_expect_summary["Mean"]
 			, color = "red"
 			, size = 1) +
 geom_vline(xintercept = train_df_expect_summary["Median"]
 			, color = "blue"
 			, size = 1)
print("hist done")


boxplot = qplot(x = 1
	, y = train_df$Expected
	, geom = "boxplot") +
	coord_flip() +
 	geom_hline(yintercept = train_df_expect_summary["Mean"]
 			, color = "red"
 			, size = 1)	+
 	geom_hline(yintercept = train_df_expect_summary["Median"]
 			, color = "blue"
 			, size = 1)
print("boxplot done")



print(histogram, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(boxplot, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))

# dev.off()
end.log()


# no of NA's
if (any(is.na(train_df))){
	print(paste("Expected has : ", sum(is.na(train_df)), " NA", sp = "" ) ) 

}else{
	print("Expected has ZERO NA")
}

# summary
print(train_df_expect_summary)
