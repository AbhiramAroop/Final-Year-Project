crea_alarm=zeros(1,1);
crea_risk=zeros(1,1);
bun_alarm=zeros(1,1);
bun_risk=zeros(1,1);
k_r_alarm=zeros(1,1);
k_r_risk=zeros(1,1);

for i=1:1
    
    a=patients_B.Creatinine;
    if size(a,1)>1
       crea_alarm(i)=length(find(a(2:end,2)>2.5));
       crea_risk(i)=~isinf(1/crea_alarm(i));
    end
    
end

for i=1:1
    
    a=patients_B.Bilirubin;
    if size(a,1)>1
       bun_alarm(i)=length(find(a(2:end,2)>50));
       bun_risk(i)=~isinf(1/bun_alarm(i));
    end
    
end

for i=1:1
    
    a=patients_B.K;
    if size(a,1)>1
       k_r_alarm(i)=length(find(a(2:end,2)>8));
       k_r_risk(i)=~isinf(1/k_r_alarm(i));
    end
    
end

clear i a
B1=[crea_alarm crea_risk bun_alarm bun_risk k_r_alarm k_r_risk];
B_F=[crea_risk bun_risk k_r_risk];
clear crea_alarm crea_risk bun_alarm bun_risk k_r_alarm k_r_risk