function [predict_score] = LOOCV(transCD,simC,simD,simT,transDT,decay,min_sim)
A_ori = transCD;
[scoreCD_ori,scoreDT] = HNMDRP(transCD,simC,simD,simT,transDT,decay,min_sim);
index = find(1 == A_ori);
for i = 1:length(index)
    i
    transCD(index(i)) = 0;
    [scoreCD,scoreDT] = HNMDRP(transCD,simC,simD,simT,transDT,decay,min_sim);
    scoreCD_ori(index(i)) = scoreCD(index(i));
    scoreCD_ori(index(i));
    transCD = A_ori;
end
predict_score = scoreCD_ori;

