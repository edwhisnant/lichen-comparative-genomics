# Results

## Summary of representation of the Lecanoromycetes

For the comparative genomics, we utilized 106 genomes representing four subclasses (plus one group representing uncertain placement in a sublcass), 13 orders (plus one group representing uncertain ordinal placement), 23 families (plus one group representing uncertain familial placement), and 52 genera (one representing a genome lacking placement within a genus) in the Lecanoromycetes.

## Presence/absence of Orthogroups 

### Within the Ostropales

In this dataset, six genomes were assigned to the Ostropales. These genomes are split evenly between two families, the Graphidaceae and the Stictidaceae. Within the Stictidaceae, we gathered three genomes, representing three genera. These genomes represent two non-lichenized and one facultative species. In the Graphidaceae, there are three genomes representing two genera. Two genomes are assigned to the same species. All genomes in the Graphidaceae represent lichenized taxa. After subsetting the overall overall copy-number matrix for the Ostropales, and removing orthogroups that were entrirely absent from the Ostropales (zero copies in Ostropales genomes), 7332 out of 21307 orthogroups remained. 

First, we looked for the most extreme cases of orthogroup presence and absence, identifying orthogroups of zero copies versus non-zero copies between groups. When comparing the Stictidaceae and Graphidaceae, we identified 110 orthogroups absent (0 copies) in the Stictidaceae and present (> 0 copies) in the Graphidaceae. Conversly, 82 orthogroups are absent (0 copies) in the Graphidaceae that are present (> 0 copies) in the Stictidaceae. Effectively, this comparison is also a comparison between symbiotic lifestyles, where the genomes representing the Graphidaceae also represent obligate lichenized fungi and genomes fromt he Stictidaceae represent a complete or partial loss of the lichen lifestyle.

When we specify by the symbiotic lifestyle more precisely, we found 147 orthogroups absent (0 copies) in the non-lichenized taxa, but present (> 0 copies) in the lichenized and facultative taxa. We also find 129 orthogroups present (> 0 copies) in the non-lichenized taxa that are absent (0 copies) in the lichenized and facultative genomes. 

### Within the Pertusiariales

This data represents a subset of the overall copy-number matrix, filtered to include only genomes from the Pertusiariales. These five genomes represent three families, the Pertusariaceae, the Icmadophilaceae, and the Varicellariaceae. The sole genome assigned to the Pertusariaceae, *Agyrium rufum*, represents a non-lichenized taxa, whereas all others represent lichenized taxa.

First we looked for the most extreme differences in the lichenized and non-lichenized taxa. 332 orthogroups are absent (0 copies) in *Agyrium rufum* (non-lichenized), that are present in genomes from the Icmadophilaceae and Varicellariaceae (lichenized). Conversly, 160 orthogroups are present in *Agyrium rufum* (Pertusiariaceae) non-lichenized) that are absent in genomes from the Icmadophilaceae and Varicellariaceae (lichenized).

### Overall in the Lecanoromycetes

Next, we looked at larger patterns associated with the lineages containing non-lichenized and facultative genomes to identify presence or absence of orthogroups according to these traits. First we found four orthgroups present uniquely in the Ostropales (absent in all other genomes). There is one orthogroup that is absent in the Ostropales that are present in all-other taxa in the Lecanoromycetes. When we look specifically at the orthogroups present in the Stictidaceae but absent in all other genomes, we find 14 unique orthogroups. There are zero orthogroups absent in the Stictidaceae that are present in all other genomes.

Next, we specified the Stictidaceae more precisely by their symbiotic lifestyle. Stictidaceae that are strictly non-lichenized (two genomes) have 4 orthogroups present in the non-lichneized taxa and absent in all other representative genomes from the Lecanoromycetes (including the facultative Stictidaceae species). 1 orthogroup is absent in the non-lichenized Stictidaceae in comparison to the rest of the genomes. 18 orthogroups are uniquely present in the facultative Stictidaceae (*Stictis urceolata*), that are absent in all other genomes (including the two non-lichenized genomes). 13 orthogroups are uniquely absent in the facultative Stictidaceae genome, that are present in all other genomes.

In the Perusiariales, there is a single non-lichenized species in the the Pertusariaceae (*Agyrium rufum*). In this taxa, 7 orthogroups are uniquely absent, but present in all other genomes. Additionally, 18 orthogroups are uniquely present in this orthogroup compared to the rest of the genomes. If we simply group genonomes by their lifestyle, we can group genomes by whether they are facultative, non-lichenized, or lichenized genomes. Previously, we explained that 18 orthogroups are present and 13 are absent uniquesly in the facultative species *Stictis urceolata* (Ostropales, Stictidaceae). To understand if the losses of lichenization are geneticically similar in the Stictidaceae and Pertusiariaceae, we grouped all non-lichenized taxa into a single group and found that there are zero orthogroups that are uniquely present or absent based on being non-lichenized.

## Finding significant differences in copy number between groups

### Within the Ostropales

The overall orthogroup copy-number matrix was filtered for the six genomes in the Ostropales. Then they were split into the two families, the Stictidaceae and Graphidaceae, with three genomes in each (n = 3 per family). The data was cleaned of orthogroups with zero copies in all genomes, leaving 7332 orthogroups for this analysis. Using the remaining orthogroups and grouping by family, a Wilcoxin rank-sum test was conducted to identify significant differences in copy number among orthogroups and between the two families. Using the raw output of the Wilcoxin rank-sum test, 163 orthogroups were found to be significantly different (p < 0.05) between the Graphidaceae and Stictidaceae. However, after imposing either a Holm-Bonferonni correction or a Benjamini-Hochberg FDR correction, none of the orthogroups stood out as significantly different.

### Within the Pertusiariales

### In comparison with other genomes in the Lecanoromycetes

To identify orthogroups associated with "losses" of lichenization (de-lichenization) we used the orthogroup copy number matrix from OrthoFinder, and grouped genomes by their symbiotic status. Effectively, we clustered the Stictidaceae with *Agyrium rufum* and described these as "de-lichenized" (n = 4) and all others as "lichenized" (n = 102). First, we used a Wilcoxin rank-sum test (Mann-Whitney U) test, followed by FDR correction to identify orthogroups with significanly different copy numbers between the lichenized and de-lichenized groups. With this test, we found 665 orthogroups of interest. Even with FDR correction for 21,307 tests, the substantial difference in sample sizes between the groups reduced our confidence in this first test. To address this concern, we used a two-step filtering method to improve the confidence in the identification of significantly different orthogroups. First, a Wilcoxin rank-sum test was conducted (without FDR correction). Using the raw-output p-value, we filtered the orthogroups using a lenient alpha (alpha = 0.1) to peselect candidates. Then, using the 1908 orthogroups that passed this first filter, we conducted another Wilcoxin rank sum test, this time incorporating a permutations test (number of resamples = 10,000; seed number = 42), then applying an FDR correction for 1908 tests. This resulted in 423 orthogroups of interest.


