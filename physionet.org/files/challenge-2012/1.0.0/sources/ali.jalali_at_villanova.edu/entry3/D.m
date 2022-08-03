%% Heart related

hr_alarm=zeros(1,1);
hr_risk=zeros(1,1);
k_h_alarm=zeros(1,1);
k_h_risk=zeros(1,1);
mg_alarm=zeros(1,1);
mg_risk=zeros(1,1);
hco_alarm=zeros(1,1);
hco_risk=zeros(1,1);
ph_alarm=zeros(1,1);
ph_risk=zeros(1,1);
ph_acute=zeros(1,1);

for i=1:1
    
    a=patients_B.HR;
    if size(a,1)>1
        dd=find(a(2:end,2)>150);
        ddd=find(a(2:end,2)<50);
        hr_alarm(i)=length(dd)+length(ddd);
        hr_risk(i)=~isinf(1/hr_alarm(i));
    end
    clear dd ddd
    
end

for i=1:1
    
    a=patients_B.K;
    if size(a,1)>1
       k_h_alarm(i)=length(find(a(2:end,2)<2));
       k_h_risk(i)=~isinf(1/k_h_alarm(i));
    end
    
end

for i=1:1
    
    a=patients_B.Mg;
    if size(a,1)>1
       mg_alarm(i)=length(find(a(2:end,2)>15));
       mg_risk(i)=~isinf(1/mg_alarm(i));
    end
    
end

clear i a

for i=1:1
    
    a=patients_B.HCO3;
    if size(a,1)>1
       hco_alarm(i)=length(find(a(2:end,2)<10));
       hco_risk(i)=~isinf(1/hco_alarm(i));
    end
    
end

clear i a

for i=1:1
    
    a=patients_B.pH;
    b=0;
    c=0;
    if size(a,1)>1
        dd=find(a(2:end,2)>7.6);
        ddd=find(a(2:end,2)<7.1);
        ph_alarm(i)=length(dd)+length(ddd);
        ph_risk(i)=~isinf(1/ph_alarm(i));
        j=2;
        while j<length(dd)
            t=a(dd(j-1),1);
            while dd(j)==dd(j-1)+1
                t=a(dd(j),1)+t;
                j=j+1;
                if j==length(dd)
                    break
                end
            end
            if t>360
                b=b+1;
            end
            t=0;
            j=j+1;
        end
        j=2;
        while j<length(ddd)
            t=a(ddd(j-1),1);
            while ddd(j)==ddd(j-1)+1
                t=a(ddd(j),1)+t;
                j=j+1;
                if j==length(ddd)
                    break
                end
            end
            if t>360
                c=c+1;
            end
            t=0;
            j=j+1;
        end
    end
    ph_acute(i)=b+c;
    clear dd ddd map
    
end

clear i j b c dd ddd t a
D1=[hr_alarm hr_risk k_h_alarm k_h_risk mg_alarm mg_risk hco_alarm hco_risk ...
    ph_alarm ph_risk];
D_F=[hr_risk k_h_risk mg_risk hco_risk ph_risk];
clear hr_alarm hr_risk k_h_alarm k_h_risk mg_alarm mg_risk hco_alarm hco_risk ...
    ph_alarm ph_risk