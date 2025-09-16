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
- **Single** - *Convert a single Ensembl ID into selected identifiers.*
- **Batch** - *Convert multiple Ensembl IDs from an input txt file*
- **Features** - *To print the features available in the human biomaRt DB*

#### Single Mode
Run a single query conversion (To convert the ENSG gene ID to HGNC gene symbol) as given below,
```R
Rscript SESC_v0.1.R -m single -q ENSG00000012048 -a ensembl_gene_id,hgnc_symbol -f ensembl_gene_id -o stdout
```
<img width="1506" height="190" alt="Screenshot 2025-09-16 202345" src="https://github.com/user-attachments/assets/4eb20bc0-24ba-4073-8a40-b3b324e76a21" />

#### Batch Mode
Run a batch conversion (To convert the multiple ENSG gene IDs to respective HGNC gene symbols) as given below,
```R
Rscript SESC_v0.1.R -m batch -i test_batch.txt -a ensembl_gene_id,hgnc_symbol -f ensembl_gene_id -o test_batch_output.txt
```
<img width="1626" height="139" alt="Screenshot 2025-09-16 203017" src="https://github.com/user-attachments/assets/0457830e-e5d7-49a7-8363-88f16060c350" />

#### Features
Function to print all the features available in the human biomaRt DB
```R
Rscript SESC_v0.1.R -m features
```
## Arguments

| Flags          | Description                             |         Example                 |    Applicable     |
| -------------- |:---------------------------------------:| -------------------------------:| -----------------:|
| -m/--mode      | Mode of processing                      | -m (single/batch/features)      | Required          |
| -q/--query     | Single query for annotation             | -q ENSG00000012048              | Single mode ONLY  |
| -i/--input     | Input file with multiple queries        | -i query.txt                    | Batch mode ONLY   |
| -o/--output    | Output file to write results            | -o (stdout(Single mode)/res.txt)| Single/Batch mode |
| -a/--attributes| Annotation attributes (comma-separated) | -a ensembl_gene_id,hgnc_symbol  | Single/Batch mode |
| -f/--filter    | Query filter for BioMart                | -f ensembl_gene_id              | Single/Batch mode |

**Note**: In single mode, results can either be printed directly to stdout for quick reference, or saved to a .txt file for later use.

## Example Workflow for Batch mode

### Input (genes.txt)
```
ENSG00000141510
ENSG00000171862
ENSG00000155657
```

### Running Command
```R
Rscript SESC_v0.1.R -m batch -i genes.txt -a ensembl_gene_id,hgnc_symbol -f ensembl_gene_id -o genes_output.txt
```

### Output (genes_output.txt)

| ensembl_gene_id |	hgnc_symbol |
| --------------  |:-----------:|
| ENSG00000141510 |	TP53        |
| ENSG00000155657 | TTN         |
| ENSG00000171862	| PTEN        |

## Contributions
 - Currently, SESC supports conversions using the human BioMart dataset. In the upcoming versions, will make the script flexible for any organism of your choice!
 - Pull requests and feature suggestions are welcome! Please open an issue first to discuss any major changes.

