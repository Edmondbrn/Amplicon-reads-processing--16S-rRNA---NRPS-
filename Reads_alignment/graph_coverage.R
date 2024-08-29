library(ggplot2)
library(dplyr)
# Turn arguments into R variables
args = commandArgs(trailingOnly = TRUE)
# args = list("/home/edmond/NRPS_analysis/alignement_SBW25/full_reads/coverage_full.txt")

data = read.table(args[[1]], header = T)
annot = read.csv('full_reads/NRPS_annotation_SBW25.csv')

colnames(data) = c("Ref", "Position", "Depth")

ggplot(data, aes(x = Position, y = Depth)) +
  geom_line() +
  theme_bw() + 
  labs(title = "Genome depht", x = "Genomic position", y = "Depth (reads number)") 

ggsave("./output/plot_coverage_reads.png", width = 10, height = 5)

diffs = c(1, diff(data$Position)) # get the difference between each position

# Identify where the difference is greater than 1 (new spots)
breaks = which(diffs > 1)

# Extract the start and end index of each interval
intervals = data.frame(
  Start = c(data$Position[1], data$Position[breaks]),
  End = c(data$Position[breaks - 1], tail(data$Position, 1))
)

intervals$MeanDepth = sapply(1:nrow(intervals), function(i) {
  mean(data$Depth[data$Position >= intervals$Start[i] & data$Position <= intervals$End[i]])
})

intervals$MedianDepth = sapply(1:nrow(intervals), function(i) {
  median(data$Depth[data$Position >= intervals$Start[i] & data$Position <= intervals$End[i]])
})

# Créer un dataframe pour les profondeurs de lecture
depths_list = lapply(1:nrow(intervals), function(i) {
  data.frame(
    Interval = i,
    Depth = data$Depth[data$Position >= intervals$Start[i] & data$Position <= intervals$End[i]],
    genomic_location = as.numeric(data$Position[data$Position >= intervals$Start[i] & data$Position <= intervals$End[i]])
  )
})

# plot the repartition of the reads according to the intervals
for (i in seq_along(depths_list)){
  ggplot() +
    geom_line(data = depths_list[[i]], aes(x = genomic_location, y = Depth), color = "blue") +
    labs(title = "Distribution of reads in the genome",
         x = "Interval",
         y = "Depht (reads number)")
  ggsave(paste0("output/plot_coverage_reads_", i, ".png"), width = 10, height = 5)
}

colnames(intervals) = c("Start", "End", "MeanDepth", "MedianDepth")
write.table(intervals, sep = "\t", file = "output/intervals.txt", row.names = F, quote = F, col.names = T)


# Add two columns to indicate the end and the beginning of the interval
annot = annot %>%
  mutate(Start = as.integer(sub(".*:(\\d+)-\\d+", "\\1", `Genomic.location`)),
         End = as.integer(sub(".*:\\d+-(\\d+)", "\\1", `Genomic.location`)))


# Cartesien product entre les deux dataframes
merged = merge(intervals, annot, by = NULL)

# Filter the intervals that are within the genomic location
merged_fi = merged %>%
  filter(Start.x >= Start.y & End.x <= End.y) %>%
  select(Start = Start.x, End = End.x, `Genomic.location`, `length..aa.`, Proteins)

# Merge the intervals with the filtered intervals
intervals = merge(intervals, merged_fi, by = c("Start", "End"), all.x = TRUE)
# save as file the results
write.table(intervals, 'output/intervals_annotated2.tsv', sep = '\t', row.names = FALSE, quote = FALSE)
cat("Operation successful\n")