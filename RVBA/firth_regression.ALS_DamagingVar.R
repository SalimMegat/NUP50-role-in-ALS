##setwd("~/Desktop/hpc_server/")
suppressMessages(library('data.table'))
#suppressMessages(library('SummarizedExperiment'))
suppressMessages(library('sessioninfo'))
suppressMessages(library('pryr'))
suppressMessages(library('logistf'))
suppressMessages(library('getopt'))
suppressMessages(library('BiocParallel'))
suppressMessages(library('plyr'))
## Specify parameters
spec <- matrix(c(
  'cores', 'c', 1, 'integer', 'Number of cores to use. Use a small number',
  'help' , 'h', 0, 'logical', 'Display help'
), byrow=TRUE, ncol=5)
opt <- getopt(spec)


pheno = read.table("covariates_ALS", header=T)
#colnames(pheno)[4] <- "PC0"
pheno["PHENO"][pheno["PHENO"] == 1] <- 0
pheno["PHENO"][pheno["PHENO"] == 2] <- 1

files <- list.files(path="plink_raw_dam_ALS", pattern="*.raw", full.names=TRUE, recursive=FALSE)
names(files) <- dir('plink_raw_dam_ALS', '.*raw$')

newraw <- bpmapply(function(input_raw, filename) {
  message(paste(Sys.time(), 'reading file', input_raw))
  geno <- read.table(input_raw, header=TRUE) # load file
  geno[is.na(geno)] <- 0
  geno <- geno[match(pheno$IID, geno$IID),]
  # apply function
  out_firth <- file.path(getwd(), 'firth_regression_out_dam_ALS', paste0('firth_regression_', filename))
  # check if IID is in the same order:
  table(geno$IID == pheno$IID)


  # format burden as sum of all rare alleles.
  geno_mtx = as.matrix(geno[,7:ncol(geno)])
  burden = apply(geno_mtx, 1, sum)

  # check distribution of rare variants (are alleles indeed rare)
  uniq_var = as.data.frame(table(burden))
  uniq_var = uniq_var[2,2]
  
  # format phenotype and covariates.
  P = as.numeric(pheno$PHENO)
  PC = as.matrix(pheno[,paste0("PC",1:10)]) ; colnames(PC) = 1:10
  
  # make 2x2 table:
  cat("2x2 contingency table:\n")
  case_control = as.data.frame(table(P, burden))
  uniq_case = case_control[4,3]
  uniq_control = case_control[3,3]
  # rare variants occur more frequently in FTD cases.
  
  cat("\nFirth logistic regression:\n\n")
  m1 = logistf::logistf(P ~ burden + PC)
  coef = m1$coefficients["burden"]
  p = m1$prob["burden"]
  se = sqrt(diag(vcov(m1)))
  se = se["burden"]
  
  #Split names file into transcript ID and Gene name
  #names = gsub("\\..*","",names(files))
  results = as.data.frame(cbind(coef,se,p,uniq_var,uniq_case,uniq_control,gsub("\\..*","",filename)))
  colnames(results)[7] = "Transcript"
  
    # write to file
    write.table(results, out_firth, sep="\t", quote=F, row.names=F, col.names=T)
},files,names(files),BPPARAM = MulticoreParam(workers = opt$cores),SIMPLIFY = TRUE)
