
# Reads alignement on *Pseudomonas fluorescence* SBW25

   In this part you will find a bash script which will runs the read alignment process on SBW25 genome. Please, be sure that bowtie2 and samtools have been instaled in you machine and add to the $PATH variable AND run the script in this directory with the command:

```bash
bash alignement_bowtie.sh
```

   Tha bash script will then execute a R script to create plot for the depht coverage along the genome and a barplot to show the median depht of the NRPS gene of SBW25.