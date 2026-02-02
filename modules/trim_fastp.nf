process FASTP {

    tag "$sample"
    publishDir "results/fastp", mode: 'copy'

    input:
    tuple val(sample), path(read1), path(read2)

    output:
    tuple val(sample),
          path("${sample}_R1.trim.fastq.gz"),
          path("${sample}_R2.trim.fastq.gz")

    script:
    """
    fastp \
      -i $read1 -I $read2 \
      -o ${sample}_R1.trim.fastq.gz \
      -O ${sample}_R2.trim.fastq.gz \
      --html ${sample}_fastp.html \
      --json ${sample}_fastp.json
    """
}
