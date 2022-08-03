% Finding alarms in hemodynamic measurements

alb_alarm=[0;0];
alb_risk=[0;0];
bili_alarm=[0;0];
bili_risk=[0;0];
bun_alarm=[0;0];
bun_risk=[0;0];
crea_alarm=[0;0];
crea_risk=[0;0];
dbp_alarm=[0;0];
dbp_risk=[0;0];
dbp_acute=[0;0];
fio_alarm=[0;0];
fio_risk=[0;0];
gcs_alarm=[0;0];
gcs_risk=[0;0];
glu_alarm=[0;0];
glu_risk=[0;0];
glu_acute=[0;0];
hco_alarm=[0;0];
hco_risk=[0;0];
hct_alarm=[0;0];
hct_risk=[0;0];
hr_alarm=[0;0];
hr_risk=[0;0];
k_h_alarm=[0;0];
k_h_risk=[0;0];
k_r_alarm=[0;0];
k_r_risk=[0;0];
lac_alarm=[0;0];
lac_risk=[0;0];
mg_alarm=[0;0];
mg_risk=[0;0];
map_alarm=[0;0];
map_risk=[0;0];
map_acute=[0;0];
nmap_alarm=[0;0];
nmap_risk=[0;0];
nmap_acute=[0;0];
ndbp_alarm=[0;0];
ndbp_risk=[0;0];
ndbp_acute=[0;0];
pao2_alarm=[0;0];
pao2_risk=[0;0];
pco2_alarm=[0;0];
pco2_risk=[0;0];
pco2_acute=[0;0];
ph_alarm=[0;0];
ph_risk=[0;0];
ph_acute=[0;0];
plat_alarm=[0;0];
plat_risk=[0;0];
resp_alarm=[0;0];
resp_risk=[0;0];
sao2_alarm=[0;0];
sao2_risk=[0;0];
sao2_acute=[0;0];
sbp_alarm=[0;0];
sbp_risk=[0;0];
sbp_acute=[0;0];
nsbp_alarm=[0;0];
nsbp_risk=[0;0];
nsbp_acute=[0;0];
vent_risk=[0;0];
vent_brain=[0;0];
wbc_b_alarm=[0;0];
wbc_b_risk=[0;0];
wbc_i_alarm=[0;0];
wbc_i_risk=[0;0];


a=patient.Albumin;
if size(a,1)>1
    [alb_alarm,alb_risk]=hemoalarm(a,2,0);
end
clear a

a=patient.Bilirubin;
if size(a,1)>1
    [bili_alarm,bili_risk]=hemoalarm(a,0,15);
end
clear a

a=patient.BUN;
if size(a,1)>1
    [bun_alarm,bun_risk]=hemoalarm(a,0,50);
end
clear a

a=patient.Creatinine;
if size(a,1)>1
    [crea_alarm,crea_risk]=hemoalarm(a,0,2.5);
end
clear a

a=patient.DiasABP;
if size(a,1)>1
    [dbp_alarm,dbp_risk]=bpalarm(a,30,50,105,120);
    dbp_acute=hemoacute(a,30,120,360);
end
clear a

a=patient.FiO2;
if size(a,1)>1
    [fio_alarm,fio_risk]=hemoalarm(a,0,0.7);
end
clear a

a=patient.GCS;
if size(a,1)>1
    [gcs_alarm,gcs_risk]=hemoalarm(a,5,0);
end
clear a

a=patient.Glucose;
if size(a,1)>1
    [glu_alarm,glu_risk]=hemoalarm(a,60,150);
    glu_acute=hemoacute(a,60,150,360);
end
clear a

a=patient.HCO3;
if size(a,1)>1
    [hco_alarm,hco_risk]=hemoalarm(a,10,0);
end
clear a

a=patient.HR;
if size(a,1)>1
    [hr_alarm,hr_risk]=bpalarm(a,50,58,130,150);
end
clear a

a=patient.HCT;
if size(a,1)>1
    [hct_alarm,hct_risk]=hemoalarm(a,20,0);
end
clear a

a=patient.K;
if size(a,1)>1
    [k_r_alarm,k_r_risk]=hemoalarm(a,0,8);
    [k_h_alarm,k_h_risk]=hemoalarm(a,2,0);
end
clear a

a=patient.Lactate;
if size(a,1)>1
    [lac_alarm,lac_risk]=hemoalarm(a,0,4);
end
clear a

a=patient.MAP;
if size(a,1)>1
    [map_alarm,map_risk]=bpalarm(a,50,70,125,150);
%     map_acute=hemoacute(a,50,150,360);
end
clear a

a=patient.NIMAP;
if size(a,1)>1
    [nmap_alarm,nmap_risk]=bpalarm(a,50,70,125,150);
%     nmap_acute=hemoacute(a,50,150,360);
end
clear a

a=patient.NIDiasABP;
if size(a,1)>1
    [ndbp_alarm,ndbp_risk]=bpalarm(a,30,50,105,120);
%     ndbp_acute=hemoacute(a,30,120,360);
end
clear a

a=patient.NISysABP;
if size(a,1)>1
    [nsbp_alarm,nsbp_risk]=bpalarm(a,60,79,176,200);
    nsbp_acute=hemoacute(a,60,200,360);
end
clear a

a=patient.Mg;
if size(a,1)>1
    [mg_alarm,mg_risk]=hemoalarm(a,0,15);
end
clear a

a=patient.PaCO2;
if size(a,1)>1
    [pco2_alarm,pco2_risk]=hemoalarm(a,25,70);
    pco2_acute=hemoacute(a,25,70,360);
end
clear a

a=patient.PaO2;
if size(a,1)>1
    [pao2_alarm,pao2_risk]=hemoalarm(a,60,300);
end
clear a

a=patient.pH;
if size(a,1)>1
    [ph_alarm,ph_risk]=hemoalarm(a,7.1,7.6);
    ph_acute=hemoacute(a,7.1,7.6,360);
end
clear a

a=patient.Platelets;
if size(a,1)>1
    [plat_alarm,plat_risk]=hemoalarm(a,50,1000);
end
clear a   

a=patient.RespRate;
if size(a,1)>1
    [resp_alarm,resp_risk]=hemoalarm(a,6,30);
end
clear a

a=patient.SaO2;
if size(a,1)>1
    [sao2_alarm,sao2_risk]=hemoalarm(a,80,0);
    sao2_acute=hemoacute(a,80,0,240);
end
clear a

a=patient.SysABP;
if size(a,1)>1
    [sbp_alarm,sbp_risk]=bpalarm(a,60,79,176,200);
    sbp_acute=hemoacute(a,60,200,360);
end
clear a

a=patient.MechVent;
if size(a,1)>1
    t=a(end,1);
    vent_risk=floor(t/1440);
    if  vent_risk>1
        vent_brain=1;
    end
end
clear t a

a=patient.WBC;
if size(a,1)>1
    [wbc_b_alarm,wbc_b_risk]=hemoalarm(a,5,50);
end
clear a

a=patient.WBC;
if size(a,1)>1
    [wbc_i_alarm,wbc_i_risk]=hemoalarm(a,5,20);
end
clear a