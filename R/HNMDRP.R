HNMDRP <- function(transCD, simCC, simDD, simTT, transDT, decay, min_sim)
{
	max_sim = 0.99
  thr=1e-4

	simCC[simCC > max_sim] = max_sim
	simCC[simCC < min_sim] = 0
	tmpEye = diag(nrow(simCC))
	simCC = simCC + tmpEye
	simCC[simCC > 1] = 1

	simDD[simDD > max_sim] = max_sim
	simDD[simDD < min_sim] = 0
	tmpEye = diag(nrow(simDD))
	simDD = simDD + tmpEye
	simDD[simDD > 1] = 1

	simTT[simTT > max_sim] = max_sim
	simTT[simTT < min_sim] = 0
	tmpEye = diag(nrow(simTT))
	simTT = simTT + tmpEye
	simTT[simTT > 1] = 1

	DD1 = (simDD%*%transDT)%*%(simTT%*%(t(transDT)))
	DD1 = DD1/(((rowSums(DD1))*((colSums(DD1))))^0.5 + 0.001)

	DD2 = ((t(transCD))%*%simCC)%*%(transCD%*%simDD)
	DD2 = DD2/(((rowSums(DD2))*((colSums(DD2))))^0.5 + 0.001)

	CD2 = transCD%*%DD1
	DT2 = DD2%*%transDT
	
	CD1 = transCD
	DT1 = transDT
	
	cat('\n')
	i=0
	error1=error2=1
	while(i<30 && error1>thr && error2>thr){
		i = i + 1
		error1 = sum(abs(CD2 - CD1))
		error2 = sum(abs(DT2 - DT1))
		print(sprintf('Difference between CD: %f   Difference between DT:  %f', error1, error2))
		
		CD1 = CD2
		DT1 = DT2
		
		DD1 = simDD%*%DT1%*%simTT%*%t(DT1)
		DD1 = DD1 / DD1/(((rowSums(DD1))*((colSums(DD1))))^0.5 + 0.001)
		
		DD2 = t(CD1)%*%simCC%*%CD1%*%simDD
		DD2 = DD2/(((rowSums(DD2))*((colSums(DD2))))^0.5 + 0.001)
		
		CD2 = decay * CD1%*%DD1 + (1 - decay) * transCD
        	DT2 = decay * DD2%*%DT1 + (1 - decay) * transDT
	}
	return (CD2)
	cat('\n')
}