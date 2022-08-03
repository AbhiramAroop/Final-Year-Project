function [prob,died]=physionet2012(tm,category,val)

read_d;
ali_nat;
% died=size(test_in,1);
% prob=size(test_in,2);
load net1
% load SV1R
death=sim(net1,orr');
if (death>0.17) || (risk_prob>0.7)
    died=1;
else
    died=0;
end

prob=death;
if prob>1
    prob=0.95;
end