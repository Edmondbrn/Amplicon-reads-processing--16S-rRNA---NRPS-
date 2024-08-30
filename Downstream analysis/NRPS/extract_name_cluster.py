import os 
import pandas as pd
os.chdir(os.path.dirname(__file__))
if not os.path.isdir("./cluster"):
    os.makedirs("./cluster")

heatmap_output = str(input(f"Enter the path to the heatmap output file (we start from {os.getcwd()}): "))
output_file = str(input("Enter the name of the output file: "))
try:
    fh = open("ressources/amplicon_cluster.txt", "r") # get all the clusters and their sequences
    df = pd.read_csv(heatmap_output, sep="\t")
except FileNotFoundError:
    raise FileNotFoundError(f"File {heatmap_output} not found. The current directory contains : {os.listdir()}")
    
cluster = df["Display"].unique().tolist() # get unique cluster name
cluster = [x.split()[2].strip() for x in cluster] # get the cluster names without the number
dict_cluster = {}
for line in fh: # read the fasta file
    line = line.strip()
    if line.startswith(">"): # link the cluster name and its sequences
        header = line[1:]
        dict_cluster[header] = ""
    else:
        dict_cluster[header] += line + "\n"
fh.close()
fh2 = open(output_file, "w")
for amplicon in cluster: # write the sequences of the cluster
    fh2.write(f">{amplicon}\n{dict_cluster[amplicon]}")
fh2.close()