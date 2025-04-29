#!/usr/bin/bash

#SBATCH --mem-per-cpu=16G  # adjust as needed
#SBATCH -c 12 # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/logs/f2_clagr3_unmask.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/logs/f2_clagr3_unmask.err
#SBATCH --partition=common

GENOME=/hpc/group/bio1/ewhisnant/armaleo-data/Clagr3/assemblies/Clagr3_AssemblyScaffolds.fasta
BASENAME=$(basename "${GENOME}" .fasta) # Extract the base name of the genome file

# Define the variables for the rest of the anlaysis
MASKED_DIR=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3/masked-genomes/
CLEANED_ASSEMBLY=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/cleaned-genomes/${BASENAME}_cleaned.fasta
REPEATMASKED_ASSEMBLY=${MASKED_DIR}/${BASENAME}_sorted.cleaned.unmasked.fasta

OUTPUT=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/unmask

################################################################################################
############                        TEST FUNANNOTATE2                            ############
################################################################################################

# CALLING CONDA ENVIRONMENT
source $(conda info --base)/etc/profile.d/conda.sh
conda activate funannotate2

export FUNANNOTATE2_DB=/hpc/group/bio1/ewhisnant/databases/funannotate2_db

cd /hpc/group/bio1/ewhisnant/armaleo-data/funannotate2

echo "Testing funannotate2 on ${BASENAME} genome"
date

################################################################################################
############                          CLEANING GENOME                               ############
################################################################################################

echo "Cleaning Cladonia grayi genome file"
date

funannotate2 clean \
    -f ${GENOME} \
    -o ${CLEANED_ASSEMBLY}
echo "Genome cleaned"

################################################################################################
############                           TRAINING GENOME                               ############
################################################################################################

echo 'Training on Cladonia grayi genome'
funannotate2 train \
    -f ${CLEANED_ASSEMBLY} \
    --cpus 12  \
    -s "Cladonia grayi" \
    -o ${OUTPUT} \

funannotate2 predict -i ${OUTPUT} --cpus 12

funannotate2 annotate -i ${OUTPUT} --cpus 12

conda deactivate