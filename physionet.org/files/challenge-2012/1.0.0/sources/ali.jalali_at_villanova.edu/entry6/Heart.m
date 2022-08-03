% Heart Related

if map_alarm==0
    map_alarm=nmap_alarm;
    map_risk=nmap_risk;
end
if dbp_alarm==0
    dbp_alarm=ndbp_alarm;
    dbp_risk=ndbp_risk;
end
if sbp_alarm==0
    sbp_alarm=nsbp_alarm;
    sbp_risk=nsbp_risk;
end
heart=[hr_alarm hr_risk k_h_alarm k_h_risk mg_alarm mg_risk hco_alarm hco_risk ...
    ph_alarm ph_risk map_risk map_alarm sbp_risk sbp_alarm dbp_risk dbp_alarm ...
    lac_risk lac_alarm sao2_risk sao2_alarm];
heart_failure=[hr_risk k_h_risk mg_risk hco_risk ph_risk dbp_risk sbp_risk map_risk ...
    lac_risk sao2_risk];
% heart_acute=[map_acute sbp_acute dbp_acute ph_acute sao2_acute];
heart_alarm=[hr_alarm k_h_alarm mg_alarm hco_alarm ph_alarm dbp_alarm sbp_alarm map_alarm ...
    lac_alarm sao2_alarm];
% s=sum(heart_failure);
% fail_heart=0;
% failure_heart=0;
% m=0;
% n=0;
% k=0;
% h=0;
% u=0;
% t=0;
% 
% a=patient.HR;
% if size(a,1)==1
%     m=1;
% end
% clear a
% a=patient.Mg;
% if size(a,1)==1
%     n=1;
% end
% clear a
% a=patient.HCO3;
% if size(a,1)==1
%     k=1;
% end
% clear a
% a=patient.K;
% if size(a,1)==1
%     h=1;
% end
% clear a
% a=patient.Lactate;
% if size(a,1)==1
%     u=1;
% end
% clear a
% a=patient.SaO2;
% if size(a,1)==1
%     t=1;
% end
% clear a
% if s>(9-m-n-k-h-u-t)
%     fail_heart=1;
% end
% if s>0
%     failure_heart=1;
% end
% clear s m n k h u t