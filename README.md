# SESC
SESC (Simple Ensembl Symbol Converter) is a user-friendly wrapper around Ensembl’s biomaRt functionality in R. Its main purpose is to simplify the process of converting Ensembl IDs into various other gene identifiers.
<p align="center">
  <img width="556" height="602" alt="SESC_logo_final" src="https://github.com/user-attachments/assets/194b12cd-2418-45b4-9c25-f7c5c88e4b24" />
</p>

## Features

- Convert Ensembl Gene/Transcript/Protein IDs into:
  - Gene symbols
  - Other Gene IDs
  - UniProt IDs
  - and vice versa…
- Single symbol conversions for the impatient
- Batch conversion from text files
- Feature option helps tha user to choose the required conversion identifier

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
Rscript SESC_v0.2.R -m single -q ENSG00000012048 -a ensembl_gene_id,hgnc_symbol -f ensembl_gene_id -o stdout --org hsapiens_gene_ensembl
```

#### Batch Mode
Run a batch conversion (To convert the multiple ENSG gene IDs to respective HGNC gene symbols) as given below,
```R
Rscript SESC_v0.2.R -m batch -i test_batch.txt -a ensembl_gene_id,hgnc_symbol -f ensembl_gene_id -o test_batch_output.txt --org hsapiens_gene_ensembl
```

#### Features
Function to print all the features available in the human biomaRt DB
```R
Rscript SESC_v0.2.R -m features --org hsapiens_gene_ensembl
```
## Arguments

| Flags          | Description                             |         Example                 |    Applicable              |
| -------------- |:---------------------------------------:| -------------------------------:| --------------------------:|
| -m/--mode      | Mode of processing                      | -m (single/batch/features)      | Required                   |
| -q/--query     | Single query for annotation             | -q ENSG00000012048              | Single mode ONLY           |
| -i/--input     | Input file with multiple queries        | -i query.txt                    | Batch mode ONLY            |
| -o/--output    | Output file to write results            | -o (stdout(Single mode)/res.txt)| Single/Batch mode          |
| -a/--attributes| Annotation attributes (comma-separated) | -a ensembl_gene_id,hgnc_symbol  | Single/Batch mode          |
| -f/--filter    | Query filter for BioMart                | -f ensembl_gene_id              | Single/Batch mode          |
| --org          | Organism of interest                    | --org hsapiens_gene_ensembl     | Single/Batch/Features mode |

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
Rscript SESC_v0.2.R -m batch -i genes.txt -a ensembl_gene_id,hgnc_symbol -f ensembl_gene_id -o genes_output.txt --org hsapiens_gene_ensembl
```

### Output (genes_output.txt)

| ensembl_gene_id |	hgnc_symbol |
| --------------  |:-----------:|
| ENSG00000141510 |	TP53        |
| ENSG00000155657 | TTN         |
| ENSG00000171862	| PTEN        |

## Important Notes
 - In the current version of SESC (v0.2), all organisms available in the biomaRt database are supported. A list of these datasets is included in the repository for your reference.
 - Please note that available features may vary between organisms. It is recommended to run the features mode for your organism of interest to identify the appropriate identifier(s) for conversion.
   Example single mode run on Mus musculus:
   ```R
   Rscript SESC_v0.2.R -m single -q ENSMUSG00000017167 -a ensembl_gene_id,mgi_symbol -f ensembl_gene_id -o stdout --org mmusculus_gene_ensembl
   ```

## Contributions
 - Pull requests and feature suggestions are welcome! Please open an issue first to discuss any major changes.

