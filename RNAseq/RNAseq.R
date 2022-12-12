#############################################################################
library(edgeR)
setwd('~/Desktop/Analysis_fus/LongGene_code/src/')
source('libraries.R')
source('ComBat-seq/ComBat_seq.R')
source('ComBat-seq/helper_seq.R')
library(enrichR)
library(gplots)
library(igraph)


##### Load ENCODE normalised count for all RBPs binding to NUP50 #####
counts_cell  = fread('all.normalized.count.K562.txt')



#### Plotting function for individual gene expresssion ######
plot_logcpm_expr <- function(a, gene = ""){
  a <- a[a$gene_name == gene,]
  df <- data.frame(logcpm = c(as.numeric(a[startsWith(colnames(a), "C")]),
                              as.numeric(a[startsWith(colnames(a), "A")]),
                              as.numeric(a[startsWith(colnames(a), "F")]),
                              as.numeric(a[startsWith(colnames(a), "K")])),
		              as.numeric(a[startsWith(colnames(a), "T")])),
	group = c(rep("Control", 8),rep("AQR", 2),rep("FUS", 2), rep("KHSRP", 2), rep("TDP43",2)))
  
  ggplot(df, aes(x = group, y = logcpm)) + 
    geom_point(aes(color = group), alpha = 0.5,
                 position = position_dodge(0.9)) + 
    ggtitle(paste0( "LogCPM expression of", g)) + ylim(0,1.5)
  
} 

genes <- c("NUP50")
for (g in genes){
  pdf(file= paste0("gene_", g, '_ENCODE.pdf'))
  cat("### ", g, "\n")
  p <- plot_logcpm_expr(counts_cell, g)
  print(p)
  cat("\n\n")
  dev.off()
}


##### Load ALS-FTD post-mortem normalised counts ####
counts_cell  = fread('all.normalized.count.ALS_FTD.txt')



#### Plotting function for individual gene expresssion ######
plot_logcpm_expr <- function(a, gene = ""){
  a <- a[a$gene_name == gene,]
  df <- data.frame(logcpm = c(as.numeric(a[startsWith(colnames(a), "A")]),
                              as.numeric(a[startsWith(colnames(a), "C")]),
                              as.numeric(a[startsWith(colnames(a), "F")]),
                              as.numeric(a[startsWith(colnames(a), "Tau")]),
                              as.numeric(a[startsWith(colnames(a), "TD")])),
                   group = c(rep("ALS",28),rep("Control", 46),rep("Fus", 3), rep("Tau", 10),rep("TDP43", 6)))
  
  ggplot(df, aes(x = group, y = logcpm)) + 
    geom_violin(aes(color = group), trim = FALSE,
                position = position_dodge(0.9) ) +
    geom_boxplot(aes(color = group), width = 0.15,
                 position = position_dodge(0.9)) + 
    ggtitle(paste0( "LogCPM expression of", g)) + ylim(0.2,1.8)
  
} 

genes <- c("NUP50")


for (g in genes){
  pdf(file= paste0("gene_", g, '_FTD.pdf'))
  cat("### ", g, "\n")
  p <- plot_logcpm_expr(als_ftd, g)
  print(p)
  cat("\n\n")
  dev.off()
}



