#!/usr/bin/bash

#SBATCH --mem-per-cpu=64G  # Memory per CPU
#SBATCH -c 10               # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/logs/busco_%A_%a.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/logs/busco_%A_%a.err
#SBATCH --partition=common
#SBATCH --array=1-5 # Array range

GENOMES=/hpc/group/bio1/ewhisnant/comp-genomics/genomes/temp-genomes-rerun
OUTPUT=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/busco

# Activate the conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate busco

cd ${OUTPUT}

# list of genome files
GENOME_FILES=($(ls ${GENOMES}/*.fa))

# genome file for this array task
FILE=${GENOME_FILES[$SLURM_ARRAY_TASK_ID]}
BASE_NAME=$(basename "$FILE" .fa)

# Create output directory for this genome
mkdir -p ${OUTPUT}/${BASE_NAME}

echo "Running BUSCO for $BASE_NAME"
echo `date`

# Run BUSCO
busco -i "${FILE}" \
      -o "${BASE_NAME}" \
      -l ascomycota_odb12 \
      -m genome \
      -f \
      -c 10

# Copy the summary file to the BUSCO summary directory
mkdir -p ${OUTPUT}/BUSCO_summary
cp ${OUTPUT}/${BASE_NAME}/short_summary.*.txt ${OUTPUT}/BUSCO_summary/

echo "BUSCO analysis for $BASE_NAME completed"
echo `date`


# REMEMBER TO REMOVE
rm -r ${GENOMES}
conda deactivate