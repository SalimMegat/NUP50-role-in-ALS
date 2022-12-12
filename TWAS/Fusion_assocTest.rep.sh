while read tissue;

do for chr in {1..22};

do Rscript ~/Desktop/fusion_twas/FUSION.assoc_test.R \
--sumstats /Users/salim/Desktop/Analysis_fus/TWAS/exp_TWAS_hg19/GWAS_files/ALS_LMM.replication.sumstats.gz \
--weights /Users/salim/Desktop/Analysis_fus/TWAS/exp_TWAS_hg19/$tissue".P01.pos" \
--weights_dir /Users/salim/Desktop/Analysis_fus/TWAS/exp_TWAS_hg19/ \
--ref_ld_chr /Users/salim/Desktop/Analysis_fus/LongGene_code/LDREF/1000G.EUR. \
--chr ${chr} \
--out ./out_replication/"ALS."$tissue"_"${chr}".dat"

done;

done < list.dir
