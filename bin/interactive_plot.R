library(DESeq2)
library(plotly)
library(ggplot2)

counts <- read.table("gene_counts.txt", header=TRUE, row.names=1)

pca <- prcomp(t(counts), scale.=TRUE)
p <- plot_ly(
  x = pca$x[,1],
  y = pca$x[,2],
  type = "scatter",
  mode = "markers"
)

htmlwidgets::saveWidget(p, "PCA_interactive.html")
