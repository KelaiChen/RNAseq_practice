#!/bin/bash


# change working directory
cd /Users/kelaichen/pra_samples/RNAseq

# STEP 1: Run fastqc
fastqc data/demo.fastq -o data/


# STEP 2: Run trimmomatic to trim reads with poor quality
java -jar /Users/kelaichen/tools/trimmomatic-0.39.jar SE -threads 4 data/demo.fastq data/demo_trimmed.fastq TRAILING:10 -phred33
echo "Trimmomatic finished running!"

fastqc data/demo_trimmed.fastq -o data/

# STEP 3: Run HISAT2
# get the genome indices
# run alignment
hisat2 -q --rna-strandness R -x HISAT2/grch38/genome -U data/demo_trimmed.fastq | samtools sort -o HISAT2/demo_trimmed.bam
echo "HISAT2 finished running!"


# STEP 3: run featurecountes  -  quantification
featureCounts -T 2 -a ~/hg38/Homo_sapiens.GRCh38.113.gtf -o quants/demo_featurecounts.txt HISAT2/demo_trimmed.bam
echo "featureCounts finished running!"




