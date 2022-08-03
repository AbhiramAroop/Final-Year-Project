dataset <- read.table("stdin", header=TRUE, sep=",")

TIME=sapply(strsplit(as.character(dataset[,1]),":"),function(x) {
    x <- as.numeric(x)
    x[1]
    }
)
data=cbind(TIME,dataset[,2:3])
d0=t(subset(data,data[,2]=="RecordID")[,-2])
d01=t(subset(data,data[,2]=="ALP")[,-2])
d02=t(subset(data,data[,2]=="ALT")[,-2])
d03=t(subset(data,data[,2]=="AST")[,-2])
d04=t(subset(data,data[,2]=="Age")[,-2])
d1=t(subset(data,data[,2]=="Albumin")[,-2])
d2=t(subset(data,data[,2]=="BUN")[,-2])
d3=t(subset(data,data[,2]=="Bilirubin")[,-2])
d4=t(subset(data,data[,2]=="Cholesterol")[,-2])
d5=t(subset(data,data[,2]=="Creatinine")[,-2])
d6=t(subset(data,data[,2]=="DiasABP")[,-2])
d7=t(subset(data,data[,2]=="FiO2")[,-2])
d8=t(subset(data,data[,2]=="GCS")[,-2])
d9=t(subset(data,data[,2]=="Gender")[,-2])
d10=t(subset(data,data[,2]=="Glucose")[,-2])
d11=t(subset(data,data[,2]=="HCO3")[,-2])
d12=t(subset(data,data[,2]=="HCT")[,-2])
d13=t(subset(data,data[,2]=="HR")[,-2])
d14=t(subset(data,data[,2]=="Height")[,-2])
d15=t(subset(data,data[,2]=="ICUType")[,-2])
d16=t(subset(data,data[,2]=="K")[,-2])
d17=t(subset(data,data[,2]=="Lactate")[,-2])
d18=t(subset(data,data[,2]=="MAP")[,-2])
d19=t(subset(data,data[,2]=="MechVent")[,-2])
d20=t(subset(data,data[,2]=="Mg")[,-2])
d21=t(subset(data,data[,2]=="NIDiasABP")[,-2])
d22=t(subset(data,data[,2]=="NIMAP")[,-2])
d23=t(subset(data,data[,2]=="NISysABP")[,-2])
d24=t(subset(data,data[,2]=="Na")[,-2])
d25=t(subset(data,data[,2]=="PaCO2")[,-2])
d26=t(subset(data,data[,2]=="PaO2")[,-2])
d27=t(subset(data,data[,2]=="Platelets")[,-2])
d28=t(subset(data,data[,2]=="RespRate")[,-2])
d29=t(subset(data,data[,2]=="SaO2")[,-2])
d30=t(subset(data,data[,2]=="SysABP")[,-2])
d31=t(subset(data,data[,2]=="Temp")[,-2])
d32=t(subset(data,data[,2]=="TroponinI")[,-2])
d33=t(subset(data,data[,2]=="Urine")[,-2])
d34=t(subset(data,data[,2]=="WBC")[,-2])
d35=t(subset(data,data[,2]=="Weight")[,-2])
d36=t(subset(data,data[,2]=="pH")[,-2])
d37=t(subset(data,data[,2]=="TroponinT")[,-2])

b=list(d0,d01,d02,d03,d04,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,
d21,d22,d23,d24,d25,d26,d27,d28,d29,d30,d31,d32,d33,d34,d35,d36,d37)
t24=t(as.matrix(sapply(b,function(d) mean(d[2,][d[1,]<=24]))))
colnames(t24)=c("X.RecordID.",	"X.ALP.",	"X.ALT.",	"X.AST.",	"X.Age.",	"X.Albumin.",	"X.BUN.",
	"X.Bilirubin.",	"X.Cholesterol.",	"X.Creatinine.",	"X.DiasABP.",	"X.FiO2.",	"X.GCS.",	"X.Gender.",
	"X.Glucose.",	"X.HCO3.",	"X.HCT.",	"X.HR.",	"X.Height.",	"X.ICUType.",	"X.K.",	"X.Lactate.",
	"X.MAP.",	"X.MechVent.",	"X.Mg.",	"X.NIDiasABP.",	"X.NIMAP.",	"X.NISysABP.",	"X.Na.",	"X.PaCO2.",
	"X.PaO2.",	"X.Platelets.",	"X.RespRate.",	"X.SaO2.",	"X.SysABP.",	"X.Temp.",	"X.TroponinI.",
	"X.Urine.",	"X.WBC.",	"X.Weight.",	"X.pH.",	"X.TroponinT.")

t48=t(as.matrix(sapply(b,function(d) mean(d[2,][d[1,]<=48 && d[1,]>24]))))
colnames(t48)=c("X.RecordID.",	"X.ALP.",	"X.ALT.",	"X.AST.",	"X.Age.",	"X.Albumin.",	"X.BUN.",	"X.Bilirubin.",
	"X.Cholesterol.",	"X.Creatinine.",	"X.DiasABP.",	"X.FiO2.",	"X.GCS.",	"X.Gender.",	"X.Glucose.",	"X.HCO3.",
	"X.HCT.",	"X.HR.",	"X.Height.",	"X.ICUType.",	"X.K.",	"X.Lactate.",	"X.MAP.",	"X.MechVent.",	"X.Mg.",
	"X.NIDiasABP.",	"X.NIMAP.",	"X.NISysABP.",	"X.Na.",	"X.PaCO2.",	"X.PaO2.",	"X.Platelets.",	"X.RespRate.",	"X.SaO2.",
	"X.SysABP.",	"X.Temp.",	"X.TroponinI.",	"X.Urine.",	"X.WBC.",	"X.Weight.",	"X.pH.",	"X.TroponinT.")

t24=data.frame(t24)
t48=data.frame(t48)


if (!is.na(t24$X.Weight.) & t24$X.Weight.==-1) {t24$X.Weight.=NA}
if (!is.na(t48$X.Weight.) & t48$X.Weight.==-1) {t48$X.Weight.=NA}

if (!is.na(t24$X.Height.) & t24$X.Height.==-1) {t24$X.Height.=NA}
if (!is.na(t48$X.Height.) & t48$X.Height.==-1) {t48$X.Height.=NA}


for (i in 1:ncol(t24))
{

t24[[i]]=mapply(function(x,y) { if (is.na(x)) {x=y}
else{x=x}}, t24[[i]], t48[[i]])

}

for (i in 1:ncol(t48))
{

t48[[i]]=mapply(function(x,y) { if (is.na(x)) {x=y}
else{x=x}}, t48[[i]], t24[[i]])
}

a=t24
b=t48


#Mech vent variable

for (i in 1:nrow(a))
{
if (is.na(a$X.MechVent.[i]))
{a$X.MechVent.[i]=0}
else
{a$X.MechVent.[i]=1
}
}

##adding BMI for 24
BMI=a$X.Weight./((a$X.Height./100)^2) 
a=data.frame(a,BMI)
##adding BMI for 48
BMI=b$X.Weight./((b$X.Height./100)^2) 
b=data.frame(b,BMI)

#delta (48-24)

delta=b-a

#getting rid off delta of (record id,age,heigth,gender,icutype,mechanic ventilator)

delta=delta[c(-1,-5,-14,-20,-19,-24)]
#str(delta)

#if delta=0 put it NaN

delta3=delta
for (i in 1:ncol(delta))
{

delta3[i]=sapply(delta[[i]],function(x){if ( !is.na(x) & x==0) {x=NA}
else {x=x}})
}
d=data.frame(a,delta3)

patientRecordID=d$X.RecordID.

###define the input for logistic regression

#GCS

GCS=d$X.GCS./15

#AGE grouping

agee=sapply(d$X.Age., function(age) {
if (age<20)
{age2=1}
else if (age<30)
{age2=2}
else if (age<40)
{age2=3}
else if (age<50)
{age2=4}
else if (age<60)
{age2=5}
else if (age<70)
{age2=6}
else {age2=7}})

agee=agee/7

##define final threshhold:
thresh=0.3362
if (is.na(d$X.ALP.))
{thresh=0.28} 
##log transformation:

bilbi=log(d$X.Bilirubin.+0.01)
alp=log(d$X.ALP.+0.01)
alt=log(d$X.ALT.+0.01)
ast=log(d$X.AST.+10)
pao2=log(1+d$X.PaO2.)
paco2=log(1+d$X.PaCO2.)
fio2=log(0.01+d$X.FiO2.)
K=log(0.01+d$X.K.)
Mg=log(0.01+d$X.Mg.)
lactate=log(0.1+d$X.Lactate.)
bun=log(1+d$X.BUN.)
createnin=log(0.01+d$X.Creatinine.)
plat=log(d$X.Platelets.+1)
urine=log(1+d$X.Urine.)
wbc=log(1+d$X.WBC.)
Weight=log(0.1+d$X.Weight.)

lactate.d=log(d$X.Lactate..1+9.648484847+1)
FiO2.d=log(d$X.FiO2..1+0.65+1)
Mg.d=log(d$X.Mg..1+2.806666667+1)
Temp.d=log(d$X.Temp..1+7.47142857+1)

###STANDARDIZATION

d1=data.frame(alp,	alt,	ast,	d$X.Albumin.,	bun,	bilbi,	createnin,	d$X.DiasABP.,	fio2,	d$X.Glucose.,	d$X.HCO3.,	d$X.HCT.,
	d$X.HR.,	d$X.Height.,	K,	lactate,	d$X.MAP.,	d$X.MechVent.,	Mg,	d$X.NIDiasABP.,	d$X.NISysABP.,	d$X.Na.,	paco2,
	pao2,	plat,	d$X.SysABP.,	d$X.Temp.,	urine,	wbc,	Weight,	d$X.pH.,	d$BMI,	d$X.BUN..1,	d$X.Creatinine..1,	d$X.DiasABP..1,
	d$X.FiO2..1,	d$X.GCS..1,	d$X.Glucose..1,	d$X.HCO3..1,	d$X.HCT..1,	d$X.HR..1,	d$X.K..1,	lactate.d,	d$X.MAP..1,	Mg.d,	d$X.NIDiasABP..1,
	d$X.NISysABP..1,	d$X.Na..1,	d$X.PaCO2..1,	d$X.PaO2..1,	d$X.Platelets..1,	d$X.SysABP..1,	Temp.d,	d$X.Urine..1,	d$X.WBC..1,
	d$X.pH..1,	d$BMI.1)

#ad<-scale(d1, center = TRUE, scale = TRUE)
mean1=c(4.428792,	3.751404,	4.377866,	2.950229,	3.185411,	-0.1377478,	0.8950096,	59.65327,	-0.5278706,	144.1531,	22.7077,	32.11874,
	88.77805,	170.0834,	1.41549,	0.8592167,	81.20807,	0.6358339,	0.6892202,	57.56831,	114.3365,	139.0517,	3.683789,	4.978323,
	5.194582,	114.7876,	36.89164,	4.546272,	2.508671,	4.387889,	7.490792,	210.2489,	-0.7093838,	0.01846575,	0.602998,	-0.08731749,
	0.769466,	-17.21709,	0.8136559,	-1.072103,	-1.081304,	-0.09029135,	2.282917,	0.8655896,	1.348159,	0.06620109,	1.163557,	0.1317891,
	-0.4752844,	-39.57504,	-20.90938,	2.952707,	2.149836,	-7.146416,	-0.609545,	-0.0006686606,	-33.55544)

sd1=c(0.6066783,	1.288708,	1.146172,	0.595363,	0.6869114,	1.043874,	0.04468801,	10.33693,	0.2128702,	54.1664,	4.719987,	5.050711,
	16.4147,	16.75468,	0.1387224,	0.4910585,	12.99533,	0.4813709,	0.1716615,	12.22031,	19.80241,	4.647058,	0.1865474,	0.3911182,
	0.5808523,	18.40125,	0.9844662,	0.9129201,	0.5381392,	0.2729483,	2.683078,	5723.599,	8.796758,	0.5259562,	7.190248,	0.1080009,
	2.662966,	60.13094,	2.942004,	3.375774,	11.18836,	0.5724884,	0.1473419,	9.631489,	0.0857281,	7.683106,	15.97342,	3.160388,
	4.981642,	50.95536,	45.65448,	13.30604,	0.1170007,	93.00365,	4.318247,	0.5854828,	107.8054)


d2=mapply(function(x,y,z){z=(z-x)/y},mean1,sd1,d1)

d2=t(data.frame(d2))

colnames(d2)<-c("alp",	"alt",	"ast",	"d.X.Albumin.",	"bun",	"bilbi",	"createnin",	"d.X.DiasABP.",	"fio2",	"d.X.Glucose.",
	"d.X.HCO3.",	"d.X.HCT.",	"d.X.HR.",	"d.X.Height.",	"K",	"lactate",	"d.X.MAP.",	"d.X.MechVent.",	"Mg",	"d.X.NIDiasABP.",	"d.X.NISysABP.",
	"d.X.Na.",	"paco2",	"pao2",	"plat",	"d.X.SysABP.",	"d.X.Temp.",	"urine",	"wbc",	"Weight",	"d.X.pH.",	"d.BMI",	"d.X.BUN..1",
	"d.X.Creatinine..1",	"d.X.DiasABP..1",	"d.X.FiO2..1",	"d.X.GCS..1",	"d.X.Glucose..1",	"d.X.HCO3..1",	"d.X.HCT..1",	"d.X.HR..1",
	"d.X.K..1",	"lactate.d",	"d.X.MAP..1",	"Mg.d",	"d.X.NIDiasABP..1",	"d.X.NISysABP..1",	"d.X.Na..1",	"d.X.PaCO2..1",
	"d.X.PaO2..1",	"d.X.Platelets..1",	"d.X.SysABP..1",	"Temp.d",	"d.X.Urine..1",	"d.X.WBC..1",	"d.X.pH..1",	"d.BMI.1")

d1=data.frame(GCS,agee,d2)

d3=data.frame(	d1$alp,	d1$urine,	d1$d.X.GCS..1,	d1$GCS,	d1$bun,	d1$d.X.BUN..1,	d1$lactate,		d1$createnin,
			d1$pao2,	d1$paco2,	d1$d.X.Na..1,	d1$lactate.d,	d1$d.X.HCO3.,		d1$d.X.Temp.,	d1$agee,
			d1$d.X.Albumin.,	d1$d.X.Glucose.,	d1$d.X.Creatinine..1,	d1$ast)
	
#d3=data.frame(d3,death)

## for all the validation set:
b=d3

###------------------------------------------
#  Outliers and Missing values imputation:
###------------------------------------------

##b$d1.alp

b$d1.alp=sapply(b$d1.alp,function(x){
if (is.na(x) || x<=-3)
{

x2=-0.139870244
}
else{x2=x}
})

##b$d1.urine

b$d1.urine=sapply(b$d1.urine,function(x){
if (is.na(x)|| x>=3)

{

x2=0.10219898

}else{x2=x}
})



##b$d1.d.X.GCS..1

b$d1.d.X.GCS..1=sapply(b$d1.d.X.GCS..1,function(x){
if (is.na(x)|| x>=3)
{
x2=-0.063638063

}else{x2=x}
})




##b$d1.GCS

b$d1.GCS=sapply(b$d1.GCS,function(x){
if (is.na(x))

{
x=0.688888889
}
else
{x=x}
})


##b$d1.bun

b$d1.bun=sapply(b$d1.bun,function(x){
if (is.na(x)|| x>=3 || x<=-3)

{
x=-0.104664478
}
else
{x=x}
})


##b$d1.d.X.BUN..1

b$d1.d.X.BUN..1=sapply(b$d1.d.X.BUN..1,function(x){
if (is.na(x) || x<=-3)
{

x2=-0.033036739
}
else{x2=x}
})

##b$d1.lactate

b$d1.lactate=sapply(b$d1.lactate,function(x){
if (is.na(x) || x<=-3)
{

x2=-0.048071416

}
else{x2=x}
})

##b$d1.createnin
b$d1.createnin=sapply(b$d1.createnin,function(x){
if (is.na(x) || x<=-3)
{

x2=-0.363778551

}
else{x2=x}
})

##b$d1.pao2

b$d1.pao2=sapply(b$d1.pao2,function(x){
if (is.na(x)|| x>=3 || x<=-3)

{
x=0.039642804

}
else
{x=x}
})

##b$d1.paco2

b$d1.paco2=sapply(b$d1.paco2,function(x){
if (is.na(x)|| x>=3)
{
x2=0.021621913

}else{x2=x}
})


##b$d1.d.X.Na..1

b$d1.d.X.Na..1=sapply(b$d1.d.X.Na..1,function(x){
if (is.na(x))
{
x2=0.069289425

}else{x2=x}
})

##b$d1.lactate.d

b$d1.lactate.d=sapply(b$d1.lactate.d,function(x){
if (is.na(x))
{
x2=0.115348192

}else{x2=x}
})

##b$d1.d.X.HCO3.

b$d1.d.X.HCO3.=sapply(b$d1.d.X.HCO3.,function(x){
if (is.na(x) || x<=-3)
{

x2=-0.0086942
}
else{x2=x}
})

##b$d1.d.X.Temp.

b$d1.d.X.Temp.=sapply(b$d1.d.X.Temp.,function(x){
if (is.na(x)|| x>=3 || x<=-3)

{
x=0.038366966

}
else
{x=x}
})

##b$d1.agee
b$d1.agee=sapply(b$d1.agee,function(x){
if (is.na(x))

{
x2=0.857142857

}

else
{x2=x}})


##b$d1.d.X.Albumin.
b$d1.d.X.Albumin.=sapply(b$d1.d.X.Albumin.,function(x){
if (is.na(x)|| x>=3 || x<=-3)

{
x=-0.031444932
}
else
{x=x}
})

##b$d1.d.X.Glucose.

b$d1.d.X.Glucose.=sapply(b$d1.d.X.Glucose.,function(x){
if (is.na(x) || x<=-3)
{

x2=-0.242828212

}
else{x2=x}
})

##b$d1.d.X.Creatinine..1

b$d1.d.X.Creatinine..1=sapply(b$d1.d.X.Creatinine..1,function(x){
if (is.na(x))
{

x2=-0.022762693

}
else{x2=x}
})

##b$d1.ast

b$d1.ast=sapply(b$d1.ast,function(x){
if (is.na(x) || x<=-3)
{

x2=-0.276942249

}
else{x2=x}
})


##---------------------------------------------
#	(The end of Outliers and Missing values imputation)
##--------------------------------------------


##making 4 variables: (d.X.DiasABP..11, d.X.HCT..11, d.X.HCT.1, d.X.Na.1)

##First, cleaning parent data columns:

##d1$d.X.DiasABP..1

d1$d.X.DiasABP..1=sapply(d1$d.X.DiasABP..1,function(x){
if (is.na(x)|| x>=5 || x<=-5)
{
x2=0

}else{x2=x}
})


##d1$d.X.HCT..1
d1$d.X.HCT..1=sapply(d1$d.X.HCT..1,function(x){
if (is.na(x)|| x>=5 || x<=-5)
{
x2=0

}else{x2=x}
})

##d1$d.X.HCT.

d1$d.X.HCT.=sapply(d1$d.X.HCT.,function(x){
if (is.na(x)|| x>=5 || x<=-5)
{
x2=0

}else{x2=x}
})


##d1$d.X.Na.
d1$d.X.Na.=sapply(d1$d.X.Na.,function(x){
if (is.na(x)|| x>=5 || x<=-5)
{
x2=0

}else{x2=x}
})



## Second: ( from alp v4 ) :  study the ones that are less associated. if their outliers are associated with death, then we made it a binary variable.



#d.X.DiasABP..11

#d1$d.X.DiasABP..1<= -2.5 or >= 2.2 can be associated with death therefore we will make this variable a binary:

d.X.DiasABP..11=sapply(d1$d.X.DiasABP..1, function(x) {
if (x>=2.2 ||x<=-2.5 )
{x2=1}
else 
{x2=0}
})
#b[60]=d.X.DiasABP..11

#d.X.HCT..11

#d1$d$X.HCT..1<= -2.4 or >= 2.5 can be associated with death therefore we will make this variable a binary:

d.X.HCT..11=sapply(d1$d.X.HCT..1, function(x) {
if (x>=2.5 ||x<=-2.4 )
{x2=1}
else 
{x2=0}
})
#b[61]=d.X.HCT..11

#d.X.HCT.1

#d1$d.X.HCT. <= -2.486213828 or >= 2.6 can be associated with death therefore we will make this variable a binary:

d.X.HCT.1=sapply(d1$d.X.HCT., function(x) {
if (x>= 2.6 ||x<= -2.486213828 )
{x2=1}
else 
{x2=0}
})
#b[62]=d.X.HCT.1

#d.X.Na.1

#d1$d.X.Na. <= -2 or >= 2 can be associated with death therefore we will make this variable a binary:

d.X.Na.1=sapply(d1$d.X.Na., function(x) {
if (x>= 2 ||x<= -2 )
{x2=1}
else 
{x2=0}
})

b=data.frame(b,d.X.DiasABP..11, d.X.HCT..11, d.X.HCT.1, d.X.Na.1)


##-------------------
##  LogReg Model: 
##-------------------
	
b24=data.frame(b$d1.alp,	b$d1.urine,	b$d1.d.X.GCS..1,	b$d1.GCS,	b$d1.bun,	b$d1.d.X.BUN..1,	b$d1.lactate,	b$d1.createnin,
	b$d1.pao2,	b$d1.paco2,	b$d1.d.X.Na..1,	b$d1.lactate.d,	b$d1.d.X.HCO3.,	b$d1.d.X.Temp.,	b$d1.agee,	b$d1.d.X.Albumin.,
	b$d1.d.X.Glucose.,	b$d1.d.X.Creatinine..1,	b$d1.ast,	b$d.X.DiasABP..11,	b$d.X.HCT..11,	b$d.X.HCT.1,	b$d.X.Na.1)

#build model

attach(b24, warn.conflicts = FALSE)
y= (-1.01648	+(b$d1.alp)*0.32492	+b$d1.urine*-0.383	+b$d1.d.X.GCS..1*-0.63786	+b$d1.GCS*-2.71744	+b$d1.bun*0.52039	+b$d1.d.X.BUN..1*0.45308
	+b$d1.lactate*0.29553	+b$d1.createnin*-0.2694	+b$d.X.HCT..11*1.67211	+b$d1.pao2*-0.28836	+b$d1.paco2*-0.41355	+b$d1.d.X.Na..1*0.23602	
	+b$d1.lactate.d*0.25241	+b$d1.d.X.HCO3.*0.34784	+b$d1.d.X.Temp.*-0.24007	+b$d.X.Na.1*0.7556	+b$d1.agee*0.99375	+b$d1.d.X.Albumin.*-0.21477
	+b$d1.d.X.Glucose.*0.14364	+b$d1.d.X.Creatinine..1*-0.17765	+b$d1.ast*0.14487	+b$d.X.DiasABP..11*0.71979	+b$d.X.HCT.1*1.55271)


##Threshold : 

#threshold=?  for all the data
#threshold=? for troponin data 



ghal=y
ab=exp(ghal)/(1+exp(ghal))

predict=0
if (ab >= thresh)
{predict=1}

cat(sprintf("%i,%i,%f\n", patientRecordID, predict, ab));






