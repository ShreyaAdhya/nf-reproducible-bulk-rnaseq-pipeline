workflow RNASEQ_WORKFLOW {

    Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row ->

            def sample = row.sample
            def r1 = file("${params.fastq_dir}/${row.fastq_1}")
            def r2 = file("${params.fastq_dir}/${row.fastq_2}")

            // Fail early if FASTQs are missing
            if( !r1.exists() || !r2.exists() ) {
                error "Missing FASTQ for sample ${sample}: ${r1}, ${r2}"
            }

            tuple(sample, r1, r2)
        }
        .set { ch_reads }

    /*
     * Pre-processing & QC
     */
    FASTP(ch_reads)
    FASTQC(FASTP.out)

    /*
     * Alignment
     */
    STAR_ALIGN(FASTP.out)

    /*
     * Collect BAMs for joint quantification
     */
    STAR_ALIGN.out
        .map { sample, bam -> bam }
        .collect()
        .set { ch_bams }

    /*
     * Gene-level quantification (single merged matrix)
     */
    FEATURECOUNTS(ch_bams)

    /*
     * Alignment QC
     */
    RSEQC(STAR_ALIGN.out)

    /*
     * PCA QC on gene counts
     */
    PCA_QC(FEATURECOUNTS.out)

    /*
     * Aggregate reports
     */
    MULTIQC(
        FASTQC.out,
        FASTP.out,
        STAR_ALIGN.out,
        FEATURECOUNTS.out,
        RSEQC.out
    )
}
