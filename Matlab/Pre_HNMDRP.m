clc;
clear;
load ('data/cline_similarity_network.mat')  
load('data/cline_drug_association_network.mat')
load ('data/drug_similarity_network.mat')  
load ('data/drug_target_interaction_network.mat')
load ('data/PPI_network_add_corr.mat')
load('data/cline_drug_association_with_unknown.mat')

transCD_with_unknown = cline_drug_association_with_unknown;
simCC = cline_similarity_network;
transCD = cline_drug_association_network;
simDD = drug_similarity_network;
transDT = drug_target_interaction_network;
simTT = PPI_network_add_corr;

[pre_HNMDRP_Result] = LOOCV(transCD,simCC,simDD,simTT,transDT,0.7,0.3);

