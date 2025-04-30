import pandas as pd

# Read the input TSV file
busco_summary = pd.read_csv("combined_summary.tsv", sep="\t")

# Calculate percentages
busco_summary["Complete_BUSCOs_percent"] = busco_summary["Complete_BUSCOs"] / busco_summary["Total_BUSCOs"]
busco_summary["Single_Copy_BUSCOs_percent"] = busco_summary["Single_Copy_BUSCOs"] / busco_summary["Total_BUSCOs"]
busco_summary["Duplicated_BUSCOs_percent"] = busco_summary["Duplicated_BUSCOs"] / busco_summary["Total_BUSCOs"]
busco_summary["Fragmented_BUSCOs_percent"] = busco_summary["Fragmented_BUSCOs"] / busco_summary["Total_BUSCOs"]
busco_summary["Missing_BUSCOs_percent"] = busco_summary["Missing_BUSCOs"] / busco_summary["Total_BUSCOs"]

# Rename columns
busco_summary = busco_summary.rename(columns={
    "Scaffold N50": "scaffold_N50",
    "Contigs N50": "contig_N50",
    "Number of scaffolds": "num_scaffolds",
    "Number of contigs": "num_contigs",
    "Total length": "total_length_bp",
    "Percent gaps": "percent_gaps"
})

# Write the updated data back to a TSV file
busco_summary.to_csv("combined_summary.tsv", sep="\t", index=False)