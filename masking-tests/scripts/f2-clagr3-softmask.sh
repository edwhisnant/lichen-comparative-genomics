#!/usr/bin/bash

#SBATCH --mem-per-cpu=16G  # adjust as needed
#SBATCH -c 12 # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/logs/f2_clagr3_softmask.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/logs/f2_clagr3_softmask.err
#SBATCH --partition=common

GENOME=/hpc/group/bio1/ewhisnant/armaleo-data/Clagr3/assemblies/Clagr3_AssemblyScaffolds.fasta
BASENAME=$(basename "${GENOME}" .fasta) # Extract the base name of the genome file

# Define the variables for the rest of the anlaysis
MASKED_DIR=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/masked-genomes/softmask
CLEANED_ASSEMBLY=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/cleaned-genomes/${BASENAME}_cleaned.fasta
REPEATMASKED_ASSEMBLY=${MASKED_DIR}/${BASENAME}_sorted.cleaned.softmasked.fasta

OUTPUT=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/softmask

################################################################################################
############                        TEST FUNANNOTATE2                               ############
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

# echo "Cleaning Cladonia grayi genome file"
# date

# funannotate2 clean \
#     -f ${GENOME} \
#     -o ${CLEANED_ASSEMBLY}
# echo "Genome cleaned"

conda deactivate

################################################################################################
############                           MASKING GENOME                               ############
################################################################################################
source $(conda info --base)/etc/profile.d/conda.sh
conda activate RepeatSuite
echo "Starting RepeatMasker pipeline"

mkdir -p ${MASKED_DIR}

RepeatMasker \
    --species "Fungi" \
    ${CLEANED_ASSEMBLY} \
    --dir ${MASKED_DIR} \
    -pa 11 \
    --xsmall

# "--xsmall" to soft-mask, rather than hardmask
# "--nolow" to ignore low complexity regions (better for the prediction of exons/introns)
# "--pa 11" to use 11 threads
# "--species Fungi" to use the Fungi library

# CHECK IF THE MASKED FILE EXISTS, THEN RENAME IT 
if [ -f ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ]; then
    mv ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ${REPEATMASKED_ASSEMBLY}
    echo "Genome soft-masked"
else
    echo "Error: Masked file not found for ${BASENAME}!"
    exit 1
fi

conda deactivate

################################################################################################
############                        FUNANNOTATE GENOME                              ############
################################################################################################

conda activate funannotate2
export FUNANNOTATE2_DB=/hpc/group/bio1/ewhisnant/databases/funannotate2_db

# Using a pre-masked genome from RepeatMasker
echo 'Training on Cladonia grayi genome'
funannotate2 train \
    -f ${REPEATMASKED_ASSEMBLY} \
    --cpus 12  \
    -s "Cladonia grayi" \
    -o ${OUTPUT} \

funannotate2 predict -i ${OUTPUT} --cpus 12

funannotate2 annotate -i ${OUTPUT} --cpus 12

conda deactivate