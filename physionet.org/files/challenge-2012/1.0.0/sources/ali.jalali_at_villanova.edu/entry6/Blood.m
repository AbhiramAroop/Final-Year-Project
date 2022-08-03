% Blood Related

blood=[plat_alarm plat_risk hct_alarm hct_risk wbc_b_alarm wbc_b_risk];
blood_failure=[plat_risk hct_risk wbc_b_risk];
blood_alarm=[plat_alarm hct_alarm wbc_b_alarm];
% s=sum(blood_failure);
% fail_blood=0;
% failure_blood=0;
% m=0;
% n=0;
% a=patient.Platelets;
% if size(a,1)==1
%     m=1;
% end
% clear a
% a=patient.HCT;
% if size(a,1)==1
%     n=1;
% end
% clear a
% if s>(2-m-n)
%     fail_blood=1;
% end
% if s>0
%     failure_blood=1;
% end
% clear s m n