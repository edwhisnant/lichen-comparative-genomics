# PHYling for phylogenetic analysis

[PHYling](https://github.com/stajichlab/PHYling) (Stajich Lab; UC Riverside) is a phylogenetic's pipeline that uses BUSCO HMM's to identify conserved single-copy orthologs among genomes, conducts multiple-sequence alignments on orthologs, constructs gene trees with IQ-Tree, and infers a species tree with ASTRAL.

## Installation

Copy the GitHub repo and create the conda environment

```{}
git clone https://github.com/stajichlab/PHYling.git
cd PHYling/
conda env create -f environment.yml
conda activate phyling
pip install .
```

Set the `phyling_db`

```{}
echo 'export PHYLING_DB=/hpc/group/bio1/ewhisnant/databases/phyling_db:$PHYLING_DB' >> ~/.bashrc
source ~/.bashrc
```

Re-activate the environment

```{}
conda activate phyling
```

Install the BUSCO models you will use. In my case, I am using the `ascomycota_odb12` models.

```{}
phyling download ascomycota_odb12
```

There are three main steps:

1. Identify the orthologs and align them with `hmmalign`

2. Filter the alignments

3. Buld the tree
