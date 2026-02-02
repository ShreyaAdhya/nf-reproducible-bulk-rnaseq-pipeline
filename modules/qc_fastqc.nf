process FASTQC {

    tag "$sample"
    publishDir "results/fastqc", mode: 'copy'

    input:
    tuple val(sample), path(read1), path(read2)

    output:
    path "*.html"
    path "*.zip"

    script:
    """
    fastqc $read1 $read2
    """
}
