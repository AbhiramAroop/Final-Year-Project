measurements={'Albumin','ALP','ALT','AST','Bilirubin','BUN','Cholesterol',...
    'Creatinine','DiasABP','FiO2','GCS','Glucose','HCO3','HCT','HR','K',...
    'Lactate','Mg','MAP','MechVent','Na','NIDiasABP','NIMAP','NISysABP',...
    'PaCO2','PaO2','pH','Platelets','RespRate','SaO2','SysABP','Temp','TropI',...
    'TropT','Urine','WBC'};

alb=[0 0];
alp=[0 0];
alt=[0 0];
ast=[0 0];
bil=[0 0];
bun=[0 0];
chol=[0 0];
crea=[0 0];
dbp=[0 0];
fio2=[0 0];
gcs=[0 0];
glu=[0 0];
hco=[0 0];
hct=[0 0];
hr=[0 0];
k=[0 0];
lac=[0 0];
mg=[0 0];
map=[0 0];
mvent=[0 0];
na=[0 0];
ndbp=[0 0];
nmap=[0 0];
nsbp=[0 0];
paco2=[0 0];
pao2=[0 0];
ph=[0 0];
plat=[0 0];
resp=[0 0];
sao2=[0 0];
sbp=[0 0];
temp=[0 0];
troi=[0 0];
trot=[0 0];
uri=[0 0];
wbc=[0 0];

measure=[alb alp alt ast bil bun chol crea dbp fio2 gcs glu hco hct hr k  lac mg map mvent...
    na ndbp nmap nsbp paco2 pao2 ph plat resp sao2 sbp temp troi trot uri wbc];

for j=1:length(measurements)
    s=2*(j-1)+1;
    pp{j}=measure(s:s+1);
end

clear s

oo=pp;
dat=val;
time_string=tm;
ptdata=category;

for i=1:length(time_string)
    
    c=char(time_string(i));
    h=str2num(c(1:2));
    m=str2num(c(4:5));
    
    for j=1:length(measurements)
        
        if strcmp(ptdata(i),measurements(j))
            
            xx=oo{j};
            xx=[xx;60*h+m dat(i)];
            oo{j}=xx;
            
        end
        
    end
    
end

o=oo';
pd=cell2struct(o,measurements,1);
patient_data=pd;

clear oo o xx pd
clear dat txtdata ptdata
clear time_string

% 'Age','Sex','RecordID',
patients_B=patient_data;
% save patient_data patient_data
clear i j k h m

dum=[0 0];
a=patients_B.SysABP;
b=patients_B.DiasABP;
if (size(a,1)>1) && (size(b,1)>1)
    a=a(2:end,:);
    b=b(2:end,:);
    if size(a,1)==size(b,1)
        for j=1:size(a,1)
            for k=1:size(b,1)
                if a(j,1)==b(k,1)
                    dum=[dum;a(j,1) a(j,2)-b(k,2)];
                end
            end
        end
    else
        m=min(length(a),length(b));
        for j=1:m
            for k=1:m
                if a(j,1)==b(k,1)
                    dum=[dum;a(j,1) a(j,2)-b(k,2)];
                end
            end
        end
    end
end
patients_B.PP=dum;
clear a b
    
clear i j k m dum pp
   
a=val;
p=category;
for j=1:length(p)
    
    if strcmp(p(j),'Age')
        patients_B.Age=a(j);
    end
    if strcmp(p(j),'RecordID')
        patients_B.ID=a(j);
    end
    
end
    

clear i a p