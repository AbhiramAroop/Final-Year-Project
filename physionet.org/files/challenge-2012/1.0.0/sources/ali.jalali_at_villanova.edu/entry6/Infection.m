% Infection Related

infection=[wbc_i_alarm wbc_i_risk hco_alarm hco_risk];
infection_failure=[hco_risk wbc_i_risk];
infection_alarm=[wbc_i_alarm hco_alarm];
% s=sum(infection_failure);
% fail_infection=0;
% failure_infection=0;
% if s>1
%     fail_infection=1;
% end
% if s>0
%     failure_infection=1;
% end
% clear s