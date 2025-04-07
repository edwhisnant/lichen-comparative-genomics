# Genome annotation programs
A repo on working with and testing genome annotation programs

## Genome quality control

### BUSCO

BUSCO searches for Universal Single Copy Orthologs in your genome, compared against a database of your taxonomic choice. Completeness is defined as the number of *single copy matches of BUSCO's in your genome* out of the total number of BUSCO's in the database you chose. Typically 95% is the standard cutoff for "good" genomes.

*I have implemented BUSCO for filtering genomes that have low completenes.*

### NCBI's **F**oreign **C**ontamination **S**creening (NCS)

[FCS or FCS-GX](https://github.com/ncbi/fcs-gx) is NCBI's standard tool for detecting contamination from lab-sources and/or biological sources. Examples include a screen for adaptor sequences and for biological contamination. 

The desription from the FCS page on NCBI:

*"FCS-adaptor searches for short sequences that are used as part of the lab preparation process and sometimes wind up in the final assembly by mistake. FCS-GX searches for sequences from a wide range of organisms including bacteria, fungi, protists, viruses, and others to identify sequences that don’t look like they are from the intended organism. In each case, you receive a report of the coordinates and identities of potential contaminants to be reviewed and removed (see Figure 1 for a sample report of the FCS-GX summary output). Both tools are designed to screen both eukaryote and prokaryote genomes."*

### EukCC

EukCC is a genome quality assessment program. It gives some ideas about contamination of your genomes. The main issue here is that when running the EukCC program, it will automatically merge similar genomes into bins. This is great if you have numerous metagenomes, but less so if they are MAGs of the same species. Then, you get binning of genomes that doesn't make sense.

*EukCC does not seem to be applicable for me here.*

## Annotations programs/pipelines

### Funannotate
I have been wokring on genome annotation pipeline via Funannotate. For my scripts and notes see [here](https://github.com/edwhisnant/funannotate)

### DRAM
