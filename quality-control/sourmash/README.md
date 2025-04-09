# Sourmash

Sourmash is a command line tool for searching, comparing, and analyzing genomic and metagenomic data.

### How to set up `sourmash`

[sourmash guide](https://sourmash.readthedocs.io/en/latest/tutorial-install.html)

sourmash can be installed via conda or mamba

```{}
#  create a new conda env and install sourmash-minimal
conda create -y -n smash sourmash-minimal

```

Activate the conda environment:

```{}
conda activate smash
```

Test the installation:

```{}
# RUN:
sourmash info
```

Output:

```{}
== This is sourmash version 4.8.14. ==
== Please cite Irber et. al (2024), doi:10.21105/joss.06830. ==

sourmash version 4.8.14
- loaded from path: /hpc/group/bio1/ewhisnant/miniconda3/envs/smash/lib/python3.13/site-packages/sourmash/cli
```
