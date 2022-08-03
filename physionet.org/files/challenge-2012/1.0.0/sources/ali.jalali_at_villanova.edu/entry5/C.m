%% Blood pressure related

dbp_alarm=zeros(1,1);
dbp_risk=zeros(1,1);
dbp_stroke=zeros(1,1);
sbp_alarm=zeros(1,1);
sbp_risk=zeros(1,1);
sbp_stroke=zeros(1,1);
map_alarm=zeros(1,1);
map_risk=zeros(1,1);
map_stroke=zeros(1,1);

for i=1:1
    
    dbp=patients_B.DiasABP;
    b=0;
    c=0;
    if size(dbp,1)>1
        dd=find(dbp(2:end,2)>120);
        ddd=find(dbp(2:end,2)<30);
        dbp_alarm(i)=length(dd)+length(ddd);
        dbp_risk(i)=~isinf(1/dbp_alarm(i));
        j=2;
        while j<length(dd)
            t=dbp(dd(j-1),1);
            while dd(j)==dd(j-1)+1
                t=dbp(dd(j),1)+t;
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
            t=dbp(ddd(j-1),1);
            while ddd(j)==ddd(j-1)+1
                t=dbp(ddd(j),1)+t;
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
    dbp_stroke(i)=b+c;
    clear dd ddd dbp
    
end

clear i j t b

for i=1:1
    
    sbp=patients_B.SysABP;
    b=0;
    c=0;
    if size(sbp,1)>1
        dd=find(sbp(2:end,2)>200);
        ddd=find(sbp(2:end,2)<60);
        sbp_alarm(i)=length(dd)+length(ddd);
        sbp_risk(i)=~isinf(1/sbp_alarm(i));
        j=2;
        while j<length(dd)
            t=sbp(dd(j-1),1);
            while dd(j)==dd(j-1)+1
                t=sbp(dd(j),1)+t;
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
            t=sbp(ddd(j-1),1);
            while ddd(j)==ddd(j-1)+1
                t=sbp(ddd(j),1)+t;
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
    sbp_stroke(i)=b+c;
    clear dd ddd sbp
    
end

clear i j c b t

for i=1:1
    
    map=patients_B.MAP;
    b=0;
    c=0;
    if size(map,1)>1
        dd=find(map(2:end,2)>150);
        ddd=find(map(2:end,2)<50);
        map_alarm(i)=length(dd)+length(ddd);
        map_risk(i)=~isinf(1/map_alarm(i));
        j=2;
        while j<length(dd)
            t=map(dd(j-1),1);
            while dd(j)==dd(j-1)+1
                t=map(dd(j),1)+t;
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
            t=map(ddd(j-1),1);
            while ddd(j)==ddd(j-1)+1
                t=map(ddd(j),1)+t;
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
    else
        a=patients_B.NIMAP;
        if size(a,1)>1
            dd=find(a(2:end,2)>150);
            ddd=find(a(2:end,2)<50);
            map_alarm(i)=length(dd)+length(ddd);
            map_risk(i)=~isinf(1/map_alarm(i));
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
        map_stroke(i)=b+c;
        clear dd ddd map
    end
    clear a
    
end

clear i j c b t dd ddd
C1=[dbp_alarm dbp_risk sbp_alarm sbp_risk sbp_stroke map_alarm map_risk map_stroke];
C_F=[dbp_risk sbp_risk map_risk];
clear dbp_alarm dbp_risk sbp_alarm sbp_risk sbp_stroke map_alarm map_risk map_stroke