# SESC
SESC (Simple Ensembl Symbol Converter) is essentially a user-friendly wrapper around Bioconductor’s biomaRt functionality in R. Its main purpose is to simplify the process of converting Ensembl IDs into various other gene identifiers.
<p align="center">
  <img width="556" height="602" alt="SESC_logo_final" src="https://github.com/user-attachments/assets/194b12cd-2418-45b4-9c25-f7c5c88e4b24" />
</p>

## Features

- Convert Ensembl Gene/Transcript/Protein IDs into:
  - HGNC symbols
  - Entrez Gene IDs
  - UniProt IDs
  - and vice versa…
- Single symbol conversions for the impatient
- Batch conversion from text files

## Dependencies

SESC requires the following R packages:

1. **biomaRt** – for querying Ensembl BioMart databases
2. **optparse** – for parsing command-line arguments
3. **data.table** – for efficient data manipulation

Ensure you are using **R version ≥ 4.1.0** to satisfy Bioconductor requirements.

You can install them as follows:

### Install Bioconductor package
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("biomaRt")
```

### Install CRAN packages
```R
install.packages(c("optparse", "data.table"))
```

## Usage

### Clone the repository
```
git clone https://github.com/Thanujay/SESC.git
cd SESC
```

### Running of the SESC tool

SESC tool have 3 sub-functions as given below,
- Single - *Convert a single Ensembl ID into selected identifiers.*
- Batch - *Convert multiple Ensembl IDs from an input txt file*
- Features - *To print the features available in the human biomaRt DB*

## Single Mode
```R
Rscript SESC_test.R -m single -q ENSG00000012048 -a ensembl_gene_id,hgnc_symbol -f ensembl_gene_id -o single_res.txt
```
