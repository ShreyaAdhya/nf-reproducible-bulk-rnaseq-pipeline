/usr/bin/env nextflow
nextflow.enable.dsl=2

include { RNASEQ_WORKFLOW } from './workflows/rnaseq_workflow.nf'

workflow {
    RNASEQ_WORKFLOW()
}

