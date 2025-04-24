#!/usr/bin/bash

#SBATCH --mem-per-cpu=32G  # adjust as needed
#SBATCH -c 20 # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/comp-genomics/compare/logs/orthofinder/lecanoromycetes-dna.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/comp-genomics/compare/logs/orthofinder/lecanoromycetes-dna.err
#SBATCH --partition=scavenger

################################################################################################
############                      HOW TO RUN ORTHOFINDER                            ############
################################################################################################

# OrthoFinder version 3.0.1b1 Copyright (C) 2014 David Emms

# SIMPLE USAGE:
# Run full OrthoFinder analysis on FASTA format proteomes in <dir>
#   orthofinder [options] -f <dir>

# To assign species from <dir1> to existing OrthoFinder orthogroups in <dir2>
#   orthofinder [options] --assign <dir1> --core <dir2>

# OPTIONS:
#  -t <int>        Number of parallel sequence search threads [Default = 8]
#  -a <int>        Number of parallel analysis threads
#  -d              Input is DNA sequences
#  -M <txt>        Method for gene tree inference. Options 'dendroblast' & 'msa'
#                  [Default = msa]
#  -S <txt>        Sequence search program [Default = diamond]
#                  Options: blast, diamond, diamond_ultra_sens, blast_gz, mmseqs, blast_nucl
#  -A <txt>        MSA program, requires '-M msa' [Default = mafft]
#                  Options: mafft, muscle, mafft_memsave
#  -T <txt>        Tree inference method, requires '-M msa' [Default = fasttree]
#                  Options: fasttree, fasttree_fastest, raxml, raxml-ng, iqtree
#  -s <file>       User-specified rooted species tree
#  -I <int>        MCL inflation parameter [Default = 1.2]
#  --save-space    Only create one compressed orthologs file per species
#  -x <file>       Info for outputting results in OrthoXML format
#  -p <dir>        Write the temporary pickle files to <dir>
#  -1              Only perform one-way sequence search
#  -X              Don't add species names to sequence IDs
#  -y              Split paralogous clades below root of a HOG into separate HOGs
#  -z              Don't trim MSAs (columns>=90% gap, min. alignment length 500)
#  -n <txt>        Name to append to the results directory
#  -o <txt>        Non-default results directory
#  -h              Print this help text

# WORKFLOW STOPPING OPTIONS:
#  -op             Stop after preparing input files for BLAST
#  -og             Stop after inferring orthogroups
#  -os             Stop after writing sequence files for orthogroups
#                  (requires '-M msa')
#  -oa             Stop after inferring alignments for orthogroups
#                  (requires '-M msa')
#  -ot             Stop after inferring gene trees for orthogroups 

# WORKFLOW RESTART COMMANDS:
#  -b  <dir>         Start OrthoFinder from pre-computed BLAST results in <dir>
#  -fg <dir>         Start OrthoFinder from pre-computed orthogroups in <dir>
#  -ft <dir>         Start OrthoFinder from pre-computed gene trees in <dir>

################################################################################################
############                   ORTHOFINDER FOR DNA SEQUENCES                        ############
################################################################################################
# Orthofinder is a tool for identifying orthologous genes across multiple species
# Orthofinder requires a directory of protein sequences in fasta format
    # The -d arugment will specify that the input is DNA sequences
    # However, the genome structure must be predicted prior to running orthofinder
    # Therefore, it is necessary that the sort -> clean -> predict steps are run prior

# Define variables
IN_DIR=/hpc/group/bio1/ewhisnant/comp-genomics/funannotate2-out/lecanoromycetes
OUTPUT=/hpc/group/bio1/ewhisnant/comp-genomics/compare/orthofinder/lecanoromycetes/dna


# Create a temporary directory for input files
TEMP_DIR=$(mktemp -d /hpc/group/bio1/ewhisnant/comp-genomics/compare/orthofinder/temp-dir.XXXXXX)

# Check if the temporary directory was created successfully
if [ ! -d "${TEMP_DIR}" ]; then
    echo "Error: Failed to create temporary directory."
    exit 1
fi

echo "Temporary directory created: ${TEMP_DIR}"

# Find and copy all matching files to the temporary directory

cd ${IN_DIR}

echo "Copying files to temporary directory..."
find . -name "*transcripts.fa" -exec cp {} ${TEMP_DIR} \;

# # Check if files were copied successfully
# TEMP_COUNT=$(ls -l ${TEMP_DIR} | wc -l)
# IN_COUNT=$(find . -name "*transcripts.fa" | wc -l)

# if [ "${TEMP_COUNT}" -eq "${IN_COUNT}" ]; then
#     echo "Number of files copied: ${TEMP_COUNT}"
#     echo "All files copied successfully."
# else
#     echo "Some files were not copied. Please check the source and destination directories."
#     exit 1
# fi


echo "Running OrthoFinder..."
date

# CALLING CONDA ENVIRONMENT
source $(conda info --base)/etc/profile.d/conda.sh
conda activate orthofinder

# Run OrthoFinder on the temporary directory
orthofinder \
    -f ${TEMP_DIR} \
    -d \
    -T iqtree \
    -t 20 \
    -a 20 \
    -M msa \
    -A mafft \
    -S diamond \
    -o ${OUTPUT}

# Clean up the temporary directory
rm -r ${TEMP_DIR}

conda deactivate