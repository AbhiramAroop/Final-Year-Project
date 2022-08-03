function [prob,died]=physionet2012(tm,category,val)

read_d;
ali_nat;


load net2
load net1
load tr_p
load tr_r

death1=sim(net1,orr');
if (death1>0.17) || (risk_prob>0.7)
    died1=1;
else
    died1=0;
end

prob1=death1;
if prob1>1
    prob1=0.95;
end

death2=sim(net2,test_in2');
if (death2>0.1859) || (risk_prob>0.81)
    died2=1;
else
    died2=0;
end

prob2=death2;
if prob2>1
    prob2=0.95;
end


death3=eval(tr_p,test_in,12);
if (strcmp(death3,'HDeath')) || (risk_prob>0.6)
    died3=1;
else
    died3=0;
end
prob3=eval(tr_r,test_inT,12);
prob4=risk_prob;
if prob4>1
    prob4=0.95;
end

dieee=died1+died2+died3;
if dieee>1.5
    died=1;
else
    died=0;
end
prob=(prob1+prob2+prob3+prob4)/4;
