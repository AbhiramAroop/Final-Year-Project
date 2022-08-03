% Neuro Related

neuro=[gcs_alarm gcs_risk glu_alarm glu_risk map_alarm map_risk sao2_alarm sao2_risk];
neuro_failure=[gcs_risk glu_risk sao2_risk map_risk];
neuro_alarm=[gcs_alarm glu_alarm sao2_alarm map_alarm];
% neuro_acute=[sao2_acute glu_acute];
% s=sum(neuro_failure);
% fail_neuro=0;
% failure_neuro=0;
% m=0;
% n=0;
% h=0;
% a=patient.GCS;
% if size(a,1)==1
%     m=1;
% end
% clear a
% a=patient.Glucose;
% if size(a,1)==1
%     n=1;
% end
% clear a
% a=patient.SaO2;
% if size(a,1)==1
%     h=1;
% end
% clear a
% if s>(3-m-n-h)
%     fail_neuro=1;
% end
% if s>0
%     failure_neuro=1;
% end
% clear s m n h