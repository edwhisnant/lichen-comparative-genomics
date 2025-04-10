# BUSCO for genomes analysis

## 01_busco_arrays_template.sh

BUSCO was run using an arrays format via SLURM on a HPCC, or can be run singluarly. The majority of the genomes analyzed were conducted via the arrays format. Some genomes needed to be re-run. I did this by copying the genomes into a seperate folder and running again via the arrays or solo by calling them by file name.

Here is the link to the script: [01_busco_arrays_templaye.sh](https://github.com/edwhisnant/genome_annotation_programs/blob/main/quality-control/BUSCO/scripts/01_busco_arrays_template.sh)

## 02_busco_analysis.sh

This is a script that compiles all of the summary pages from the output of `01_busco_arrays_template.sh` and quickly analyzes the them.

Here is the link to the shell script: [02_busco_analysis_template.sh](https://github.com/edwhisnant/genome_annotation_programs/blob/main/quality-control/BUSCO/scripts/02_busco_analysis_template.sh)

Here is the link to the associated R script: [busco_summary_cleaner.R](https://github.com/edwhisnant/genome_annotation_programs/blob/main/quality-control/BUSCO/scripts/busco_summary_cleaner.R)

## OVERVIEW OF THIS SCRIPT:

* The first script runs BUSCO using a directory of `*.fa` FASTA genomes. The current script uses the Ascomycota database. What it returns is a summary for each genome for several BUSCO metrics. It is currently written to create a single directory `BUSCO_summary` and create a copy of the summary files from the genomes that were analzyed.

* The second script takes the contents of `BUSCO_summary` and compiles the data into a single TSV file `combined_summary.tsv`. BUSCO has it's own analysis program that will create figures and summarize *some* of the outputs. I have written a script to gather ALL of the output from the BUSCO analysis and then run some analysis via R. This will give all of BUSCO summary data plus this information expressed as a percentage (which is how it is normally reported).
