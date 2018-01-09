% HNMDRP (Heterogeneous network-based method for drug response prediction):
% input: five sub-network which include 
% output: prediction of cell line-drug association
function [transMat12_predict,transMat23_predict] = HNMDRP(transMat12, simMat1, simMat2, simMat3, transMat23,decay,min_sim)

    max_sim = 0.99;
    thr=1e-4;
%% filter ddMatrix
    simMat1(simMat1 > max_sim) = max_sim;
    simMat1(simMat1 < min_sim) = 0;
    tmpEye = eye(size(simMat1));
    simMat1 = simMat1 + tmpEye;
    simMat1(simMat1 > 1) = 1;

%% filter rrMatrix
    simMat2(simMat2 > max_sim) = max_sim;
    simMat2(simMat2 < min_sim) = 0;
    tmpEye = eye(size(simMat2));
    simMat2 = simMat2 + tmpEye;
    simMat2(simMat2 > 1) = 1;

%% filter ttMatrix
    simMat3(simMat3 > max_sim) = max_sim;
    simMat3(simMat3 < min_sim) = 0;
    tmpEye = eye(size(simMat3));
    simMat3 = simMat3 + tmpEye;
    simMat3(simMat3 > 1) = 1;

    RR2 = simMat2 * transMat23 * simMat3 * transMat23';
    RR2 = RR2 ./ ((sum(RR2,2)*sum(RR2,1)).^0.5 + 0.001);
    %
    RR1 = transMat12' * simMat1 * transMat12 * simMat2;
    RR1 = RR1 ./ ((sum(RR1,2) * sum(RR1,1)) .^ 0.5 + 0.001);
    %
    DR2 = transMat12 * RR2;
    RT2 = RR1 * transMat23;
    %
    DR1 = transMat12;
    RT1 = transMat23;
    %
    
%% main function
    i=0;error1=1;error2=1;
    while(i < 30 & (error1 > thr || error2 > thr))
        i=i+1;
        
        error1 = sum(sum(abs(DR2 - DR1)));
        error2 = sum(sum(abs(RT2 - RT1)));
        
        DR1 = DR2;
        RT1 = RT2;
        %
        RR2 = simMat2 * RT1 * simMat3 * RT1';
        RR2 = RR2 ./ ((sum(RR2,2) * sum(RR2,1)) .^ 0.5 + 0.001);
%         RR1 = normalization(RR1);
        %
        RR1 = DR1' * simMat1 * DR1 * simMat2;
        RR1 = RR1 ./ ((sum(RR1,2) * sum(RR1,1)) .^ 0.5 + 0.001);
%         RR2 = normalization(RR2);
        %
        DR2 = decay * DR1 * RR2 + (1 - decay) * transMat12;
        RT2 = decay * RR1 * RT1 + (1 - decay) * transMat23;
        %
    end
transMat12_predict = DR2;
transMat23_predict = RT2;
end
