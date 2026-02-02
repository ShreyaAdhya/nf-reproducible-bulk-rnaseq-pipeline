workflow RNASEQ_WORKFLOW {

    Channel
    .fromPath(params.input)
    .splitCsv(header:true)
    .map { row ->

        def meta = [
            id          : row.sample,
            sample      : row.sample,
            condition   : row.condition
        ]

        tuple(
            meta,
            file(row.fastq_1),
            file(row.fastq_2)
        )
    }
    .set { ch_reads }


    FASTQC(samples_ch)
    FASTP(samples_ch)
    STAR_ALIGN(FASTP.out)
    FEATURECOUNTS(STAR_ALIGN.out)
    RSEQC(STAR_ALIGN.out)
    MULTIQC()
    INTERACTIVE_PLOTS(FEATURECOUNTS.out)
}
