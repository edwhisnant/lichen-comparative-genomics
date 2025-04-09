#!/usr/bin/bash

#SBATCH --mem-per-cpu=16G  # adjust as needed
#SBATCH -c 4 # Number of threads per process
#SBATCH --output=/hpc/group/bio1/ewhisnant/comp-genomics/genomes-database/download-genomes.out
#SBATCH --error=/hpc/group/bio1/ewhisnant/comp-genomics/genomes-database/download-genomes.err
#SBATCH --partition=common

# Dowloading genomes from my spreadsheet
echo `date`
cd /hpc/group/bio1/ewhisnant/comp-genomics/genomes-database

# ASSUMING THE ORDER OF THE DATABASE COLS HAVE NOT CHANGED
# Grabs the column with links to the genome files
echo "Extracting genome links and names from genomes_db.tsv"
tail -n +2 genomes_db.tsv | cut -f 18 > genome_links.txt

# Grabs the column with the genome names
echo "Extracting genome names from genomes_db.tsv"
tail -n +2 genomes_db.tsv | cut -f 20 > basenames.txt

cd /hpc/group/bio1/ewhisnant/comp-genomics/genomes

rm *.fasta.gz
rm *.fa

# Read lines from both files and process them
paste /hpc/group/bio1/ewhisnant/comp-genomics/genomes-database/genome_links.txt /hpc/group/bio1/ewhisnant/comp-genomics/genomes-database/basenames.txt | while IFS=$'\t' read -r link name; do
    
    wget -c "$link"
    # Check if the download was successful
    if [ $? -ne 0 ]; then
    echo "Failed to download ${link}"
    continue
    fi
    
    # Extract the file name from the link and remove the .gz extension
    unzipped_file=$(basename "${link%.gz}")  # Remove .gz extension and get the base file name
    echo "Unzipping ${unzipped_file}.gz"
    gunzip "${unzipped_file}.gz" #file ending in .gz

    if [ ! -f "${unzipped_file}" ]; then
        echo "Unzipped file ${unzipped_file} not found"
        continue
    fi

    #Change the name of the unzipped file to the name in the database
    mv "${unzipped_file}" "${name}.fa"

    # Check if the file was downloaded and unzipped successfully
    if [ $? -eq 0 ]; then
        echo "Downloaded and unzipped $name.fa"
    else
        echo "Failed to download or unzip $name.fa"
    fi
done

# # Remove the the .fasta.gz files left over

rm /hpc/group/bio1/ewhisnant/comp-genomics/genomes/*.fasta.gz 

# # sbatch /hpc/group/bio1/ewhisnant/comp-genomics/scripts/busco.sh

