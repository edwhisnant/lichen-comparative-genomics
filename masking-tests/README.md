# Testing masking algorithims and strategies

There are some questions about which masking protocol is the "better" protocol. 

There are three main types of maskings:

1. Hard-masking: repetitive sequences are replaced with `N` or `X`. Here you are losing information about the sequences, due to nucleotides being replaced.

2. Soft-masking: repetitive sequences are replaced with lower-case versions of the letters. Here, information is retained after masking.

3. Unmasked: The genomes represent all of the assembled nuceotides, unchanged.

*RepeatMasker* has other options, including options to soft-mask and to skip low-complexity regions.

Here I am testing 5 combinations of masking or unmasking strategies (in order from most conservative to least):

1. Hard-masking (default for RM)

2. Hard-masking (with `-nolow`): skips masking for low-complexity regions

3. Soft-masking: Soft-masks the low-complexity regions in addition to the interspaced repeat regions

4. Soft-maksing (with `nolow`): skips soft-masking for low-complexity regions

5. Unamsked: Genome is remains unmasked.

### Scripts

* `f2-clagr3-hardmask.sh`: Works as expected (default settings)

`f2-clagr3-hardmask-nolow.sh`: `-nolow` or `l` flag results in no masked output file and the script crashes

`f2-clagr3-softmask-nolow.sh`:  `-nolow` or `l` flag results in no masked output file and the script crashes

`f2-clagr3-softmask.sh`: Works as expected

`f2-clagr3-unmask.sh`: Works as expected (no masking)

`run-all-f2-scripts.sh`
