# To download the data:

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975551/SRR975551.sralite.1 # colon cancer rep1 SRX347887

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos8/sra-pub-zq-818/SRR011/11255/SRR11255825/SRR11255825.lite.1 # colon cancer rep2 SRX347888

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975569/SRR975569.sralite.1 # normal rep1 SRX347903

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975570/SRR975570.sralite.1 # normal rep2 SRX347904

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975587/SRR975587.sralite.1 metastatic cancer rep1 SRX347923 

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos5/sra-pub-zq-11/SRR000/975/SRR975588/SRR975588.sralite.1 metastatic cancer rep1 SRX347924

fastq-dump --split-files *lite.1 # convert to fastq
