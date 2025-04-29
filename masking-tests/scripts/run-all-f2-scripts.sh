# Run me in order for best results

CLEANED_ASSEMBLY=/hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/cleaned-genomes/Clagr3_AssemblyScaffolds_cleaned.fasta

## RUN THE UNMASKED GENOME FIRST AND WAIT UNTIL THE CLEANED GENOME IS PROCESSED
## THEN RUN THE FOLLOWING SCRIPTS
    # The following scripts use this cleaned genome as input so run it all next:
echo "Running Hardmask"
sbatch /hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/f2-clagr3-hardmask.sh

echo "Running Hardmask-nolow"
sbatch /hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/f2-clagr3-hardmask-nolow.sh

echo "Running Softmask"
sbatch /hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/f2-clagr3-softmask.sh

echo "Running Softmask-nolow"
sbatch /hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/scripts/f2-clagr3-softmask-nolow.sh

echo "Check the logs to see if the jobs completed successfully"
