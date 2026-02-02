
nextflow.enable.dsl=2

include { RNASEQ_WORKFLOW } from './workflows/rnaseq_workflow.nf'

workflow {
    RNASEQ(ch_reads)
}



