# nf-reproducible-rnaseq

A **Nextflow DSL2 bulk RNA-seq pipeline** demonstrating **nf-core–style design principles** with **simple, readable branching** for **STAR (alignment-based)** and **Salmon (alignment-free)** quantification.
This repository contains the workflow logic only; all biological data and references are user-provided.

Ideas behind the repo -
* Showcase **Nextflow + nf-core best practices**
* Remain **easy to understand and customize**


---

## Features

* Robust paired-end FASTQ auto-detection (no fixed naming required)
* Modular workflow with **STAR or Salmon** branches
* End-to-end: FASTQ → QC → Quantification → DEG
* Fail-fast validation (nf-core philosophy)
* Conda / container friendly
* Clear separation of biological metadata from upstream processing

---

## Repository structure

```
nf-reproducible-rnaseq/
├── main.nf                 # Main Nextflow DSL2 pipeline
├── nextflow.config         # Profiles (local / conda / HPC-ready)
├── README.md               # This file
├── scripts/
│   ├── deseq2.R            # DEG for STAR + featureCounts branch
│   └── salmon_deseq2.R     # DEG for Salmon branch (tximport-style)
├── envs/
│   └── environment.yml     # Conda environment (optional)
├── raw_fastq/              # Input FASTQ files (user-provided)
├── reference/              # Reference indices (user-provided)
│   ├── star_index/
│   ├── salmon_index/
│   └── annotation.gtf
└── metadata.csv            # Sample metadata (user-provided)
```


## Supported analysis paths

### 1.STAR (alignment-based, gene-level counts)

```
FASTQ → FastQC → Trimming → STAR → featureCounts → DESeq2
```

### 2.Salmon (alignment-free, transcript-level)

```
FASTQ → FastQC → Trimming → Salmon → tximport → DESeq2
```

Switch between them with a **single parameter**.

---

## Input requirements

### FASTQ files

* Paired-end Illumina reads
* Any of the following naming styles are supported:

```
sample_1.fastq.gz / sample_2.fastq.gz
sample_R1.fastq.gz / sample_R2.fastq.gz
sample_read1.fq.gz / sample_read2.fq.gz
sample_L001_R1.fastq.gz / sample_L001_R2.fastq.gz
```

Place files in:

```
raw_fastq/
```

---

### Metadata file (`metadata.csv`)

The metadata file is **only required for differential expression analysis**.

Example:

```csv
sample,condition
sample1,Control
sample2,Control
sample3,Treated
sample4,Treated
```

* `sample` must match FASTQ basename
* `condition` is used in the DESeq2 design formula

---

### tx2gene.csv file for Salmon branch

Example:

```csv
transcript,gene
ENST00000456328,ENSG00000223972
ENST00000450305,ENSG00000223972
```
---


## Reference requirements

### STAR branch

* Pre-built STAR genome index:

```
reference/star_index/
```

### Salmon branch

* Pre-built Salmon transcriptome index:

```
reference/salmon_index/
```

### Annotation

```
reference/annotation.gtf
```

---

## How to run

### 1.STAR pipeline

```bash
nextflow run main.nf \
  --quantifier star \
  --star_index reference/star_index \
  --gtf reference/annotation.gtf
```

### 2.Salmon pipeline

```bash
nextflow run main.nf \
  --quantifier salmon \
  --salmon_index reference/salmon_index
```

---

## Useful parameters

| Parameter      | Description          | Default                     |
| -------------- | -------------------- | --------------------------- |
| `--quantifier` | `star` or `salmon`   | `star`                      |
| `--reads`      | FASTQ glob pattern   | `raw_fastq/*.{fastq,fq}.gz` |
| `--outdir`     | Output directory     | `results`                   |
| `--cpus`       | Threads per process  | `8`                         |
| `--strand`     | featureCounts strand | `2`                         |

---

## Outputs

All results are written to:

```
results/
```

Key outputs:

* `qc/` – FastQC & alignment QC
* `alignment/` – BAM files (STAR only)
* `counts/gene_counts.txt` – STAR branch
* `salmon/quant.sf` – Salmon branch
* `deg/DEG_results.csv`
* `deg/MA_plot.png`
* `deg/PCA_plot.png`



## Acknowledgements

Inspired by:

* nf-core/rnaseq
* Nextflow DSL2 best practices
* Community RNA-seq SOPs
