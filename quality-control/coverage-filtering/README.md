# Removal of genomes with low coverage

This was done manually, in an personal QMD workbook. The output from BUSCO filerting can be found [here](https://github.com/edwhisnant/genome_annotation_programs/blob/main/quality-control/BUSCO/output/Lecanoromycetes/busco_filtered_genomes_db_95.xlsx). Note: this is an `xlsx` file.

Below is the code that was used to filter for coverage:

# QUALITY CONTROL STEP 02 SEQUENCING COVERAGE

* HERE I AM FILTERING FOR GENOMIC COVERAGE


```{r}

busco_filtered_genomes_db_95 <- read_xlsx("~/busco_filtered_genomes_db_95.xlsx")

#########################################################################################
##                              FILTER >= 25X COVERAGE                                  #
#########################################################################################
# this retains 73 genomes

coverage_25x <- 
  
  busco_filtered_genomes_db_95 |> 
  
  filter(coverage >= 25)

# How many genomes are retained?
coverage_25x |> nrow()

# What is the representation of orders after filtering for 25x coverage
orders_cov_25x <- 
  
  coverage_25x |> 
  
  group_by(order) |> 
  
  summarise(count = n()) |> 
  
  rename(num_genomes_25x = count)

orders_cov_25x <- as_tibble(orders_cov_25x)

coverage_25x |> write_tsv("coverage-filtering/filtered-coverage-25x.tsv")

#########################################################################################
##                              FILTER >= 20X COVERAGE                                  #
#########################################################################################
# Retains 85 genomes

coverage_20x <- 
  
  busco_filtered_genomes_db_95 |> 
  
  filter(coverage >= 20)

# How many genomes are retained?
coverage_20x |> nrow()

# What is the representation of orders after filtering for 20x coverage

orders_cov_20x <-
  
  coverage_20x |> 
  
  group_by(order) |> 
  
  summarise(count = n()) |> 
  
  rename(num_genomes_20x = count)

orders_cov_20x <- as_tibble(orders_cov_20x)

coverage_20x |> write.csv("coverage-filtering/filtered-coverage-20x.csv")

#########################################################################################
##                              FILTER >= 15X COVERAGE                                  #
#########################################################################################
# this retains 94 genomes 
coverage_15x <- 
  
  busco_filtered_genomes_db_95 |> 
  
  filter(coverage >= 15)

# How many genomes are retained?
coverage_15x |> nrow()

# What is the representation of orders after filtering for 15x coverage
orders_cov_15x <-
  
  coverage_15x |> 
  
  group_by(order) |> 
  
  summarise(count = n()) |> 
  
  rename(num_genomes_15x = count)

orders_cov_15x <- as.data.frame(orders_cov_15x)

coverage_15x |> write.csv("coverage-filtering/filtered-coverage-15x.csv")

#########################################################################################
##                              FILTER >= 10X COVERAGE                                  #
#########################################################################################
# This retains nearly all of the data post BUSCO filter (117/118)
coverage_10x <- 
  
  busco_filtered_genomes_db_95|> 
  
  filter(coverage >=  10)

# How many genomes are retained?
coverage_10x |> nrow()

# What is the representation of orders after filtering for 10x coverage
orders_cov_10x <-

  coverage_10x |> 
  
  group_by(order) |> 
  
  summarize(count = n()) |> 
  
  rename(num_genomes_10x = count)

orders_cov_10x <- as.data.frame(orders_cov_10x)

coverage_10x |> write.csv("coverage-filtering/filtered-coverage-10x.csv")

#########################################################################################
##                      COMPARE THE REPRESENTATION OF ORDERS                            #
#########################################################################################


# Join the dataframes step by step
coverage_summary_order <- orders_cov_10x |> 
  full_join(orders_cov_15x, by = "order") |> 
  full_join(orders_cov_20x, by = "order") |> 
  full_join(orders_cov_25x, by = "order") 
  

print(coverage_summary_order)

coverage_summary_order |> write_csv("coverage-filtering/representation_orders.csv")

# Plot these results:
coverage_long <- 
  
  coverage_summary_order |> 
  
  pivot_longer(cols = starts_with("num_genomes"), names_to = "coverage", values_to = "num_genomes")

# Plot the data
ggplot(coverage_long, aes(x = order, y = num_genomes, fill = coverage)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of Genomes at Different Coverage cutoff's",
       x = "Order",
       y = "Number of Genomes") +

  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


```
