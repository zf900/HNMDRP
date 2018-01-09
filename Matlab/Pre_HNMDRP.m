clc;
clear;
load ('data/cline_similarity_network.mat')  
load('data/cline_drug_association_network.mat')
load ('data/drug_similarity_network.mat')  
load ('data/drug_target_interaction_network.mat')
load ('data/PPI_network_add_corr.mat')
load('data/cline_drug_association_network_with_unknown.mat')

transCD_with_unknown = cline_drug_association_with_unknow;
simCC = pcc_cline;
transCD = cline_drug_association;
simDD = pcc_drg(1:189,1:189);
transDT = drug_target_gdsc_v4;
simTT = W_PPI_CORR;

[pre_HNMDRP_Result] = LOOCV(transCD,simCC,simDD,simTT,transDT,0.7,0.3);

