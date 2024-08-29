#!/bin/bash -

# path to fastq files
fastq_path="$(dirname $0)/data"

# output directory path
mkdir ./output/sam
output_path="./output/sam"


# SBW25 index for bowtie2
index="SBW25_index"

fichier1=(${fastq_path}/I23-1089-G04_F_filt.fastq.gz) # get the list of fastq files
fichier2=(${fastq_path}/I23-1089-H04_F_filt.fastq.gz) # get the list of fastq files
fichier=(${fichier1[@]} ${fichier2[@]}) # merge the two arrays
for f in $fichier;
do
    # Extract the names after the second _ in the file name
    base_name=$(basename "$f" | cut -d '_' -f 1,1)
    # Generate the files name for forward and reverse reads
    f_file="${fastq_path}/${base_name}_F_filt.fastq.gz"
    r_file="${fastq_path}/${base_name}_R_filt.fastq.gz"
    # create the output file name
    output="${output_path}/${base_name}.sam"
    # alignement with bowtie 2
    bowtie2 -x ${index} -1 ${f_file} -2 ${r_file} -S ${output} --threads 10
done
echo "Sam files to Bam files..."

for samfile in ./output/sam/*.sam; do
    echo "$samfile"
    samtools view -Sb $samfile > ${samfile%.sam}.bam # convert sam to bam
done
echo "Merging bam files process..."
samtools merge output/merged.bam output/sam/*.bam
rm -rf output/sam # delete the sam directory

echo "Sorting proces..."
samtools sort output/merged.bam -o output/merged.sorted.bam

echo "Indexation process..."
samtools index output/merged.sorted.bam

echo "Coverage file generation..."
samtools depth output/merged.sorted.bam > output/coverage_full.txt

Rscript graph_coverage.R output/coverage_full.txt
echo "Check the coverage graph and the annotated table in the output folder"
