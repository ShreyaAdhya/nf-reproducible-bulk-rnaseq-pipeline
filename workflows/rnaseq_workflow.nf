workflow RNASEQ_WORKFLOW {

    Channel
        .fromPath(params.samplesheet)
        .splitCsv(header:true)
        .map { row ->
            tuple(row.sample, file(row.fastq_1), file(row.fastq_2))
        }
        .set { samples_ch }

    FASTQC(samples_ch)
    FASTP(samples_ch)
    STAR_ALIGN(FASTP.out)
    FEATURECOUNTS(STAR_ALIGN.out)
    RSEQC(STAR_ALIGN.out)
    MULTIQC()
    INTERACTIVE_PLOTS(FEATURECOUNTS.out)
}
