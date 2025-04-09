# Overview of my methodology

1. Creating the genome catalog and database

For my first analysis, I am looking scrictly at the Lecanormycetes. I created a spreadsheet and cataloged with all of the publicly available genomes from NCBI and JGI that were attributed to the Lecanoromycetes. I gathered all pertinent taxonomic information using NCBI tax, links to download the genomes and other information I felt would be useful. In all, this resulted in 442 genomes being cataloged. Then, I used the links to download the genomes. This script can be found [here](https://github.com/edwhisnant/genome_annotation_programs/blob/main/downloading-genomes/download_genomes.sh). This script reads-in the csv or tsv file spreadsheet and downloads, unzips, and renames each genome file. This worked for most of the genomes, except for the ones from JGI. These needed to downloaded manually from their website.

2. Genome quality checks

Each genome was run through BUSCO, using the `ascomycota_odb12` database. Genomes with <= 95% **single copy ortholog completenes** were filtered out. The standard BUSCO analysis was run, followed by a custom script to extract BUSCO data and analyze the output of the BUSCO analysis for each genome. After this filtering, 118 genomes remained. For these scripts click [here](https://github.com/edwhisnant/genome_annotation_programs/tree/main/quality-control/BUSCO/scripts).

Next, I manually gathered genome coverage information from the NCBI and JGI entry for each genome. Genomic coverage is another metric for sequencing depth, or how many times the whole genome was sequenced entirely. Generally, the higher the coverage, the more confident you can be of the "completeness" of the genome. Higher coverage can also improve the length of scaffold and contigs (the longer these are the less fragmented the genome). In this step, I retained genomes of >= 25x coverage. After this step, 107 genomes remained.

Next, I need to identify any contamination that may exist in the genome sequence. Since the majority of these have gone through NCBI's filter, they are most likely clean of adaptors or other reminants of the sequencing itself. However, since the majority of the remaining genomes are metagenoome assembled genomes (MAGs), I am opting to run them through a contamination filtering step.

3. Genome annotation pipeline

4. Comparitive genomics


# Quality Control of Genomes and Annotations

# Sourmash

Sourmash is a command line tool for searching, comparing, and analyzing genomic and metagenomic data.

### How to set up `sourmash`

[sourmash guide](https://sourmash.readthedocs.io/en/latest/tutorial-install.html)

sourmash can be installed via conda or mamba

```{}
#  create a new conda env and install sourmash-minimal
conda create -y -n smash sourmash-minimal

```

# EUKCC

EukCC is a completeness and contamination estimator for metagenomic assembled microbial eukaryotic genomes.

* There is a note that published genomes should not be analyzed by eukcc... I will try this program anyway

### How to set-up EUKCC

Create a conda env for eukcc, install dependencies and the program itself

```{}
# Create the conda env
conda create -n eukcc

# Activate the conda env
conda activate eukcc

# Install EukCC with bioconda
conda install bioconda::eukcc

# Install dependencies
conda install -c bioconda -c conda-forge metaeuk=4.a0f584d pplacer epa-ng=0.3.8 hmmer=3.3 minimap2 bwa samtools -y

# Check the installation by running the help page
eukcc -h
```

**Here is the man page for EukCC**

```{}
usage: eukcc [-h] [--quiet] [--debug] [-v] {single,folder,define_set,ncbi_update} ...

Framework to evaluate completeness and contamination of a eukaryotic MAG or isolate genome. Only valid for
microbial eukaryotes.

options:
  -h, --help            show this help message and exit
  --quiet, -q           Silcence most output
  --debug, -d           Debug and thus ignore safety
  -v, --version         show program's version number and exit

Subcommands:
  {single,folder,define_set,ncbi_update}

```

### Install the EukCC databases

* Note: I created the directory for the databases in my `/software` directory

Run exactly as it says in order:

```{}
# create a folder were to keep the database
mkdir eukccdb
cd eukccdb
wget http://ftp.ebi.ac.uk/pub/databases/metagenomics/eukcc/eukcc2_db_ver_1.2.tar.gz
tar -xzvf eukcc2_db_ver_1.2.tar.gz
export EUKCC2_DB=$(realpath eukcc2_db_ver_1.2)

```

## BUSCO

[Here](https://busco.ezlab.org/busco_userguide.html#installation-with-conda) is the BUSCO user guide

This installation is memory and computing intensive. It is reccomended that you change to a different node:

```{}
srun -c 4 --mem=8G -p scavenger --pty bash -i

# OR

srun -c 4 --mem=8G -p common --pty bash -i
```


Install BUSCO via conda and create a cond env for BUSCO:

```{}
conda create -n busco -c conda-forge -c bioconda busco=5.8.2

```
