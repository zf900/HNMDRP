# HNMDRP method------R-version

A novel heterogeneous network-based method for drug response prediction in cancer cell lines

======================= Instructions to HNMDRP software (version 1.0.0)

Developer: Fei,Zhang(fzxx@mail.ustc.edu.cn) from Health Informatics Lab, School of Information Science and Technology, University of Science and Technology of China

## **Related data information need to first load in HNMDRP** 

- /data/transCD.txt
- /data/transDT.txt
- /data/simCC.txt
- /data/simDD.txt
- /data/simTT.txt
- /data/trans_CD_all.mat

The first file transCD.txt is a matrix of known drug sensitivity relationships between cell lines and drugs. 
The second file transDT.txt is a matrix of known drug molecular activities between drugs and targets.
The third file simCC.txt is a matrix of cell line-cell line similarity network.
The fourth file simDD.txt is a matrix of drug-drug similarity network.
The fifth file simTT.txt is a matrix of target-target similarity network which is obtained by merging cell line gene expression and PPIs.
The sixth file trans_CD_all.mat is a matrix which include known and unknown relationships between cell lines and drugs.


## **Run HNMDRP to predict associations between cell line and drug**
**************************************************************************************************

Firstly, to demonstrate HNMDRP can achieve a good performance with best ROC and PR curve, we performing LOOCV to evaluate our method on predicting known cell line-drug associations by running the following code. 
(This process may need to take a few hours.)

	source("main.R")
	
which include following code:

	transCD <- read.table('data/transCD.txt')
	simCC <- read.table('data/simCC.txt')
	simDD <- read.table('data/simDD.txt')
	simTT <- read.table('data/simTT.txt')
	transDT <- read.table('data/transDT.txt')
	trans_CD_all <- read.table('data/transCD_label_with_unknown.txt')
	decay <- 0.7
	min_sim <- 0.3

	source("LOOCV.R")
	predict_result <- LOOCV(transCD, simCC, simDD, simTT, transDT, decay, min_sim)

**************************************************************************************************

**************************************************************************************************

Secondly, to draw the ROC curve based on the prediction results of HNMDRP by running following code in R command window. 
(This process may need to take a few seconds.)

	source("plot_ROC(trans_CD_all, predict_result, 75)")
	
Specific Instructions: In this function, you can specify the drug_number to be a number, then execute this line of code and the ROC curve is displayed in the computer screen for this drug.
					   Here, 75 is the drug_number index which is determined by the Supplementary Table S2 that have 189 drugs and its corresponding index number.
					   You can choose different drug_number to observe its ROC performance.
*******************************************************************************************************************************************************************************************


## Configurations of HNMDRP
### Related configuration files

	==========================================================================================================
	| FILE NAME		|				DESCRIPTION               			|
	==========================================================================================================
	|transCD.txt	|The known cell line-drug associations are represented by adjacency 		|
	|			|matrix CD, which shows binary associations between cell line and drug.		|
	|			|1 represents cell line i are sensitive with drug j, otherwise 0.		|
	-------------------------------------------------------------------------------------------------
	|transDT.txt	|The known drug-target interactions are represented by adjacency matrix		|
	|			|DT, which shows binary associations between drug and target.			|
	|			|And 1 represents drug j has its corresponding target gene k,otherwise 0.	|
	-------------------------------------------------------------------------------------------------
    |simCC.txt		|The similarity network between cell line based on gene expression		|
	|  			|profile.									|
	-------------------------------------------------------------------------------------------------
	|simDD.txt		|The similarity between drug based on drug chemical structures.			|
	|			|       									|
	-------------------------------------------------------------------------------------------------
	|simTT.txt		|The similarity between target genes based on PPI and correlational		|
	|			|relationships.         							|
	-------------------------------------------------------------------------------------------------
	|trans_CD_all.txt	|Known and unknown associations between cell line and drug           	   	|
	|			|         									|
	-------------------------------------------------------------------------------------------------
	
## **Mainly output variables of HNMDRP**

The descriptions of output variables of HNMDRP are provided below:

	=========================================================================================
	| VARIABLE NAME	| DESCRIPTION								|
	=========================================================================================
	| predict_result|The predicted results of cell line-drug associations through leave-one	|
	|		|-out cross validation, which is used to draw ROC curve for each drug.	|
	-----------------------------------------------------------------------------------------

	
## HNMDRP for users without R licenses
For users without R licenses, we also offer Matlab codes of HNMDRP. The detailed method can be seen in **Matlab** package.

## **Contact**

Please feel free to contact us if you need any help: fzxx@mail.ustc.edu.cn

