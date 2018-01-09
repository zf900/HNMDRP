transCD <- read.table('data/transCD.txt')
simCC <- read.table('data/simCC.txt')
simDD <- read.table('data/simDD.txt')
simTT <- read.table('data/imTT.txt')
transDT <- read.table('data/transDT.txt')
trans_CD_all <- read.table('data/transCD_label_with_unknown.txt')

decay <- 0.7
min_sim <- 0.3

source("LOOCV.R")
predict_result <- LOOCV(transCD, simCC, simDD, simTT, transDT, decay, min_sim)