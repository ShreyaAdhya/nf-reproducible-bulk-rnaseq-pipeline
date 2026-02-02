process STAR_ALIGN {

    tag "$sample"
    publishDir "results/star", mode: 'copy'

    input:
    tuple val(sample), path(read1), path(read2)

    output:
    tuple val(sample), path("${sample}.bam")

    script:
    """
    STAR \
      --genomeDir ${params.star_index} \
      --readFilesIn $read1 $read2 \
      --readFilesCommand zcat \
      --outSAMtype BAM SortedByCoordinate \
      --outFileNamePrefix ${sample}.
    """
}
