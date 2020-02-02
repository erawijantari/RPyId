set.seed(0)
ship_vol <- c(rnorm(75, mean = 37000, sd = 2500))

ship_vol

set.seed(0)
pre_Treatment <- c(rnorm(2000, mean = 150, sd = 10))
post_Treatment <- c(rnorm(2000, mean = 144, sd = 9))
t.test(pre_Treatment, post_Treatment, paired = TRUE)

wilcox.test(pre_Treatment, post_Treatment, paired = TRUE)
raw.data <- read.table("datasets/GDS3309.clean", sep="\t", header=TRUE) 
dim(raw.data)

data <- raw.data[,-c(1,2)]
boxplot(data)
data2 <- log2(data)
boxplot(data2, main=expression(paste("Boxplot of the log2  data"))

#create the lables
labels <- c(rep("control", 8), rep("smokers", 7))
result <- t.test( data2[1, labels == 'control'], data2[1, labels == 'smokers'], var.equal=F )
result

#create functions
my.ttest <- function(v, labels)
{
  levels <- unique(labels)
  v1 <- v[ labels == levels[1]]
  v2 <- v[ labels == levels[2]]
  pval <- t.test(v1, v2, var.equal = F)$p.value
  pval
}

allpvalues <- apply(data2, 1, my.ttest, labels)
sig.inds <- which(allpvalues < 0.001)
sig.inds


create heatmap
library(gplots)

data.sig <- as.matrix(data2[sig.inds,])
rownames(data.sig) <- raw.data[sig.inds,2]
heatmap.2((data.sig))
heatmap.2(as.matrix(data.sig), scale="row")
