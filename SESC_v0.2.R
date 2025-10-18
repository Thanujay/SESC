#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(biomaRt))
library(data.table)

# Define command-line options

option_list <- list(
  make_option(c("-m", "--mode"), type="character",
              help="Mode of execution: single | batch | features"),
  make_option(c("-q", "--query"), type="character", default=NULL,
              help="Single query for annotation (required in single mode)"),
  make_option(c("-i", "--input"), type="character", default=NULL,
              help="Input file with queries (required in batch mode)"),
  make_option(c("-o", "--output"), type="character", default=NULL,
              help="Output file to write results (required in single/batch mode)"),
  make_option(c("-a", "--attributes"), type="character", default=NULL,
              help="Annotation attributes (comma-separated)"),
  make_option(c("-f", "--filter"), type="character", default=NULL,
              help="Query filter for BioMart"),
  make_option(c("--org"), type="character", default=NULL,
              help="Organism of interest")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

# Validate mode

if (is.null(opt$mode)) {
  print_help(opt_parser)
  stop("Error: --mode/-m is required (single | batch | features)")
}

mode <- opt$mode

# --- Initialize BioMart ---
cat("Connecting to BioMart...\n")
mart <- tryCatch({
  useMart("ensembl", dataset = opt$org)
}, error = function(e) {
  stop("Error connecting to BioMart: ", e$message, call. = FALSE)
})
cat("BioMart connection established.\n")

# SINGLE MODE

if (mode == "single") {
  start <- Sys.time()
  cat("Single query processing started at:", format(start, "%H:%M"), "\n")
  required_args <- c("query", "attributes", "filter", "output")
  missing_args <- required_args[sapply(required_args, function(x) is.null(opt[[x]]))]
  
  if (length(missing_args) > 0) {
    cat("Missing required arguments:\n--", paste(missing_args, collapse="\n--"), "\n")
    print_help(opt_parser)
    quit(status=1)
  }
  
  attrs <- unlist(strsplit(opt$attributes, ","))
  
  result <- getBM(
    attributes = attrs,
    filters = opt$filter,
    values = opt$query,
    mart = mart
  )
  
  end <- Sys.time()
  if (opt$output != "stdout") {
  write.table(result, file=opt$output, sep="\t", quote=FALSE, row.names=FALSE)
  cat("Single query results written to:", opt$output, "\n")
  } else {
    cat("\n")
    print(result)
    cat("\n")}
  cat("Single query processing ended at:", format(start, "%H:%M"), "\n")
  cat("Time taken:", round(difftime(end, start, units="mins"), 2), "minutes\n")
  
  # BATCH MODE
  
} else if (mode == "batch") {
  start <- Sys.time()
  cat("Batch query processing started at:", format(start, "%H:%M"), "\n")
  required_args <- c("input", "attributes", "filter", "output")
  missing_args <- required_args[sapply(required_args, function(x) is.null(opt[[x]]))]
  
  if (length(missing_args) > 0) {
    cat("Missing required arguments:\n--", paste(missing_args, collapse="\n--"), "\n")
    print_help(opt_parser)
    quit(status=1)
  }
  
  if (!file.exists(opt$input)) {
    stop("Input file does not exist: ", opt$input)
  }
  
  # Input file
  input_file <- opt$input   
  queries <- read.table(input_file, header = FALSE, stringsAsFactors = FALSE)$V1
  
  # Remove version numbers if present
  queries <- sub("\\..*$", "", queries)
  
  attrs <- unlist(strsplit(opt$attributes, ","))
  
  batch_result <- getBM(
    attributes = attrs,
    filters = opt$filter,
    values = queries,
    mart = mart
  )
  end <- Sys.time()
  cat("Batch query processing ended at:", format(start, "%H:%M"), "\n")
  write.table(batch_result, file=opt$output, sep="\t", quote=FALSE, row.names=FALSE)
  cat("Batch query results written to:", opt$output, "\n")
  cat("Time taken:", round(difftime(end, start, units="mins"), 2), "minutes\n")
  
  # FEATURES MODE

} else if (mode == "features") {
  cat("Listing all available features from BioMart:\n")
  feat <- listAttributes(mart, page="feature_page")
  print(feat$name)
  
} else {
  stop("Invalid --mode. Choose one of: single | batch | features")
}