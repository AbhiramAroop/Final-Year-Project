% Renal Related

% renal=[crea_alarm crea_risk bun_alarm bun_risk k_r_alarm k_r_risk lac_alarm lac_risk];
renal_failure=[crea_risk bun_risk k_r_risk lac_risk];
renal_alarm=[crea_alarm bun_alarm k_r_alarm lac_alarm];
% s=sum(renal_failure);
% fail_renal=0;
% failure_renal=0;
% m=0;
% n=0;
% h=0;
% a=patient.BUN;
% if size(a,1)==1
%     m=1;
% end
% clear a
% a=patient.K;
% if size(a,1)==1
%     n=1;
% end
% clear a
% a=patient.Creatinine;
% if size(a,1)==1
%     h=1;
% end
% if s>(3-m-n-h)
%     fail_renal=1;
% end
% if s>0
%     failure_renal=1;
% end
% clear s m n h