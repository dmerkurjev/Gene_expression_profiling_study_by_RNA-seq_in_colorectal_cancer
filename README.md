Cancer RNA-seq — Preprocessing & Analysis

This repository contains an end-to-end workflow for RNA-seq analysis of 6 samples (normal colon, primary CRC, and liver metastasis) were generated from 18 CRC patients. 

Preprocessing (Clean.sh)
Downloads SRA runs, builds 4 sample FASTQs, performs QC, alignment, and outputs gene transcription level.

Analysis (Differential_expression.sh)
Performs differential expression analysis using edgeR.

Data

SRA BioProject: PRJNA218851
The objective of this study is to identify a prognostic signature in colorectal cancer (CRC) patients with diverse progression and heterogeneity of CRCs. We generated RNA-seq data of 54 samples (normal colon, primary CRC, and liver metastasis) from 18 CRC patients and, from the RNA-seq data, identified significant genes associated with aggressiveness of CRC. 

Sample 1: GSM1228184 (SRX347887)
tissue: primary colorectal cancer
ajcc stage: Stage IV

Sample 2: GSM1228185 (SRX347888)
tissue: primary colorectal cancer
ajcc stage: Stage IV

Sample 3: GSM1228202 (SRX347905)
tissue: normal-looking surrounding colonic epithelium
ajcc stage: Stage IV

Sample 4: GSM1228203 (SRX347906)
tissue: normal-looking surrounding colonic epithelium
ajcc stage: Stage IV

Sample 5: GSM1228220 (SRX347923)
tissue: metastatic colorectal cancer to the liver
ajcc stage: Stage IV

Sample 6: GSM1228221 (SRX347906)
tissue: metastatic colorectal cancer to the liver
ajcc stage: Stage IV

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
