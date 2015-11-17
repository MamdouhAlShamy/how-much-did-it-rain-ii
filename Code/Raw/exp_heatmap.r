source("/media/mms/HomeLand/Know/DataAnalysisProjects/HowMuchDidItRainII/Code/Raw/Functions.R")


train = loadTrainInBigMatrix()


x = matrix()

limit = 3:23

for (i in limit){
	m = cor(x = train[,i], y = train[, 24], use="complete.obs")
	x <<- rbind(x, m)
	print(paste0(m, " ", i, " col DONE"))
}

# print(mcor)
# colnames(mcor) = colnames(train)
cor_df = data.frame(featureName = colnames(train)[limit], correlation = as.vector(x[-1,]) ) 
# row.names(cor_df) = colnames(train)[limit]

print(cor_df)

library(ggplot2)
library(gridExtra)

svg("Figures/Raw/Correlation.svg")
ggplot(cor_df, aes(x=featureName, y= correlation, fill=correlation))+
geom_bar(stat="identity")+
theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
scale_color_brewer(type = "div", palette = 2)+
scale_y_continuous(limits=c(-0.25, 0.25))



dev.off()