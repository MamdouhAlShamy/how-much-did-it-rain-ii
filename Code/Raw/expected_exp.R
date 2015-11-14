source("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/Functions.R")

require(ggplot2)
require(grid)

png("plot.png")
# define grid
pushViewport(viewport(layout = grid.layout(3, 1, heights = unit(c(1, 4, 4), "null"))))
grid.text("Expected"
	, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))


# get data
train = loadTrainInBigMatrix()

start.log()

# Make horizontal Boxplot
# boxplot(train[ , 24]
        # , main= colnames(train)[24]
        # , horizontal = T)
# print(">> Boxplot Done")

# make histogram
# hist(train[, 24]
#      , main = colnames(train)[24]
#      , col = "lightgreen"
#      # , add=T
#      )
# print(">> histogram Done")

# # Density
# curve(density(train[, 24]
# 		# , from = 0
# 		# , to = max(train[, 24])
# 		)
# 	, col= "darkblue"
# 	, add=TRUE
# )
# print(">> density Done")


# WORKING FINE BUT ISSUE W THE SCALE NOT REPRESENTIVE ENOUGH so MOVING TO LOGSCALE
# nf = layout(mat = matrix(c(1,2), 2, 1, byrow=TRUE)
# 			, height = c(3, 1)
# 	)

# par(mar=c(3.1, 3.1, 1.1, 2.1))

limits = c(min(train[,24]), max(train[,24]) )
# hist.data = hist(train[, 24]
# 	, col = "pink"
# 	, xlim = limit
# 	, plot = F)
# hist.data$
# print(">> histogram Done")

# boxplot(train[,24]
# 	, horizontal = T
# 	, outline = T
# 	, frame = F
# 	, ylimit = limit
# 	, col = "green1"
# 	# , add= T
# 	)
# print(">> Boxplot Done")


train_df <- data.frame(Expected = train[,24])
train_df_expect_summary = summary(train_df$Expected)
print("data frame loaded")

rm(train)
gc() 


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


# grid.draw(rbind(ggplotGrob(histogram),
                # ggplotGrob(boxplot),
                # size = "first")) 

print(histogram, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(boxplot, vp = viewport(layout.pos.row = 3, layout.pos.col = 1))




# fig2 <- ggplot(data = train_df, aes(x = "Exp")) +
#   geom_histogram(binwidth = 1) +
#   scale_x(expand = c(0,0), limit = c(10, 35))

# grid.draw(rbind(ggplotGrob(fig1),
#                 ggplotGrob(fig2),
#                 size = "first"))

dev.off()
end.log()
# no of NA's

# summary


## Matrix of the above

## Matrix Scatterplot