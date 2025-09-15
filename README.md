# SESC
SESC (Simple Ensembl Symbol Converter) is essentially a user-friendly wrapper around Bioconductor’s biomaRt functionality in R. Its main purpose is to simplify the process of converting Ensembl IDs into various other gene identifiers.
<p align="center">
  <img width="556" height="602" alt="SESC_logo_final" src="https://github.com/user-attachments/assets/194b12cd-2418-45b4-9c25-f7c5c88e4b24" />
</p>

# Dependencies
-----------------

SESC requires the following R packages:

1. biomaRt (≥ 2.54.0) – for querying Ensembl BioMart databases
2. optparse (≥ 1.7.1) – for parsing command-line arguments
3. data.table (≥ 1.14.0) – for efficient data manipulation

Ensure you are using R version ≥ 4.1.0 to satisfy Bioconductor requirements.

You can install them as follows:

# Install Bioconductor package
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("biomaRt")

# Install CRAN packages
install.packages(c("optparse", "data.table"))
