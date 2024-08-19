
# Amplicon reads processing
This Github page is destined to store all the programs which were utilised for the analysis of an amplicon reads dataset. This includes 16S rRNA and Non Ribosomal Protein Synthetase. The complete data will not be included in this repository, only a preview will be. The DNA sequencing has been performed with Illumina technology.

This repository will be ordered as follow:

- Divisive Amplicon Denoising Algorithm 2 ([`DADA2`](https://benjjneb.github.io/dada2/tutorial.html)): 
This part contains two Rmarkdown files to sum up the denoising and the filtering of raw reads from the DNA sequencing. (fastq files not included).

- Reads alignement (NRPS primer quality evaluation)
To evaluate the accuracy of NRPS primers used during the sequencing, reads have been aligned on *Pseudomonas fluorescence SBW25* genome. The sequenced regions have been studied to determine if there was unspecific amplification.

- Updated dom2BGC pipeline:
16S rRNA ASVs from DADA2 have been annotated thanks to Silva databse (v138), but there is no nucleic database for NRPS ASVs. I used the [dom2BGC pipeline](https://git.wur.nl/traca001/dom2bgc) by V.Tracana. Yet, it was not designed for heavy dataset, and I propose a modified version which supports heavy data and an updated database. Furthermore, there are two bash files to easily prepare data for the pipeline

- Downstream analysis (`phyloseq`, `ampvis2`, `corncob`):
After the denoising part, we could perform some analysis on the data. The alpha diversity has been computed for each group according to Week and Irrigation variable. For the beta diversity, a PCoA plot has been done based on Bray-Curtis dissimilarity matrix. The ASVs abundance analysis has been performed thanks to the `corncob` package.


## Acknowledgement

I wanted to thank you Frederik Bak(f.bak@plen.ku.dk) who guided me during my analysis to achieve good results.

## Authors

- [@Edmond BERNE](https://github.com/Edmondbrn/)


