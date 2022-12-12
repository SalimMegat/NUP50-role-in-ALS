library(tidyverse)

### Plot cell type enrichment 

data = read.table('all.cell.type.results', header = T)
data$Coefficient_P_value = pnorm(data$Coefficient_z.score, lower.tail=TRUE)
data$fdr = p.adjust(data$Coefficient_P_value, method = 'fdr')

bigplot=ggplot(data, aes(x=Disease,y=-log10(Coefficient_P_value), color=Name)) +
  labs(y="-log10(Coefficient P-value)")+
  geom_point(size=3, alpha=0.5) + coord_flip()+ scale_color_brewer(palette="Set3")+ theme_bw() 
plot(bigplot)
ggsave("resuts_sc_gwas.pdf", bigplot,dpi = 300)


### Plot molecular trait enrichment MaxCPP 

data.qtl = read.table('all.qtl.type.results', header = T)
data.qtl$Coefficient_P_value = pnorm(data.qtl$Coefficient_z.score, lower.tail=TRUE)

data.qtl$fdr = p.adjust(data.qtl$Coefficient_P_value, method = 'fdr')

bigplot=ggplot(data.qtl, aes(x=Disease,y=-log10(Coefficient_P_value), color=Category)) +
  labs(y="-log10(Coefficient P-value)")+
  geom_point(size=3,alpha=0.5) + coord_flip()+ scale_color_brewer(palette="Set3")+ theme_bw()
plot(bigplot)
ggsave("resuts_qtl_gwas.pdf", bigplot,dpi = 300)


