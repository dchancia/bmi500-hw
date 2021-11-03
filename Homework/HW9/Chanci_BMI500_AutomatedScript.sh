#!/bin/bash

# Created by: Daniela Chanci Arrubla
# Date: 11/02/2021
# Based on: https://github.com/CBC-UCONN/RNA-seq-with-reference-genome-and-annotation

# Quality Control Sample 1
fastqc adrenal_1.fastq
fastqc adrenal_2.fastq

#  Quality Control Sample 2
fastqc brain_1.fastq
fastqc brain_2.fastq

# Alignment with HISAT2 (instead of tophat)

## Create index
hisat2-build chr19.fa chr19_index

## Alignment Sample 1
hisat2 -x chr19_index -1 adrenal_1.fastq -2 adrenal_2.fastq -S Adrenal.sam

## Alignment Sample 2
hisat2 -x chr19_index -1 brain_1.fastq -2 brain_2.fastq -S Brain.sam

# Convert SAM files into BAM files
samtools view -b -o Adrenal.bam Adrenal.sam
samtools sort -o Adrenal_sorted.bam Adrenal.bam
samtools index Adrenal_sorted.bam Adrenal_sorted.bai
samtools view -b -o Brain.bam Brain.sam
samtools sort -o Brain_sorted.bam Brain.bam
samtools index Brain_sorted.bam Brain_sorted.bai

# Generate counts Sample 1 (use Htseq)
htseq-count -f bam Adrenal_sorted.bam UCSC_hg19_chr19_gene_annotation.gtf > Adrenal.counts

# Generate counts Sample 2 (use Htseq)
htseq-count -f bam Brain_sorted.bam UCSC_hg19_chr19_gene_annotation.gtf > Brain.counts
