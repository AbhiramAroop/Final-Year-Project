function [prob,died]=physionet2012(tm,category,val)

patient=read_icu(tm,category,val);
risk_vinay;
type=patient.ICUType;

load t5_ccu
load t5_csru
load t5_micu
load t5_sicu

if type==1
    tfit5=eval(t5_ccu,icc1);
elseif type==2
    tfit5=eval(t5_csru,icc1);
elseif type==3
    tfit5=eval(t5_micu,icc1);
else
    tfit5=eval(t5_sicu,icc1);
end

% death=eval(tr_p,test_in,12);
if (strcmp(tfit5,'HDeath')) 
    died=1;
else
    died=0;
end

read_d;
ali_nat;
load net2
load net1
load tr_p
load tr_r

prob1=sim(net1,orr');
prob2=sim(net2,test_in2');
prob3=eval(tr_r,test_inT,12);
prob4=risk_prob;
% prob1=eval(tr_r,test_in,12);
% prob2=risk_prob;
% if prob2>1
%     prob2=0.95;
% end
prob=(prob1+prob2+prob3+prob4)/4;

end
