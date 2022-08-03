function [prob,died]=physionet2012(tm,category,val)

read_d;
ali_nat;

load tr_p
load tr_r
death=eval(tr_p,test_in,12);
if (strcmp(death,'HDeath')) || (risk_prob>0.6)
    died=1;
else
    died=0;
end
prob1=eval(tr_r,test_in,12);
prob2=risk_prob;
if prob2>1
    prob2=0.95;
end
prob=max(prob1,prob2);

