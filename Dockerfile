FROM continuumio/miniconda3

COPY envs/rnaseq.yml /
RUN conda env create -f /rnaseq.yml

ENV PATH=/opt/conda/envs/rnaseq/bin:$PATH

