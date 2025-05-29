# Methodology

# May 4th, 2025
## Comparative genomics of the Lecanoromycetes

All publically available genomes representing Lecanoromcyetes fungi were catalogued from NCBI (accessed 02/05/2025) and MycoCosm (JGI; last accessed 04/28/2025). These genomes were catalouged with taxonomic information using NCBI Taxonomy (https://www.ncbi.nlm.nih.gov/taxonomy; accessed 02/2025-03/2025) and IndexFungorum (https://www.indexfungorum.org/names/names.asp; accessed 02/2025-03/2025). Metadata asscoiated with symbiotic-status were collected from supporting literature and the Consortium of Lichen Herbaria (https://lichenportal.org/portal/index.php). 443 genomes were downloaded from NCBI and JGI, and were filtered for BUSCO single-copy completeness of >= 95% using the ascomycota_odb12 gene models (BUSCO v5.8.2). The remaining 119 genomes were filtered by genomic coverage >= 25x, using reported coverage metrics from NCBI, JGI, or supporting literature (*Graphis scripta* and *Dibaeis baeomyces* from McDonald et al, 2013). The remaining 108 genomes were annotated following the Funannotate2 pipeline (Funannotate2 v24.4.30 & v25.5.27) (Palmer and Stajich, unpublished). Genomes were cleaned with the Funannotate2 clean module and soft-masked using RepeatMasker (v4.1.7). RepeatMasker was run using the --xsmall flag (soft-mask), the NCBI/RMBLAST search engine (v2.14.1+), and the Fungi Dfam RepeatMasker database (Dfam v3.8; 11/14/2023). Gene prediction programs were trained *ab initio* using the soft-masked genomes, using the Funannotate2 training module. Then, genome structure and gene prediction was analyzed with Funannotate2 predict module. Gene models were annotated with Funannotate2 annotate module.

Orthologs were identified with OrthoFinder (v3.0.1b1) using the annotated protein FASTA files from the Funannotate2 pipeline. OrthoFinder was run using DIAMOND (v2.1.11) as the search engine, MAFFT (v7.525) for the multiple sequence alignment (-MSA flag) and IQTree (v2.4.0) (-T flag) was used to create gene trees for orthogroups. 1030 orthogroups with minimum of 98.1% of species having single-copy genes in any orthogroup were used to infer the species tree.

To identify orthogroups associated with de-lichenization ("losses"), we grouped the genomes into two groups using their known symbiotic state (lichenized: n = 102; de-lichenized: n = 4) and conducted Wilcoxin's rank sum two-sided test (Mann-Whitney U) (Python v 3.12.7), and corrected for False Discovery Rate (FDR) using the Benjamini-Hochberg FDR correction for 21,307 tests (21,307 orthogroups). This yielded 665 significantly different orthogroups. Effect size was calculated using Cliff's Delta to identify orthogroups that have over/under representation of copy number in the de-lichenized group.

To address the large discrepency in sample size we also conducted the Wilcoxin ranksum two-sided test using a two step filtering. First, the 21,307 orthogroups were tested using the methods described previously. However, this time we used a more lenient alpha (alpha = 0.10) to gather orthogroups of interest wihtout FDR correction (preliminarily significantly different). This identified 1908 orthogroups for interest. Next, using these orthogroups, another Wilcoxin rank sum two-sided test was conducted using a permutation test (number of resamples = 10,000; random state seed = 42) and corrected for False Discovery Rate (FDR) using the Benjamini-Hochberg FDR correction for 1908 tests. Cliff's Delta was calculated for to examine effect size.

Using the 665 orthogroups that were differntially abundant in the de-lichenized taxa, we extracted the amino acid orthogroup fasta files from OrthoFinder, and analyzed these using eggNOGMapper (v2.1.12), with DIAMOND (v2.1.11), MMSeqs2 (v17.b804f), Pfam (v___), and used the eggNOG Ascomycota database (taxid: 4890; v5.0.2).

# May 28th, 2025

## Genome acquisition, quality filtering, and genome annotation

A second analysis was conducted, this time using the overall BUSCO completeness metric (>= 95%) rather than single-copy BUSCO, which included 14 more genomes. This was done to slightly improve the representation of specific lineages, particularly the Peltigerales and Pertusariales - which were deemed of interest after the analysis from May 4th. After filtering for 25x coverage, 121 genomes were retained. The genome from *Usnea florida* (McDonald et al., 2013; deposited in JGI) has an issue which prevents it from being properly analyzed. Therefore, the final list of genomes is 120 genomes total. Like before, genomic cleaning, sorting, gene prediction, genome structure, and annotation was completed with the Funannotate2 pipeline (Funannotate2 v24.4.30 & v25.5.27) (Palmer and Stajich, unpublished).

## Analysis with OrthoFinder

Orthologs were identified with OrthoFinder (v3.0.1b1) using the annotated protein FASTA files from the Funannotate2 pipeline. OrthoFinder was run using DIAMOND (v2.1.11) as the search engine, MAFFT (v7.525) for the multiple sequence alignment (-MSA flag) and fasttree (v2.4.0) (-T flag) was used to create gene trees for orthogroups. 1030 orthogroups with minimum of 98.1% of species having single-copy genes in any orthogroup were used to infer the species tree.

## Phylogenetic analysis with PHYall

PHYall (v____ was used to define the species tree for this analysis. Using the 119 genomes, BUSCO ascomycota_odb12 gene models were used to identify single-copy orthologs shared among the genomes. Shared orthologs were aligned using hmmalign (v___) and scored using PhyKIT to compute the treeness/RCV scores (toverr). The top 300 markers were filtered and gene tree's were constructed using IQ-Tree (v___). The species tree was constructed using ASTER, using both consensus and concatenate methods.



## Analysis with DRAM

119 soft-masked genomes were annotated and analyzed by DRAM (v1.5.0), using DRAM databases (accessed and downloaded 05/28/2025). Our installation of DRAM uses KOfam (Kofamkoala; Aramaki et al., 2020), Pfam (Mistry et al., 2021), dbCAN (v11; Yin et al., 2012), MEROPS (Rawlings et al., 2018), and VOG annotations (version latest as of 05/28/2025; Thannesberger et al., 2017).

* **OPTIONAL:** *The outputs of the funannotate2 annotate module were re-analyzed using InterProScan (v__), antiSMASH (v__), and SignalP (v__). The outputs of these analyses were incorporated into the existing annotations using Funannotate 1.8.15 annotate module, which also runs Diamond BLASTp, EggNogMapper (v__) MEROPS, and UniProt. The results from antiSMASH are also cross-referenced with the MiBiG database (v 1.4). The results from the this secondary annootation were fed back into the funannotate2 annotate module for final reconcilliation of annotations.*


## Comparative genomics incorporating the Eurotiomycetes

