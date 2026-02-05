workflow RNASEQ_WORKFLOW {

    Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row ->

            def meta = [
                id        : row.sample,
                sample    : row.sample,
                condition : row.condition
            ]

            // Construct full paths dynamically
            def r1 = file("${params.fastq_dir}/${row.fastq_1}")
            def r2 = file("${params.fastq_dir}/${row.fastq_2}")

            tuple(
                meta,
                r1,
                r2
            )
        }
        .set { ch_reads }

    FASTP(ch_reads)
    FASTQC(FASTP.out)
    STAR_ALIGN(FASTP.out)
    FEATURECOUNTS(STAR_ALIGN.out)
    RSEQC(STAR_ALIGN.out)

    MULTIQC(
        FASTQC.out,
        FASTP.out,
        STAR_ALIGN.out,
        FEATURECOUNTS.out,
        RSEQC.out
    )

    INTERACTIVE_PLOTS(FEATURECOUNTS.out)
}
