# Testing masking strategies

There are some questions about which masking protocol is the "better" protocol. 

There are three main types of maskings:

1. Hard-masking: repetitive sequences are replaced with `N` or `X`. Here you are losing information about the sequences, due to nucleotides being replaced with unknowns. This is the most strict masking procedure.

2. Soft-masking: repetitive sequences are replaced with lower-case versions of the letters. Here, information is retained after masking.

3. Unmasked: The genomes represent all of the assembled nuceotides unchanged.

*RepeatMasker* has other options, including options to soft-mask and to skip low-complexity regions.

Here I am testing 5 combinations of masking or unmasking strategies (in order from most conservative to least):

1. Hard-masking (default for RM)

2. Hard-masking (with `-nolow`): skips masking for low-complexity regions

3. Soft-masking: Soft-masks the low-complexity regions in addition to the interspaced repeat regions

4. Soft-maksing (with `nolow`): skips soft-masking for low-complexity regions

5. Unamsked: Genome is remains unmasked.

**Why skip the masking of low-complexity regions:**

```{}
-nolow / -l(ow)
With the option -nolow or -l(ow) only interspersed repeats are
masked. By default simple tandem repeats and low complexity
(polypurine, AT-rich) regions are masked besides the interspersed
repeats. For database searches the default setting is recommended, but
sometimes, e.g. when using the masked sequence to predict the presence
of exons, it may be better to skip the low complexity masking.
```

### Scripts

* `f2-clagr3-hardmask.sh`: Works as expected (default settings)

**Hardmask (default) command:**

```{}
RepeatMasker \
    --species "Fungi" \
    ${CLEANED_ASSEMBLY} \
    --dir ${MASKED_DIR} \
    -pa 11 \

# "--xsmall" to soft-mask, rather than hardmask
# "--nolow" to ignore low complexity regions (better for the prediction of exons/introns)
# "--pa 11" to use 11 threads
# "--species Fungi" to use the Fungi library

# CHECK IF THE MASKED FILE EXISTS, THEN RENAME IT 
if [ -f ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ]; then
    mv ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ${REPEATMASKED_ASSEMBLY}
    echo "Genome soft-masked"
else
    echo "Error: Masked file not found for ${BASENAME}!"
    exit 1
fi
```

**Example of hard-masking**

```{}
>scaffold_00001
CCCCCGCGCTTCGTCCTCCCCCTCCCAACCCCCCAACAAANNNNNNNNNN
NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNCCA
GCCGCACTACCCGCATTATTCACATCCCCACCCCGCCGCGGACAGAAATA
CGTTCCTGGTGGAATGGCAGCTACGGTTCGCGATTGGACTGTGGAGGCTG
GGGAAATGGCGCATAACCGGAACCAGAGGAGGGGAGTTGGAGGGGATGGC
GGGGAGTGGGATAGGAGGTTTAGACTTGGTGAGTGTGTGGATGGAGGGGG
```

**Genome stats**

```{}
{
  "n_contigs": 413,
  "size": 34610783,
  "softmasked": "1.05%",
  "gaps": "1.05%",
  "n50": 243412,
  "n90": 43471,
  "l50": 43,
  "l90": 170,
  "avg_length": 83803
}
```

**Annotation summary stats from funannotate2**

```{}
{
    "genes": 9727,
    "common_name": 602,
    "mRNA": 9680,
    "tRNA": 47,
    "ncRNA": 0,
    "rRNA": 0,
    "repeat_region": 0,
    "misc_feature": 0,
    "avg_gene_length": 1788.99,
    "transcript-level": {
        "CDS_transcripts": 9680,
        "CDS_five_utr": 0,
        "CDS_three_utr": 0,
        "CDS_no_utr": 9680,
        "CDS_five_three_utr": 0,
        "CDS_complete": 9590,
        "CDS_no-start": 28,
        "CDS_no-stop": 62,
        "CDS_no-start_no-stop": 0,
        "total_exons": 29929,
        "total_cds_exons": 29929,
        "average_number_transcripts_per_gene": 1.0,
        "multiple_exon_transcript": 7562,
        "single_exon_transcript": 2118,
        "average_number_cds_exons": 3.09,
        "avg_exon_length": 513.16,
        "median_number_exons": 3.0,
        "max_number_exons": 24,
        "avg_protein_length": 528.9,
        "avg_transcript_length": 1586.6,
        "functional": {
            "go_terms": 0,
            "interproscan": 0,
            "eggnog": 0,
            "pfam": 6949,
            "cazyme": 255,
            "merops": 269,
            "busco": 2769,
            "secretion": 0
        }
    }
}
```

* `f2-clagr3-hardmask-nolow.sh`: `-nolow` or `l` flag results in no masked output file and the script crashes

**Hardmask with `-nolow` option:**

```{}
RepeatMasker \
    --species "Fungi" \
    ${CLEANED_ASSEMBLY} \
    --dir ${MASKED_DIR} \
    -pa 11 \
    -nolow
   
# "--xsmall" to soft-mask, rather than hardmask
# "--nolow" to ignore low complexity regions (better for the prediction of exons/introns)
# "--pa 11" to use 11 threads
# "--species Fungi" to use the Fungi library

# CHECK IF THE MASKED FILE EXISTS, THEN RENAME IT 
if [ -f ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ]; then
    mv ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ${REPEATMASKED_ASSEMBLY}
    echo "Genome soft-masked"
else
    echo "Error: Masked file not found for ${BASENAME}!"
    exit 1
fi
```

**Output of this:**

```{}
There were no repetitive sequences detected in /hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/cleaned-genomes/Clagr3_AssemblyScaffolds_cleaned.fasta
```

* `f2-clagr3-softmask-nolow.sh`:  `-nolow` or `l` flag results in no masked output file and the script crashes

**Soft-masked with `--xsmall ` and `-nolow` options:**

```{}
RepeatMasker \
    --species "Fungi" \
    ${CLEANED_ASSEMBLY} \
    --dir ${MASKED_DIR} \
    -pa 11 \
    -nolow \
    --xsmall

# "--xsmall" to soft-mask, rather than hardmask
# "--nolow" to ignore low complexity regions (better for the prediction of exons/introns)
# "--pa 11" to use 11 threads
# "--species Fungi" to use the Fungi library

# CHECK IF THE MASKED FILE EXISTS, THEN RENAME IT 
if [ -f ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ]; then
    mv ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ${REPEATMASKED_ASSEMBLY}
    echo "Genome soft-masked"
else
    echo "Error: Masked file not found for ${BASENAME}!"
    exit 1
fi
```

**Output of this:**

```{}
There were no repetitive sequences detected in /hpc/group/bio1/ewhisnant/armaleo-data/funannotate2/clagr3_f2/cleaned-genomes/Clagr3_AssemblyScaffolds_cleaned.fasta
```

* `f2-clagr3-softmask.sh`: Works as expected

**Soft-masked with `--xsmall` without `nolow`:**

```{}
RepeatMasker \
    --species "Fungi" \
    ${CLEANED_ASSEMBLY} \
    --dir ${MASKED_DIR} \
    -pa 11 \
    --xsmall

# "--xsmall" to soft-mask, rather than hardmask
# "--nolow" to ignore low complexity regions (better for the prediction of exons/introns)
# "--pa 11" to use 11 threads
# "--species Fungi" to use the Fungi library

# CHECK IF THE MASKED FILE EXISTS, THEN RENAME IT 
if [ -f ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ]; then
    mv ${MASKED_DIR}/${BASENAME}_cleaned.fasta.masked ${REPEATMASKED_ASSEMBLY}
    echo "Genome soft-masked"
else
    echo "Error: Masked file not found for ${BASENAME}!"
    exit 1
fi
```

**Example of soft-masking**

```{}
>scaffold_00001
CCCCCGCGCTTCGTCCTCCCCCTCCCAACCCCCCAACAAAccactcatcc
cctcccgcccgcccctcatacttcctccccgctcccccacccccccaCCA
GCCGCACTACCCGCATTATTCACATCCCCACCCCGCCGCGGACAGAAATA
CGTTCCTGGTGGAATGGCAGCTACGGTTCGCGATTGGACTGTGGAGGCTG
GGGAAATGGCGCATAACCGGAACCAGAGGAGGGGAGTTGGAGGGGATGGC
GGGGAGTGGGATAGGAGGTTTAGACTTGGTGAGTGTGTGGATGGAGGGGG
```

**Genome stats**

```{}
{
  "n_contigs": 413,
  "size": 34610783,
  "softmasked": "1.05%",
  "gaps": "0.16%",
  "n50": 243412,
  "n90": 43471,
  "l50": 43,
  "l90": 170,
  "avg_length": 83803
}
```

**Annotation summary from funannotate2**

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
```

* `f2-clagr3-unmask.sh`: Works as expected (no masking)

NOTE: Unnmasked genomes are automatically masked using `pytantan`

**Example of unmasked**

```{}
>scaffold_00001
CCCCCGCGCTTCGTCCTCCCCCTCCCAACCCCCCAACAAACCACTCATCCCCTCCCGCCCGCCCCTCATACTTCCTCCCC
GCTCCCCCACCCCCCCACCAGCCGCACTACCCGCATTATTCACATCCCCACCCCGCCGCGGACAGAAATACGTTCCTGGT
GGAATGGCAGCTACGGTTCGCGATTGGACTGTGGAGGCTGGGGAAATGGCGCATAACCGGAACCAGAGGAGGGGAGTTGG
AGGGGATGGCGGGGAGTGGGATAGGAGGTTTAGACTTGGTGAGTGTGTGGATGGAGGGGGGATGGTGTTGGTGAGGGAGA
GGGAGGTGGCGAGGGGGTGGGTGCTTGTTGGGATTGGGAGGGGGGATGGGGATGTTGAGGTGGGGAGGGTGGTTGGTGTT
AGGGAGCCGGTTTGGGATGTTGAGGTGGGGGGAGAGGGATGGAGTGTCGCTGTTGAGTGGGGGGTTGTGGATGGGTAGGA
GTTGCAAGCAGCCATCTATATTAAGTGAAAAGGGAGCATCGAGGAAAAGAAAGGCTGAGCCATGGTGGGAGAGGGTGGGA
```

**Genome stats**

```{}
{
  "n_contigs": 413,
  "size": 34610783,
  "softmasked": "0.16%",
  "gaps": "0.16%",
  "n50": 243412,
  "n90": 43471,
  "l50": 43,
  "l90": 170,
  "avg_length": 83803
}
```

**Annotation summary from funannotate2**

```{}
{
    "genes": 9441,
    "common_name": 599,
    "mRNA": 9394,
    "tRNA": 47,
    "ncRNA": 0,
    "rRNA": 0,
    "repeat_region": 0,
    "misc_feature": 0,
    "avg_gene_length": 1788.24,
    "transcript-level": {
        "CDS_transcripts": 9394,
        "CDS_five_utr": 0,
        "CDS_three_utr": 0,
        "CDS_no_utr": 9394,
        "CDS_five_three_utr": 0,
        "CDS_complete": 9313,
        "CDS_no-start": 38,
        "CDS_no-stop": 43,
        "CDS_no-start_no-stop": 0,
        "total_exons": 27477,
        "total_cds_exons": 27477,
        "average_number_transcripts_per_gene": 1.0,
        "multiple_exon_transcript": 6943,
        "single_exon_transcript": 2451,
        "average_number_cds_exons": 2.92,
        "avg_exon_length": 552.09,
        "median_number_exons": 2.0,
        "max_number_exons": 24,
        "avg_protein_length": 538.25,
        "avg_transcript_length": 1614.83,
        "functional": {
            "go_terms": 0,
            "interproscan": 0,
            "eggnog": 0,
            "pfam": 6847,
            "cazyme": 247,
            "merops": 260,
            "busco": 2787,
            "secretion": 0
        }
    }
}
```
