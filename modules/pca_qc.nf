process PCA_QC {

    tag "PCA"

    conda "envs/rnaseq.yml"
    publishDir "${params.outdir}/pca", mode: 'copy'

    input:
    path count_matrix

    output:
    path "PCA_*.png"

    script:
    """
    Rscript bin/PCA_plots.R ${count_matrix}
    """
}
