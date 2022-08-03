function [prob,died]=physionet2012(tm,category,val)

read_d;
ali_nat;
% died=size(test_in,1);
% prob=size(test_in,2);

load SV1P
load SV1R
death=svmclassify(SV1P,test_in);
if (strcmp(death,'HDeath')) || (risk_prob>0.6)
    died=1;
else
    died=0;
end

prob=risk_prob;
if prob>1
    prob=0.95;
end