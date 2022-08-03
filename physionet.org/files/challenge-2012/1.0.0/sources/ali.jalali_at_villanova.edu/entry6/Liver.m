% Liver Related

liver=[alb_alarm alb_risk bili_alarm bili_risk];
liver_failure=[alb_risk bili_risk];
liver_alarm=[alb_alarm bili_alarm];
% s=sum(liver_failure);
% fail_liver=0;
% failure_liver=0;
% m=0;
% n=0;
% a=patient.Albumin;
% if size(a,1)==1
%     m=1;
% end
% clear a
% a=patient.Bilirubin;
% if size(a,1)==1
%     n=1;
% end
% clear a
% if (s==(2-m) || s==(2-n))    
%     fail_liver=1;
% end
% if s>0
%     failure_liver=1;
% end
% clear s m n