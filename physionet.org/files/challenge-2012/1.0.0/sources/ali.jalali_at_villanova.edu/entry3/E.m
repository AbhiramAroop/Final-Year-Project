%% Neuro related

gcs_alarm=zeros(1,1);
gcs_risk=zeros(1,1);
lac_alarm=zeros(1,1);
lac_risk=zeros(1,1);
na_alarm=zeros(1,1);
na_risk=zeros(1,1);
glu_alarm=zeros(1,1);
glu_risk=zeros(1,1);
glu_nervous=zeros(1,1);

for i=1:1
    
    a=patients_B.GCS;
    if size(a,1)>1
       gcs_alarm(i)=length(find(a(2:end,2)<5));
       gcs_risk(i)=~isinf(1/gcs_alarm(i));
    end
    
end

clear i a

for i=1:1
    
    a=patients_B.Lactate;
    if size(a,1)>1
       lac_alarm(i)=length(find(a(2:end,2)>4));
       lac_risk(i)=~isinf(1/lac_alarm(i));
    end
    
end

clear i a

for i=1:1
    
    a=patients_B.Na;
    if size(a,1)>1
       na_alarm(i)=length(find(a(2:end,2)<5));
       na_risk(i)=~isinf(1/na_alarm(i));
    end
    
end

clear i a

for i=1:1
    
    a=patients_B.Glucose;
    b=0;
    c=0;
    if size(a,1)>1
        dd=find(a(2:end,2)>150);
        ddd=find(a(2:end,2)<60);
        glu_alarm(i)=length(dd)+length(ddd);
        glu_risk(i)=~isinf(1/glu_alarm(i));
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
    glu_nervous(i)=b+c;
    clear dd ddd map
    
end

clear a i j t c b
E1=[gcs_alarm gcs_risk lac_alarm lac_risk na_alarm na_risk glu_alarm ...
    glu_risk glu_nervous];
E_F=[gcs_risk lac_risk na_risk glu_risk];
clear gcs_alarm gcs_risk lac_alarm lac_risk na_alarm na_risk glu_alarm ...
    glu_risk glu_nervous