#!/usr/bin/bash

#SBATCH --mem-per-cpu=16G  # adjust as needed
#SBATCH -c 12 # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/logs/eukcc.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/logs/eukcc.err
#SBATCH --partition=common

GENOMES=/hpc/group/bio1/ewhisnant/comp-genomics/genomes
OUTPUT=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/eukcc

################################################################################################
############                    EUKCC FOR GENOME QUALITY TEST                       ############
################################################################################################

# CALLING CONDA ENVIRONMENT
source $(conda info --base)/etc/profile.d/conda.sh
conda activate eukcc

eukcc folder ${GENOMES} \
    --out ${OUTPUT} \
    --threads 12 
    #--db /hpc/group/bio1/ewhisnant/software/eukccdb

conda deactivate
