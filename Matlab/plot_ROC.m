function [auc1] = plot_ROC(pre_Result, label, drug_num)
    index = (1:962)';
    drug_label_all = label;
    color0 = [214 39 40]/256;
    figure;x = 0:0.02:1;y = x;
    
    index_po_na = setdiff(index,find(drug_label_all(:,drug_num) == -1));
    drug_label = drug_label_all(index_po_na,drug_num);
    score_predict_HNMDRP = pre_Result(index_po_na,drug_num);
    [auc1] = roc(score_predict_HNMDRP,drug_label,color0);hold on;
    plot(x,y,'--k','LineWidth',2);
    legend(['HNMDRP-',num2str(auc1)],'Location','SouthEast');
end          
