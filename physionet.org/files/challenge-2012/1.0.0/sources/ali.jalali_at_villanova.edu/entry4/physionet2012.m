function [prob,died]=physionet2012(tm,category,val)

read_d;
ali_nat;


load net2
% load SV1R
% died=size(test_in',1)
% prob=1;
death=sim(net2,test_in');
if (death>0.1859) || (risk_prob>0.81)
    died=1;
else
    died=0;
end

prob=death;
if prob>1
    prob=0.95;
end