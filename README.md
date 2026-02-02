# Bulk RNA-seq Nextflow Pipeline

End-to-end bulk RNA-seq analysis pipeline using Nextflow.

## Features
- FastQC + fastp QC
- STAR alignment
- featureCounts quantification
- RSeQC metrics
- MultiQC summary
- Interactive PCA & QC plots (Plotly)

## Run
```bash
nextflow run main.nf -profile docker
