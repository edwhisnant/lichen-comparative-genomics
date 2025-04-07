# Set a CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

require(dplyr)
require(readr)

busco_summary <- read_tsv("combined_summary.tsv", show_col_types = FALSE)

busco_summary$Complete_BUSCOs_percent <- (busco_summary$Complete_BUSCOs / busco_summary$Total_BUSCOs)

busco_summary$Single_Copy_BUSCOs_percent <- (busco_summary$Single_Copy_BUSCOs / busco_summary$Total_BUSCOs)

busco_summary$Duplicated_BUSCOs_percent <- (busco_summary$Duplicated_BUSCOs / busco_summary$Total_BUSCOs)

busco_summary$Fragmented_BUSCOs_percent <- (busco_summary$Fragmented_BUSCOs / busco_summary$Total_BUSCOs)

busco_summary$Missing_BUSCOs_percent <- (busco_summary$Missing_BUSCOs / busco_summary$Total_BUSCOs)

busco_summary <- 
  
  busco_summary |> 
  
  rename(scaffold_N50 = "Scaffold N50",
         contig_N50 = "Contigs N50",
         num_scaffolds = "Number of scaffolds",
         num_contigs = "Number of contigs",
         total_length_bp = "Total length",
         percent_gaps = "Percent gaps")
  
write_tsv(busco_summary, "combined_summary.tsv")
