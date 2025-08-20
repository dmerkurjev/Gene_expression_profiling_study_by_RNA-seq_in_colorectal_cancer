Senescence RNA-seq — Preprocessing & Analysis

This repository contains an end-to-end workflow for RNA-seq analysis of early passage and senescent BJ fibroblasts in the absence or continued presence of doxycycline (20nm).
It includes two main components:

Preprocessing (Clean.sh)
Downloads SRA runs, builds 4 sample FASTQs, performs QC, alignment, and outputs gene transcription level.

Analysis (Differential_expression.sh)
Performs differential expression analysis using edgeR.

Data

SRA BioProject: PRJNA610861 
BJ fibroblasts transduced with doxycycline inducible empty vector control retroviruses were grown in the absence
or continued presence of doxycycline (20nm), and young-quiescent or senescent cells were collected for RNA-seq. 
Senescent and young doxycycline treated samples were compared for changes in genes expression, and senescent and 
young doxycycline untreated samples were compared separately.

Sample 1: GSM1228184 (SRX347887)
cell line: BJ Fibroblast
Stage: Young - Quiescent
treatment: Doxycycline Minus

Sample 2: GSM1228185 (SRX347888)
cell line: BJ Fibroblast
Stage: Young - Quiescent
treatment: Doxycycline Plus

Sample 3: GSM1228202 (SRX347905)
cell line: BJ Fibroblast
Stage: Senescent
treatment: Doxycycline Minus

Sample 4: GSM1228203 (SRX347906)
cell line: BJ Fibroblast
Stage: Senescent
treatment: Doxycycline Plus

Sample 5: GSM1228220 (SRX347923)
cell line: BJ Fibroblast
Stage: Senescent
treatment: Doxycycline Minus

Sample 6: GSM1228221 (SRX347906)
cell line: BJ Fibroblast
Stage: Senescent
treatment: Doxycycline Plus

Reference files:

Transcript annotation: gencode.v48.annotation.gtf
Alignment index: hg38
Related publication:
PMID: 40493192

Directory Output

The preprocessing script creates a structured working directory data_pre_processing/ containing:

raw/      # downloaded and processed SRA FASTQs  
fastq/    # concatenated FASTQs (one per sample)  
aligned/  # hisat-aligned BAMs  
counts/   # gene-level count matrix   
qc/       # FastQC output  
hisat2_index/  # reference index for alignment  
