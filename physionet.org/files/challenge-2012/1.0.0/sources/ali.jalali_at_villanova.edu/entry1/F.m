%% Lung related

fio_alarm=zeros(1,1);
fio_risk=zeros(1,1);
vent_risk=zeros(1,1);
vent_brain=zeros(1,1);
pao2_alarm=zeros(1,1);
% pao2_vari=zeros(1,1);
pao2_risk=zeros(1,1);
resp_alarm=zeros(1,1);
resp_risk=zeros(1,1);
sao2_alarm=zeros(1,1);
sao2_risk=zeros(1,1);
sao2_acute=zeros(1,1);
pco2_alarm=zeros(1,1);
pco2_risk=zeros(1,1);
pco2_acute=zeros(1,1);

for i=1:1
    
    a=patients_B.FiO2;
    if size(a,1)>1
       fio_alarm(i)=length(find(a(2:end,2)>0.7));
       fio_risk(i)=~isinf(1/fio_alarm(i));
    end
    
end

clear i a

for i=1:1
    
    a=patients_B.MechVent;
    if size(a,1)>1
        t=a(end,1);
        vent_risk(i)=floor(t/1440);
        if  vent_risk(i)>1
            vent_brain(i)=1;
        end
    end
    
end

clear i t a

for i=1:1
    
    a=patients_B.PaO2;
    if size(a,1)>1
        dd=find(a(2:end,2)>300);
        ddd=find(a(2:end,2)<60);
        pao2_alarm(i)=length(dd)+length(ddd);
        pao2_risk(i)=~isinf(1/pao2_alarm(i));
    end
    
end

clear i dd ddd a

for i=1:1
    
    a=patients_B.RespRate;
    if size(a,1)>1
        dd=find(a(2:end,2)>30);
        ddd=find(a(2:end,2)<6);
        resp_alarm(i)=length(dd)+length(ddd);
        resp_risk(i)=~isinf(1/resp_alarm(i));
    end
    
end

clear i dd ddd a

for i=1:1
    
    a=patients_B.SaO2;
    b=0;
    if size(a,1)>1
        dd=find(a(2:end,2)<80);
        sao2_alarm(i)=length(dd);
        sao2_risk(i)=~isinf(1/sao2_alarm(i));
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
            if t>240
                b=b+1;
            end
            t=0;
            j=j+1;
        end
    end
    sao2_acute(i)=b;
    clear dd a
    
end

clear i b j t

for i=1:1
    
    a=patients_B.PaCO2;
    b=0;
    c=0;
    if size(a,1)>1
        dd=find(a(2:end,2)>70);
        ddd=find(a(2:end,2)<25);
        pco2_alarm(i)=length(dd)+length(ddd);
        pco2_risk(i)=~isinf(1/pco2_alarm(i));
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
    pco2_acute(i)=b+c;
    clear dd ddd map
    
end

clear i j b c dd ddd t a
F1=[fio_alarm fio_risk vent_risk vent_brain resp_alarm resp_risk sao2_alarm ...
    sao2_risk pao2_alarm pao2_risk pco2_alarm pco2_risk pco2_acute];
F_F=[fio_risk vent_risk resp_risk sao2_risk pao2_risk pco2_risk];
clear fio_alarm fio_risk vent_risk vent_brain resp_alarm resp_risk sao2_alarm ...
    sao2_risk sao2_acute pao2_alarm pao2_risk pco2_alarm pco2_risk pco2_acute 