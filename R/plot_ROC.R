plot_ROC <- function(transCD_all, predict_result, choose_drug_num){
  label_all = as.matrix(transCD_all)
  
  label_drug = which(label_all[,choose_drug_num]!=-1)
  drug_label= label[label_drug,choose_drug_num]
  label_predict = predict_result[label_drug,choose_drug_num]
  
  library("pROC")
  roc(drug_label,label_predict,plot=TRUE,print.auc=TRUE)
}