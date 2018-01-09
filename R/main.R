transCD <- read.table('transCD.txt')
simCC <- read.table('simCC.txt')
simDD <- read.table('simDD.txt')
simTT <- read.table('imTT.txt')
transDT <- read.table('transDT.txt')
trans_CD_all <- read.table('transCD_label_with_unknown.txt')

decay <- 0.7
min_sim <- 0.3

source("LOOCV.R")
predict_result <- LOOCV(transCD, simCC, simDD, simTT, transDT, decay, min_sim)