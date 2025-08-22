#!/bin/bash

# RNA-seq mini-pipeline: QC → alignment → counting

# -------------------- Setup --------------------


# Define project structure relative to current location
PROJECT_DIR="./data_pre_processing"
mkdir -p "${PROJECT_DIR}"/{raw,fastq,aligned,counts,logs,qc,STAR_index}


cd "${PROJECT_DIR}/raw"


# Group SRA run IDs by biological sample 
colon_rep1=(SRX347887)   # SRX347887
colon_rep2=(SRX347888)   # SRX347888
normal_rep1=(SRX347905)    # SRX347905
normal_rep2=(SRX347906)    # SRX347906
metastatic_rep1=(SRX347923)    # SRX347923
metastatic_rep2=(SRX347924)    # SRX347924

# -------------------- Download & Convert --------------------

# Download .sra files
for r in "${colon_rep1[@]}" "${colon_rep1[@]}" "${normal_rep1[@]}" "${normal_rep1[@]}" "${metastatic_rep1[@]}" "${metastatic_rep2[@]}"; do
  prefetch "$r"
done

# Convert to gzipped FASTQ
for r in "${colon_rep1[@]}" "${colon_rep1[@]}" "${normal_rep1[@]}" "${normal_rep1[@]}" "${metastatic_rep1[@]}" "${metastatic_rep2[@]}"; do
  fasterq-dump -e 16 -p -O . "$r"
  gzip -f "${r}.fastq"
done

# Concatenate per-sample FASTQs
cat "${colon_rep1[@]/%/.fastq.gz}"  > colon1.fastq.gz
cat "${colon_rep2[@]/%/.fastq.gz}"  > colon2.fastq.gz
cat "${normal_rep1[@]/%/.fastq.gz}" > normal1.fastq.gz
cat "${normal_rep2[@]/%/.fastq.gz}" > normal2.fastq.gz
cat "${metastatic_rep1[@]/%/.fastq.gz}" > metastatic1.fastq.gz
cat "${metastatic_rep1[@]/%/.fastq.gz}" > metastatic2.fastq.gz


# Move to fastq/ folder
mv colon*.fastq.gz normal*.fastq.gz metastatic*.fastq.gz ../fastq/

# -------------------- QC --------------------

cd ../fastq
fastqc ycolon*.fastq.gz normal*.fastq.gz metastatic*.fastq.gz \
  -o ../qc --threads 16

# -------------------- Alignment (hisat) --------------------

curl -O ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/data/hg38.tar.gz

mkdir hisat2_index
cd hisat2_index
tar -xzf hg38.tar.gz

cd hisat2_index
SAMPLES=(colon1,colon2,normal1,normal2,metastatic1,metastatic2)

# Align each sample
for sample in "${SAMPLES[@]}"
do
  echo "Aligning ${sample}..."
  hisat2 -p 4 \
    -x hisat2_index/hg38/genome \
    -U fastq/${sample}.fastq.gz \
    2> logs/${sample}_hisat2.log | \
    samtools sort -@ 4 -o aligned/${sample}.bam
  samtools index aligned/${sample}.bam
  echo "${sample} alignment done."
done


# -------------------- Quantification (featureCounts) --------------------

cd ..
curl -L -o gencode.v48.annotation.gtf.gz \
  https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_48/gencode.v48.annotation.gtf.gz
gunzip -f gencode.v48.annotation.gtf.gz

featureCounts -T 16 -t exon -g gene_name \
  -a gencode.v48.annotation.gtf \
  -o counts/raw_counts_gene_sym.txt aligned/*.bam \
  &> logs/featureCounts_gene_sym.log

# Format counts matrix
{ printf "GeneSymbol\t"; head -n 2 counts/raw_counts_gene_sym.txt | tail -n 1 | cut -f7-; } > counts/final_counts_symbols.tsv
tail -n +3 counts/raw_counts_gene_sym.txt | \
  awk -v OFS="\t" '{ out=$1; for(i=7;i<=NF;i++) out=out OFS $i; print out }' >> Normalized_counts/final_counts_symbols.tsv

sed -i '' '1 s|aligned/||g; 1 s|\.bam||g' counts/final_counts_symbols.tsv

# Done
echo "Pipeline complete. Output saved in: ${PROJECT_DIR}/counts/final_counts_symbols.tsv"
