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

* `f2-clagr3-unmask.sh`: Works as expected (no masking)

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
