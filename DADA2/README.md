
# Divisive Amplicon Denoising Algorithm 2


You will find two folders in this section. One folder for 16S rRNA data processing and another one for NRPS data processing.

- 16S rRNA: Reads were merged using the DADA2 pipeline functionnality. As output you will have the list of the Amplicon Sequence Variants (ASVs), the count table (how many times each ASV has been found in each samples), and the taxonomic annotation table.

- NRPS: You will only get the results for feature table and ASV list. Please see dom2BGC part for the annotation process. Here, the reads were not merged, but concatenated. The program will generate results for concatenated ASVs and for forward ones (used for the rest).