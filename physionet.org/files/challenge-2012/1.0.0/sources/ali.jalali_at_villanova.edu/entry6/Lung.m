% Lung Related

% lung=[fio_alarm fio_risk vent_risk vent_brain resp_alarm resp_risk sao2_alarm ...
%     sao2_risk pao2_alarm pao2_risk pco2_alarm pco2_risk ph_alarm ph_risk];
lung=[fio_alarm fio_risk resp_alarm resp_risk sao2_alarm sao2_risk ...
    pao2_alarm pao2_risk pco2_alarm pco2_risk ph_alarm ph_risk];
% lung_failure=[fio_risk vent_risk resp_risk sao2_risk pao2_risk pco2_risk ph_risk];
lung_failure=[fio_risk resp_risk sao2_risk pao2_risk pco2_risk ph_risk];
% lung_acute=[sao2_acute ph_acute vent_brain];
% lung_alarm=[fio_alarm resp_alarm sao2_alarm pao2_alarm pco2_alarm ph_alarm];
lung_alarm=[fio_alarm resp_alarm sao2_alarm pao2_alarm pco2_alarm ph_alarm];

% s=sum(lung_failure);
% fail_lung=0;
% failure_lung=0;
% m=0;
% n=0;
% h=0;
% u=0;
% a=patient.SaO2;
% if size(a,1)==1
%     m=1;
% end
% clear a
% a=patient.PaCO2;
% if size(a,1)==1
%     n=1;
% end
% clear a
% a=patient.RespRate;
% if size(a,1)==1
%     h=1;
% end
% clear a
% a=patient.pH;
% if size(a,1)==1
%     u=1;
% end
% clear a
% if s>(5-m-n-h-u)
%     fail_lung=1;
% end
% if s>0
%     failure_lung=1;
% end
% clear s m n h u