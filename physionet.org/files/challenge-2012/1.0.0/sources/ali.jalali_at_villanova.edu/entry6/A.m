%% Liver related

alb_alarm=zeros(1,1);
alb_risk=zeros(1,1);
bili_alarm=zeros(1,1);
bili_risk=zeros(1,1);

for i=1:1
    
    a=patients_B.Albumin;
    if size(a,1)>1
       alb_alarm(i)=length(find(a(2:end,2)<2));
       alb_risk(i)=~isinf(1/alb_alarm(i));
    end
    
end

for i=1:1
    
    a=patients_B.Bilirubin;
    if size(a,1)>1
       bili_alarm(i)=length(find(a(2:end,2)>15));
       bili_risk(i)=~isinf(1/bili_alarm(i));
    end
    
end

clear i a
A1=[alb_alarm alb_risk bili_alarm bili_risk];
A_F=[alb_risk bili_risk];
clear alb_alarm alb_risk bili_alarm bili_risk