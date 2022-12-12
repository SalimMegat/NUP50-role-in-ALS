
suppressMessages(library('dplyr'))
suppressMessages(library("tidyr"))
suppressMessages(library("readr"))
suppressMessages(library("optparse"))
library(stringr)

option_list = list(
  make_option("--file_location", action="store", default=NA, type='character',
              help="Path to TWAS result files from FUSION [required]"),
  make_option("--out", action="store", default=NA, type='character',
              help="Path to output files [required]")
)

opt = parse_args(OptionParser(option_list=option_list))


#Read in data
file_list <- list.files(path=opt$file_location)
for (i in 1:length(file_list)){
  filename<-paste0(opt$file_location,file_list[i])
  twas <- read.table(filename,"\t", header = T,stringsAsFactors = F)
  twas  = twas[complete.cases(twas$TWAS.P),]
  n_row <-dim(twas)[1]
  twas$FDR = p.adjust(twas$TWAS.P, method = 'fdr', n = n_row)
  twas$FDR_tissue = twas$FDR*13
  twas <- twas[order(twas$ID, twas$FDR_tissue), ] #sort by id and reverse of abs(value)
  out<-paste0(opt$out,file_list[i])
  
write.table(twas,out,sep = "\t",quote = F,row.names = F,col.names = T)
}
