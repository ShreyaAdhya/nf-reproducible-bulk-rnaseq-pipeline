process MULTIQC {

    publishDir "results/multiqc", mode: 'copy'

    script:
    """
    multiqc results/ -c assets/multiqc_config.yaml
    """
}
