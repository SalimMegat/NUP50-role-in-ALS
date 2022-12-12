unset DISPLAY XAUTHORITY
export AD_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_AD.sumstats"
export PD_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_PD.sumstats"
export ALS_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_ALS.eur_only.sumstats"
#export FTD_fn="/Users/salim/Desktop/Analysis_fus/LongGene_code/GWAS_sumstats/Alkes_sumstats/PASS_FTD.sumstats"
#export FTDmnd_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_FTDmnd.sumstats"
#export FTDbv_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_FTDbv.sumstats"
#export AN_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_Anorexia.sumstats"
#export BP_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_Bipolar_Disorder.sumstats"
export SCZ_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_Schizophrenia.sumstats"
export ASD_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_Autism.sumstats"
export DP_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_DP.sumstats"
#export RA_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_Rheumatoid_Arthritis.sumstats"
#export Lupus_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_Lupus.sumstats"
#export IBD_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_IBD.sumstats"
#export FTDpnfa_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_FTDpnfa.sumstats"
#export FTDsd_fn="/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/sumstats/PASS_FTDsd.sumstats"


export out_dir='/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC'
export tissue_specific_annotation_dir='/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/cell_type_ld_score'
export weight_dir='/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/weights_hm3_no_hla'
export baseline_annotation_dir='/b/home/medecine/smegat/Consortium/scATACseq/env/ldsc_sATAC/baselineLD_v1.1'


cell_type_SPE(){
#mkdir -p $2
echo INFO - in_dir: $1
echo INFO - out_dir: $2
echo INFO - trait: $3
echo INFO - gwas: $4
echo INFO - ldcts: $5
if [[ -e "$2/$3.merged.results" ]]; then

echo "INFO - Already finished. Skipping."
return 0

fi 

ldsc.py \
    --h2-cts $4 \
    --ref-ld-chr $baseline_annotation_dir/baselineLD. \
    --out $2/$3.merged \
    --ref-ld-chr-cts $5 \
    --w-ld-chr $weight_dir/weights.
}

export -f cell_type_SPE

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients.neurons \
#alzheimers_gwas \
#$AD_fn \
#scATACneuron.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients.neurons \
#pd_gwas \
#$PD_fn \
#scATACneuron.ldcts

cell_type_SPE \
$tissue_specific_annotation_dir/ \
$out_dir/ld_coefficients.neurons \
als_gwas \
$ALS_fn \
scATACneuron.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#ftdBV_gwas \
#$FTDbv_fn \
#scATAC.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#ftdMND_gwas \
#$FTDmnd_fn \
#scATAC.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#ftdPNFA_gwas \
#$FTDpnfa_fn \
#scATAC.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#ftdSD_gwas \
#$FTDsd_fn \
#scATAC.ldcts


#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#anorexia \
#$AN_fn \
#scATAC.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#bipolar_disorder \
#$BP_fn \
#scATAC.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients.neurons \
#schizophrenia \
#$SCZ_fn \
#scATACneuron.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients.neurons \
#autism \
#$ASD_fn \
#scATACneuron.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients.neurons \
#depression \
#$DP_fn \
#scATACneuron.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#rhumatoid_arthritis \
#$RA_fn \
#scATAC.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#lupus \
#$Lupus_fn \
#scATAC.ldcts

#cell_type_SPE \
#$tissue_specific_annotation_dir/ \
#$out_dir/ld_coefficients \
#inflammatory_bowel_disease \
#$IBD_fn \
#scATAC.ldcts
