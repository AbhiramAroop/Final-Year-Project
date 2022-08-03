%% Blood related

hct_alarm=zeros(1,1);
hct_risk=zeros(1,1);
wbc_alarm=zeros(1,1);
wbc_risk=zeros(1,1);
plat_alarm=zeros(1,1);
plat_risk=zeros(1,1);
temp_alarm=zeros(1,1);
temp_risk=zeros(1,1);


    
    a=patients_B.HCT;
    if size(a,1)>1
       hct_alarm=length(find(a(2:end,2)<20));
       hct_risk=~isinf(1/hct_alarm);
    end
    

clear i a

for i=1:1
    
    a=patients_B.Platelets;
    if size(a,1)>1
        dd=find(a(2:end,2)>1000);
        ddd=find(a(2:end,2)<50);
        plat_alarm(i)=length(dd)+length(ddd);
        plat_risk(i)=~isinf(1/plat_alarm(i));
    end
    
end

clear i a dd ddd

for i=1:1
    
    a=patients_B.WBC;
    if size(a,1)>1
        dd=find(a(2:end,2)>25000);
        ddd=find(a(2:end,2)<3);
        wbc_alarm(i)=length(dd)+length(ddd);
        wbc_risk(i)=~isinf(1/wbc_alarm(i));
    end
    
end

clear i a dd ddd

for i=1:1
    
    a=patients_B.Temp;
    if size(a,1)>1
        dd=find(a(2:end,2)>40);
        ddd=find(a(2:end,2)<33);
        temp_alarm(i)=length(dd)+length(ddd);
        temp_risk(i)=~isinf(1/temp_alarm(i));
    end
    
end

clear i a dd ddd
G1=[plat_alarm plat_risk hct_alarm hct_risk wbc_alarm wbc_risk temp_alarm temp_risk];
G_F=[plat_risk hct_risk wbc_risk temp_risk];
clear plat_alarm plat_risk hct_alarm hct_risk wbc_alarm wbc_risk temp_alarm temp_risk