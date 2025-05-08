# Methodology

All publically available genomes representing Lecanoromcyetes fungi were catalogued from NCBI (accessed 02/05/2025) and MycoCosm (JGI; last accessed 04/28/2025). These genomes were catalouged with taxonomic information using NCBI Taxonomy (https://www.ncbi.nlm.nih.gov/taxonomy; accessed 02/2025-03/2025) and IndexFungorum (https://www.indexfungorum.org/names/names.asp; accessed 02/2025-03/2025). Metadata asscoiated with symbiotic-status were collected from supporting literature and the Consortium of Lichen Herbaria (https://lichenportal.org/portal/index.php). 443 genomes were downloaded from NCBI and JGI, and were filtered for BUSCO single-copy completeness of >= 95% using the ascomycota_odb12 gene models (BUSCO v5.8.2). The remaining 119 genomes were filtered by genomic coverage >= 25x, using reported coverage metrics from NCBI and JGI. The remaining 108 genomes were annotated following the Funannotate2 pipeline (Funannotate2 v24.4.30) (Palmer and Stajich, unpublished). Genomes were cleaned with the Funannotate2 clean module and soft-masked using RepeatMasker (v4.1.7). RepeatMasker was run using the --xsmall flag (soft-mask), the NCBI/RMBLAST search engine (v2.14.1+), and the Fungi Dfam RepeatMasker database (Dfam v3.8; 11/14/2023). Gene prediction programs were trained using the soft-masked genomes, using the Funannotate2 training module. Then, genome structure and gene prediction was analyzed with Funannotate2 predict module. Gene models were annotated with Funannotate2 annotate module.

The outputs of the funannotate2 annotate module were re-analyzed using InterProScan (v__), antiSMASH (v__), and SignalP (v__). The outputs of these analyses were incorporated into the existing annotations using Funannotate 1.8.15 annotate module, which also runs Diamond BLASTp, EggNogMapper (v__) MEROPS, and UniProt. The results from antiSMASH are also cross-referenced with the MiBiG database (v 1.4). The results from the this accessory analysis were fed back into funannotate2 annotate module for final reconcilliation of annotations. 

Orthologs were identified with OrthoFinder (v3.0.1b1) using the annotated protein FASTA files from the Funannotate2 pipeline. OrthoFinder was run using DIAMOND (v2.1.11) as the search engine, MAFFT (v7.525) for the multiple sequence alignment (-MSA flag) and FastTree (v2.1.11) (-T flag) was used to create gene trees for orthogroups and to build the final species tree. 1030 orthogroups with minimum of 98.1% of species having single-copy genes in any orthogroup were used to infer the species tree. OrthoFinder assigned 1008014 genes (97.4% of total) to 29483 orthogroups. Fifty percent of genes were in orthogroups with 71 or more genes (G50 was 71) and were contained in the largest 9067 orthogroups (O50 was 9067). There were 913 orthogroups with all species present and 364 of these consisted entirely of single-copy genes.



### 1. AFTER RUNNING FUNANNOTATE2 ANNOTATE

```{}
{
    "genes": 9302,
    "common_name": 579,
    "mRNA": 9255,
    "tRNA": 47,
    "ncRNA": 0,
    "rRNA": 0,
    "repeat_region": 0,
    "misc_feature": 0,
    "avg_gene_length": 1827.51,
    "transcript-level": {
        "CDS_transcripts": 9255,
        "CDS_five_utr": 0,
        "CDS_three_utr": 0,
        "CDS_no_utr": 9255,
        "CDS_five_three_utr": 0,
        "CDS_complete": 9179,
        "CDS_no-start": 33,
        "CDS_no-stop": 43,
        "CDS_no-start_no-stop": 0,
        "total_exons": 27476,
        "total_cds_exons": 27476,
        "average_number_transcripts_per_gene": 1.0,
        "multiple_exon_transcript": 6936,
        "single_exon_transcript": 2319,
        "average_number_cds_exons": 2.97,
        "avg_exon_length": 552.59,
        "median_number_exons": 2,
        "max_number_exons": 24,
        "avg_protein_length": 546.83,
        "avg_transcript_length": 1640.52,
        "functional": {
            "go_terms": 0,
            "interproscan": 0,
            "eggnog": 0,
            "pfam": 6775,
            "cazyme": 253,
            "merops": 261,
            "busco": 2772,
            "secretion": 0
        }
    }
}
```

### 2. AFTER RUNNING ACCESSORY ANNOTATIONS AND FUNANNOTATE1 ANNOTATE

```{}
"annotation": {
        "genes": 9302,
        "common_name": 2476,
        "mRNA": 9255,
        "tRNA": 47,
        "ncRNA": 0,
        "rRNA": 0,
        "avg_gene_length": 1827.51,
        "transcript-level": {
            "CDS_transcripts": 9255,
            "CDS_five_utr": 0,
            "CDS_three_utr": 0,
            "CDS_no_utr": 9255,
            "CDS_five_three_utr": 0,
            "CDS_complete": 9179,
            "CDS_no-start": 33,
            "CDS_no-stop": 43,
            "CDS_no-start_no-stop": 0,
            "total_exons": 27476,
            "total_cds_exons": 27476,
            "multiple_exon_transcript": 6936,
            "single_exon_transcript": 2319,
            "avg_exon_length": 480.11,
            "avg_protein_length": 546.83,
            "functional": {
                "go_terms": 5804,
                "interproscan": 7294,
                "eggnog": 8253,
                "pfam": 6331,
                "cazyme": 229,
                "merops": 261,
                "busco": 1149,
                "secretion": 554
            }
```

### 3. AFTER RUNNING FUNANNOTATE2 AGAIN

```{}
{
    "genes": 9302,
    "common_name": 2476,
    "mRNA": 9255,
    "tRNA": 47,
    "ncRNA": 0,
    "rRNA": 0,
    "repeat_region": 0,
    "misc_feature": 0,
    "avg_gene_length": 1827.51,
    "transcript-level": {
        "CDS_transcripts": 9255,
        "CDS_five_utr": 0,
        "CDS_three_utr": 0,
        "CDS_no_utr": 9255,
        "CDS_five_three_utr": 0,
        "CDS_complete": 9179,
        "CDS_no-start": 33,
        "CDS_no-stop": 43,
        "CDS_no-start_no-stop": 0,
        "total_exons": 27476,
        "total_cds_exons": 27476,
        "average_number_transcripts_per_gene": 1.0,
        "multiple_exon_transcript": 6936,
        "single_exon_transcript": 2319,
        "average_number_cds_exons": 2.97,
        "avg_exon_length": 552.59,
        "median_number_exons": 2,
        "max_number_exons": 24,
        "avg_protein_length": 546.83,
        "avg_transcript_length": 1640.52,
        "functional": {
            "go_terms": 5804,
            "interproscan": 552,
            "eggnog": 4977,
            "pfam": 6775,
            "cazyme": 253,
            "merops": 261,
            "busco": 2890,
            "secretion": 387
        }
    }
}
```
