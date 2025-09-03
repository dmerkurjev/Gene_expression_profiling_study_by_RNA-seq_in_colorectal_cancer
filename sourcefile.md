# To download the data:

# Create environment
conda create -n Gene_expression_profiling_study_by_RNA-seq_in_colorectal_cancer -c bioconda -c conda-forge \
  sra-tools fastqc multiqc hisat2 samtools trimmomatic subread -y
conda activate Gene_expression_profiling_study_by_RNA-seq_in_colorectal_cancer

# Folder setup
mkdir -p ~/0_Gene_expression_profiling_study_by_RNA-seq_in_colorectal_cancer/{data,fastq,trimmed,aligned,counts,logs,qc}
cd ~/0_Gene_expression_profiling_study_by_RNA-seq_in_colorectal_cancer/data

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975551/SRR975551.sralite.1 # colon cancer rep1 SRX347887

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR011/11255/SRR11255825/SRR11255825.lite.1 # colon cancer rep2 SRX347888

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975569/SRR975569.sralite.1 # normal rep1 SRX347903

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975570/SRR975570.sralite.1 # normal rep2 SRX347904

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975587/SRR975587.sralite.1 metastatic cancer rep1 SRX347923 

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975588/SRR975588.sralite.1 metastatic cancer rep1 SRX347924

for r in "${SRR[@]}"; do
  fasterq-dump -e 16 -p -O . "$r"
  gzip -f "${r}.fastq"
done
