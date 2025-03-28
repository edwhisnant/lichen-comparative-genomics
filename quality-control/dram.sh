#!/usr/bin/bash

#SBATCH --mem-per-cpu=16G  # adjust as needed
#SBATCH -c 12 # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/comp-genomics/dram/distill.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/comp-genomics/dram/distill.err
#SBATCH --partition=common

# GENOMES=/hpc/group/bio1/ewhisnant/comp-genomics/genomes

OUTPUT=/hpc/group/bio1/ewhisnant/comp-genomics/dram/test-analysis

source $(conda info --base)/etc/profile.d/conda.sh

conda activate DRAM
echo "Starting DRAM pipeline"
echo `date`

# echo "Annotating genomes"
# DRAM.py annotate \
#     -i '/hpc/group/bio1/ewhisnant/comp-genomics/genomes/*.fa' \
#     -o ${OUTPUT} \
#     --threads 12

DRAM.py distill \
    -i ${OUTPUT}/annotations.tsv \
    -o ${OUTPUT}/genome_summaries \
    --trna_path ${OUTPUT}/trnas.tsv \
    --rrna_path ${OUTPUT}/rrnas.tsv

conda deactivate