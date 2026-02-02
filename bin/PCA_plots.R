meta <- read.csv("samplesheet.csv")

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData   = meta,
  design    = ~ batch + condition
)

pca <- plotPCA(vst(dds), intgroup = c("condition", "batch"), returnData=TRUE)

plot_ly(
  data = pca,
  x = ~PC1,
  y = ~PC2,
  color = ~condition,
  symbol = ~batch,
  text = ~sample
)
