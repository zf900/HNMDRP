source("HNMDRP.R")
LOOCV <- function(transCD, simCC, simDD, simTT, transDT, decay, min_sim){
	interaction_CD = as.matrix(transCD)
	simC = as.matrix(simCC)
	simD = as.matrix(simDD)
	simT = as.matrix(simTT)
	interaction_DT = as.matrix(transDT)
	
	interaction_CD_ori = interaction_CD
	score_ori = HNMDRP(interaction_CD, simC, simD, simT, interaction_DT, decay, min_sim)
	index = which(1==interaction_CD)
	for(i in 1:length(index)){
		interaction_CD[index[i]] = 0
    		score = HNMDRP(interaction_CD, simC, simD, simT, interaction_DT, decay, min_sim)
    		score_ori[index[i]] = score[index[i]]
    		interaction_CD = interaction_CD_ori
	}
	predict_score = as.numeric(matrix(score_ori))
	return (predict_score)
}