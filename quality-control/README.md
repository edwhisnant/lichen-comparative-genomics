# Quality Control of Genomes and Annotations

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
