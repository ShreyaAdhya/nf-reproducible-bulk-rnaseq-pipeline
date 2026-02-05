##!/usr/bin/env nextflow
nextflow.enable.dsl=2

// ---- guardrails ----
if( !params.samplesheet )
    error "Please provide --samplesheet"

if( !params.fastq_dir )
    error "Please provide --fastq_dir"

// ---- include workflow ----
include { RNASEQ_WORKFLOW } from './workflows/rnaseq_workflow.nf'

// ---- run workflow ----
workflow {
    RNASEQ_WORKFLOW()
}
