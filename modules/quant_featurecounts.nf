process FEATURECOUNTS {

    tag "featurecounts"
    publishDir "results/counts", mode: 'copy'

    input:
    path bams

    output:
    path "gene_counts_matrix.tsv"

    script:
    """
    featureCounts \
      -a ${params.gtf} \
      -o gene_counts_matrix.tsv \
      -T ${task.cpus ?: 4} \
      ${bams.join(' ')}
    """
}
