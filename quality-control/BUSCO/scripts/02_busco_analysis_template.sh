#!/usr/bin/bash

#SBATCH --mem-per-cpu=16G  # Memory per CPU
#SBATCH -c 8               # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/logs/busco_analysis.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/logs/busco_analysis.err
#SBATCH --partition=common


GENOMES=/hpc/group/bio1/ewhisnant/comp-genomics/genomes
OUTPUT=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/busco
GENERATE_PLOT=/hpc/group/bio1/ewhisnant/miniconda3/envs/busco/bin/generate_plot.py


# Activate the conda environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate busco

################################################################################################
############                 STEP 2: ANALYZING THE OUTPUT OF BUSCO                  ############
################################################################################################

OUTPUT=/hpc/group/bio1/ewhisnant/comp-genomics/quality-control/busco

## Change the directory to the BUSCO summary directory
cd ${OUTPUT}/BUSCO_summary
BUSCO_SUMMARY_DIR=${OUTPUT}/BUSCO_summary

## Output file for the combined summary
COMBINED_SUMMARY_FILE="${BUSCO_SUMMARY_DIR}/combined_summary.tsv"

################################################################################################
############                    EXTRACT THE ASSEMBLY STATISTICS                     ############
################################################################################################

# Write the header to the combined summary file
echo -e "Organism\tNumber of scaffolds\tNumber of contigs\tTotal length\tPercent gaps\tScaffold N50\tContigs N50\tComplete_BUSCOs\tSingle_Copy_BUSCOs\tDuplicated_BUSCOs\tFragmented_BUSCOs\tMissing_BUSCOs\tTotal_BUSCOs" > "$COMBINED_SUMMARY_FILE"

# Loop through each summary file in the directory
for file in ${BUSCO_SUMMARY_DIR}/short_summary.specific.ascomycota_odb12.*.txt; do
    
    # Extract the organism name from the filename
    #organism=$(basename "$file" | sed -E 's/short_summary\.specific\.ascomycota_odb12\.([^.]+)\.txt$/\1/')
    organism=$(basename "$file" | cut -d '.' -f4- | sed 's/\.txt$//')

    # Extract the Assembly Statistics section
    stats=$(awk '/Assembly Statistics:/ {flag=1; next} flag && NF {print} /^$/ {flag=0}' "$file")

    # Parse the statistics into variables
    num_scaffolds=$(echo "$stats" | awk '/Number of scaffolds/ {print $1}')
    num_contigs=$(echo "$stats" | awk '/Number of contigs/ {print $1}')
    total_length=$(echo "$stats" | awk '/Total length/ {print $1}')
    percent_gaps=$(echo "$stats" | awk '/Percent gaps/ {print $1}')
    scaffold_n50=$(echo "$stats" | awk '/Scaffold N50/ {print $1}')
    contigs_n50=$(echo "$stats" | awk '/Contigs N50/ {print $1}')

    echo "Organism: $organism"
    echo "Assembly Statistics: $stats"
    echo "Number of scaffolds: $num_scaffolds"
    echo "Number of contigs: $num_contigs"
    echo "Total length: $total_length"
    echo "Percent gaps: $percent_gaps"
    echo "Scaffold N50: $scaffold_n50"
    echo "Contigs N50: $contigs_n50"

    # Extract the BUSCO completeness data
    complete=$(awk '/Complete BUSCOs \(C\)/ {print $1}' "$file")
    single_copy=$(awk '/Complete and single-copy BUSCOs \(S\)/ {print $1}' "$file")
    duplicated=$(awk '/Complete and duplicated BUSCOs \(D\)/ {print $1}' "$file")
    fragmented=$(awk '/Fragmented BUSCOs \(F\)/ {print $1}' "$file")
    missing=$(awk '/Missing BUSCOs \(M\)/ {print $1}' "$file")
    total=$(awk '/Total BUSCO groups searched/ {print $1}' "$file")

    # Append the extracted information to the combined summary file
    echo -e "${organism}\t${num_scaffolds}\t${num_contigs}\t${total_length}\t${percent_gaps}\t${scaffold_n50}\t${contigs_n50}\t${complete}\t${single_copy}\t${duplicated}\t${fragmented}\t${missing}\t${total}" >> "$COMBINED_SUMMARY_FILE"
done

echo "Combined summary has been saved to ${COMBINED_SUMMARY_FILE}"

# Clean the output of the BUSCO analysis
    # Ensure we are in the BUSCO summary directory
cd ${OUTPUT}/BUSCO_summary

# Python script to rename the headers and calculate the percentage completeness of the BUSCOs
BUSCO_SUMMARY_PY=/hpc/group/bio1/ewhisnant/comp-genomics/scripts/busco/busco_summary_cleaner.py
python3 ${BUSCO_SUMMARY_PY}

################################################################################################
############               STEP 3: RUN BUSCO COMPLETENESS ANALYSIS                  ############
################################################################################################
## This will produce a summary plotof the BUSCO results for each genome
## This script will generate a R script that will produce a summary plot of the BUSCO results for each genome

python3 ${GENERATE_PLOT} \
    -wd ${OUTPUT}/BUSCO_summary \
    -rt specific

conda deactivate