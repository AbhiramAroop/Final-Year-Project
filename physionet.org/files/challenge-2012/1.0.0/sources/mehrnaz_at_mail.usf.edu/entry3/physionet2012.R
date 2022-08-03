
dataset <- read.table("stdin", header=TRUE, sep=",")
#setwd("C:\\Users\\mehrnaz\\Dropbox\\ma+del\\advanced\\set-a")
#dataset <- read.table("142673.txt", header=TRUE, sep=",")
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
colnames(t24)=c("X.RecordID.","X.ALP.","X.ALT.","X.AST.",	"X.Age.",	"X.Albumin.",	"X.BUN.",	"X.Bilirubin.",	"X.Cholesterol.",	"X.Creatinine.",	"X.DiasABP.",	"X.FiO2.",	"X.GCS.",	"X.Gender.",	"X.Glucose.",	"X.HCO3.",	"X.HCT.",	"X.HR.",	"X.Height.",	"X.ICUType.",	"X.K.",	"X.Lactate.",	"X.MAP.",	"X.MechVent.",	"X.Mg.",	"X.NIDiasABP.",	"X.NIMAP.",	"X.NISysABP.",	"X.Na.",	"X.PaCO2.",	"X.PaO2.",	"X.Platelets.",	"X.RespRate.",	"X.SaO2.",	"X.SysABP.",	"X.Temp.",	"X.TroponinI.",	"X.Urine.",	"X.WBC.",	"X.Weight.",	"X.pH.",	"X.TroponinT.")

t48=t(as.matrix(sapply(b,function(d) mean(d[2,][d[1,]<=48 && d[1,]>24]))))
colnames(t48)=c("X.RecordID.","X.ALP.","X.ALT.","X.AST.",	"X.Age.",	"X.Albumin.",	"X.BUN.",	"X.Bilirubin.",	"X.Cholesterol.",	"X.Creatinine.",	"X.DiasABP.",	"X.FiO2.",	"X.GCS.",	"X.Gender.",	"X.Glucose.",	"X.HCO3.",	"X.HCT.",	"X.HR.",	"X.Height.",	"X.ICUType.",	"X.K.",	"X.Lactate.",	"X.MAP.",	"X.MechVent.",	"X.Mg.",	"X.NIDiasABP.",	"X.NIMAP.",	"X.NISysABP.",	"X.Na.",	"X.PaCO2.",	"X.PaO2.",	"X.Platelets.",	"X.RespRate.",	"X.SaO2.",	"X.SysABP.",	"X.Temp.",	"X.TroponinI.",	"X.Urine.",	"X.WBC.",	"X.Weight.",	"X.pH.",	"X.TroponinT.")





t24=data.frame(t24)
t48=data.frame(t48)

if (!is.na(t24$X.Weight.) & t24$X.Weight.==-1) {t24$X.Weight.=NA}
if (!is.na(t48$X.Weight.) & t48$X.Weight.==-1) {t48$X.Weight.=NA}


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


#if (!is.na(a1$X.TroponinI.) && !is.na(a1$X.TroponinT.)) {}

a=t24
b=t48
#remove troponint and troponin i
a=a[c(-37,-42)]
b=b[c(-37,-42)]
for (i in 1:nrow(a))
{
if (is.na(a$X.MechVent.[i]))
{a$X.MechVent.[i]=0}
else
{a$X.MechVent.[i]=1
}
}

#mehrnaz model for troponin patients


#add variable BMI
BMI=a$X.Weight./(a$X.Height.^2) 
a=data.frame(a,BMI)
BMI=b$X.Weight./(b$X.Height.^2) 
b=data.frame(b,BMI)
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



#######################################################
#mehrnaz
#define the input for logistic regression
GCS=d$X.GCS./15

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
alp=log(d$X.ALP.+1)
pao2=log(1+d$X.PaO2.)
urine=log(1+d$X.Urine.)
wbc=log(1+d$X.WBC.)
createnin=log(0.01+ d$X.Creatinine.)
lactate=log(0.1+d$X.Lactate.)
bun=log(1+d$X.BUN.)
diasabp.d=log(d$X.DiasABP..1+ 70.35185+1)
wbc.d=log(d$X.WBC..1+22.83333+1)
alp.d=log(d$X.ALP..1+90+1)
ast.d=log(d$X.AST..1+9006+1)
#
d1=data.frame(
alp,
pao2,
urine,
wbc,
createnin,
lactate,
bun,
diasabp.d,
wbc.d,alp.d,ast.d,d$X.Albumin..1,d$X.PaCO2..1,d$X.HCO3.,d$X.HR.,d$X.Height.,d$X.FiO2..1,d$X.GCS..1,
d$X.MAP..1,d$X.NIMAP..1,d$BMI.1, d$X.PaCO2.,d$X.Albumin.
)
#ad<-scale(d1, center = TRUE, scale = TRUE)
mean1=c(4.50005094,	4.953607683,	4.32827816,	2.568075717,	0.901376019,	0.849259199,	3.381712382,	4.248351574,	3.131786867,	4.403365137,	9.094818797,	-0.072301697,	-0.139183126,	22.554101898,	87.415143119,	
166.003319344,	-0.071291865,	0.343415562,	0.911073234,	-0.013663701,	-0.003188958,	39.122005999,	2.924540544								
)

sd1=c(0.43876487,	0.38881934,	0.97433465,	0.44944589,	0.04251337,	0.51645715,	0.61646042,	0.15514354,	0.22495596,	0.29835991,	0.25928707,	0.20067406,	5.10357788,	4.98520008,	16.5684575,
11.18376336,	0.11542437,	2.38174523,	8.56982557,	9.54947489,	0.0130926,	7.71283842,	0.50386189							
)


d2=mapply(function(x,y,z){z=(x-z)/y},mean1,sd1,d1)

d2=t(data.frame(d2))
colnames(d2)<-c("alp",
"pao2",
"urine",
"wbc",
"createnin",
"lactate",
"bun",
"diasabp.d",
"wbc.d","alp.d","ast.d","d$X.Albumin..1","d$X.PaCO2..1","d$X.HCO3.","d$X.HR.","d$X.Height.","d$X.FiO2..1","d$X.GCS..1",
"d$X.MAP..1","d$X.NIMAP..1","d$BMI.1", "d$X.PaCO2.","d$X.Albumin."
)
d1=data.frame(GCS,agee,d2)



GCS=sapply(GCS,function(x){
if (is.na(x))

{
x=6.750000e-01
}
else
{x=x}
})

agee=sapply(agee,function(x){
if (is.na(x))

{

x2=1
}

else
{x2=x}})

BMI.1=sapply(d1$d.BMI.1,function(x){
if (is.na(x)|| x>=2)

{

x2=0.24710462
}
else{x2=x}
})

alp=sapply(d1$alp,function(x){
if (is.na(x) || x>=4)

{

x2=-0.02602
}
else{x2=x}
})

pao2=sapply(d1$pao2,function(x){
if (is.na(x) || x<=-3.5)

{

x2=0.066563
}else{x2=x}
})

urine=sapply(d1$urine,function(x){
if (is.na(x))

{

x2=0.14553
}else{x2=x}
})

wbc=sapply(d1$wbc,function(x){
if (is.na(x))

{

x2=-0.006956
}else{x2=x}
})

createnin=sapply(d1$createnin,function(x){
if (is.na(x) || x>=3)

{

x2=-0.0815
}else{x2=x}
})

lactate=sapply(d1$lactate,function(x){
if (is.na(x))

{

x2=-0.1152
}else{x2=x}
})


bun=sapply(d1$bun,function(x){
if (is.na(x)|| x<=-3)

{

x2=-0.0611
}else{x2=x}
})

diasabp.d=sapply(d1$diasabp.d,function(x){
if (is.na(x) || x<=-5)

{

x2=0.00009
}else{x2=x}
})

wbc.d=sapply(d1$wbc.d,function(x){
if (is.na(x) || x<=-10)

{

x2=0.0899
}else{x2=x}
})


alp.d.1=sapply(d1$alp.d, function(x) {
if (!is.na(x) & x>=1)
{x2=1}
else 
{x2=0}
})

ast.d.1=sapply(d1$ast.d, function(x) {
if (!is.na(x) & x>=1)
{x2=1}
else 
{x2=0}
})

Albumin..11=sapply(d1$d.X.Albumin..1, function(x) {
if (!is.na(x) & (x>=4 ||x<=-4) )
{x2=1}
else 
{x2=0}
})

PaCO2..11=sapply(d1$d.X.PaCO2..1, function(x) {
if (!is.na(x) & x>=1)
{x2=1}
else 
{x2=0}
})

HCO3.=sapply(d1$d.X.HCO3. ,function(x){
if (is.na(x))
{
x2=-0.04428
}else {x2=x}
})

HR.=sapply(d1$d.X.HR.,function(x){
if (is.na(x))
{
x2=-0.05188
}else{x2=x}
}) 

Height.=sapply(d1$d.X.Height.,function(x){
if (is.na(x))
{
x2=0.021035
}else{x2=x}
}) 

FiO2..1 =sapply(d1$d.X.FiO2..1 ,function(x){
if (is.na(x))
{
x2=-0.1393
}else{x2=x}
}) 


BMI.11 =sapply(d1$d.BMI.1 ,function(x){
if (is.na(x))
{
x2=2.471046e-01
}else{x2=x}
}) 

MAP..11 =sapply(d1$d.X.MAP..1 ,function(x){
if (is.na(x))
{
x2=1.504427e-02
}else{x2=x}
})

NIMAP..11 =sapply(d1$d.X.NIMAP..1 ,function(x){
if (is.na(x))
{
x2=9.298194e-02
}else{x2=x}
})


PaCO2.=sapply(d1$d.X.PaCO2. ,function(x){
if (is.na(x))
{
x2=-6.768014e-02
}else{x2=x}
})


Albumin.=sapply(d1$d.X.Albumin. ,function(x){
if (is.na(x))
{
x2=-4.870490e-02
}else{x2=x}
})

GCS..1=sapply(d1$d.X.GCS..1 ,function(x){
if (is.na(x))
{
x2=-7.289626e-02
}else{x2=x}
})


b24=data.frame(alp, GCS, GCS..1 , FiO2..1, agee,urine,HR.,
lactate,Height., wbc.d ,diasabp.d,bun,createnin ,pao2 ,ast.d.1
,  wbc ,alp.d.1 ,HCO3.,BMI.11,MAP..11,NIMAP..11,PaCO2.,Albumin.
)

#build model
attach(b24, warn.conflicts = FALSE)
y=0.83104+alp*0.33684+GCS*-3.35244+GCS..1*-0.77539+FiO2..1*0.42292+agee*1.5975+	
urine*-0.31299+PaCO2..11*0.66486+HR.*0.23167+NIMAP..11*-0.27412+Albumin.*-0.16712+
lactate*0.19954+	BMI.11*0.32796+Height.*-0.32128+	wbc.d*0.27321+
	diasabp.d*-0.50324+	bun*0.3836+	createnin*-0.28206+	pao2*-0.19495+
	ast.d.1*2.30468+	wbc*0.1808+	MAP..11*0.19799+
	alp.d.1*-0.79075+	PaCO2.*-0.20022+ HCO3.*0.16702

#threshold=0.9479000 for all the data
#threshold=0.6714000 for troponin data 

threshold=0.6714000

#####################jennifer
Subset24<-subset(t24, select=-X.RecordID.)
Subset48<-subset(t48, select=-X.RecordID.)
Delta<-Subset48-Subset24
ValidationSet<- data.frame(cbind(t24,Delta))

#Extracting the variables for the logistic model
Var<-subset(ValidationSet, select=c(X.RecordID.,X.ALT.,X.BUN., X.Bilirubin., X.DiasABP.,X.GCS., X.Gender., X.ICUType.,X.K..1,X.Lactate..1, X.NIMAP..1, X.Na..1, X.PaCO2., X.PaO2..1,X.SaO2., X.SysABP., X.WBC..1))
	
#Log transformation
Var_0.1<-replace(Var[, c("X.ALT.","X.BUN.", "X.Bilirubin.","X.PaO2..1")], 
Var[,c("X.ALT.","X.BUN.", "X.Bilirubin.","X.PaO2..1")]==0, 0.1)
Log_0.1<-log(Var_0.1)
VarNor<-subset(ValidationSet, select=c("X.RecordID.","X.DiasABP.", "X.GCS.", "X.Gender.", "X.ICUType.","X.K..1","X.Lactate..1", "X.NIMAP..1", "X.Na..1", "X.PaCO2.", "X.SaO2.", "X.SysABP.", "X.WBC..1"))
VarLog<-data.frame(cbind(Log_0.1,VarNor))

#Standardization of the data except the categorical variables Gender + ICUType
Ranges<-matrix(
c(-2.634051958,-2.991844064,-2.388897278,	-4.46881697,	-2.243334467,	 -7.197909051,	-7.203228589,	-10.04151072,	-4.929786649,	-3.064924714,	 -2.835090768,	-3.238755862,	-3.820912872,	-5.065010701,

4.326471689,	2.675307479,	3.60430965,	2.781303605,	1.444441927, 4.574522477,	7.192420026,	5.739081632,	4.981612334,	9.66684033, 3.83444211,	0.898110143,	3.004101623,	5.027706308,  

0.054334973,	-0.094674663,	-0.125351218,	-0.050924165,	-0.060772928, 0.114348676,	0.244893801,	-0.030057347,	-0.020115326,	-0.061831101, 0.063285247,	0.499198065,	0.115539681,	0.041245234,

4.049993063,	3.202056119,	0.016317935,	59.7688116,	9.516428108,	 -0.112812408,	-0.317241581,	0.246182273,	0.065553312,	39.26702457, 1.321781066,	81.76367039,	105.4289793,	-0.283626057,

1.120471737,	0.703059312,	0.970700184,	13.37463852,	3.796325619, 0.549305948,	1.295425121,	8.190419206,	3.258873955,	11.50665281, 1.098215461,	20.3052262,	27.59261539,	4.452055209), nrow=5, ncol=14, byrow=TRUE)

M=c("X.ALT.", "X.BUN.", "X.Bilirubin.", "X.DiasABP.", "X.GCS.", "X.K..1", "X.Lactate..1", "X.NIMAP..1", "X.Na..1", "X.PaCO2.", "X.PaO2..1","X.SaO2.", "X.SysABP.", "X.WBC..1")
colnames(Ranges)<-paste(M , sep="")
VarCont<-subset(VarLog, select=-c(X.RecordID., X.Gender.,X.ICUType.))
DataOut=VarCont
for(j in 1:ncol(VarCont)){
for (i in 1:nrow(VarCont)){
DataOut[i,j]<-(VarCont[i,j]-Ranges[4,j])/Ranges[5,j]}}

#Missing values
DataOut2=DataOut
for(j in 1:ncol(DataOut)){
for (i in 1:nrow(DataOut)){
if(is.na(DataOut[i,j])==TRUE){
DataOut2[i,j]<-Ranges[3,j]}
else
{DataOut2[i,j]<-DataOut2[i,j]}}}

#Outliers
DataOut3=DataOut2
for(j in 1:ncol(DataOut2)){
for (i in 1:nrow(DataOut2)){
if((DataOut2[i, j]<=Ranges[1,j])== TRUE || (DataOut2[i, j]>=Ranges[2,j])==TRUE)
{DataOut3[i, j]<-NA}
else
{DataOut3[i, j]<-DataOut3[i, j]}
}}

Ranges2<-matrix(
c(0.054334973,	-0.094674663,	-0.125351218,	-0.050924165,	-0.060772928,	0.114348676,	0.244893801,	-0.030057347,	-0.020115326,	-0.061831101,	0.063285247,	0.499198065,	0.115539681,	0.041245234,	1,	3), nrow=1, ncol=16, byrow=TRUE)

M=c("X.ALT.", "X.BUN.", "X.Bilirubin.", "X.DiasABP.", "X.GCS.", "X.K..1", "X.Lactate..1", "X.NIMAP..1", "X.Na..1", "X.PaCO2.", "X.PaO2..1","X.SaO2.", "X.SysABP.", "X.WBC..1", "X.Gender.", "X.ICUType.")
colnames(Ranges2)<-paste(M , sep="")


SubsetB<-subset(VarLog, select=c(X.Gender., X.ICUType.))
DataOut4<-data.frame(cbind(DataOut3, SubsetB))

#Missing Values 2
Val=DataOut4
for(j in 1:ncol(DataOut4)){
for (i in 1:nrow(DataOut4)){
if(is.na(DataOut4[i,j])==TRUE){
Val[i,j]<-Ranges2[1,j]}
else
{Val[i,j]<-Val[i,j]}}}

SubsetC<-subset(VarLog, select=c(X.RecordID.))
Val2<-data.frame(cbind(Val, SubsetC))

#Logistic Model
attach(Val2, warn.conflicts=FALSE)
LogModel<-0.18693*X.ALT.+ 0.72686*X.BUN. + 0.10174 *X.Bilirubin. + 0.08186*X.DiasABP.+ -0.35686 *X.GCS. -0.23083*X.Gender. +0.11584* X.ICUType.+ 0.07489*X.K..1+ 0.08698 *X.Lactate..1 + -0.16908* X.NIMAP..1 + 0.12889 *X.Na..1 -0.19166 *X.PaCO2. + 0.19979*X.PaO2..1+ 0.12604 *X.SaO2. -0.12882*X.SysABP.+0.23154*X.WBC..1
Y=LogModel
Yhat<-exp(Y)/(1+exp(Y))
Threshold=0.6582000
Fitted<- ifelse(Yhat>Threshold,1,0)





########################alireza


a=t24
b=t48


#*******************************************************************************Alireza***********************************

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

###### make a subset of ALP
#b=subset(d3,!is.na(d$X.ALP.))
#d1=subset(d1,!is.na(d$X.ALP.))

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

attach(b24,  warn.conflicts = FALSE)
y1= (-1.01648	+(b$d1.alp)*0.32492	+b$d1.urine*-0.383	+b$d1.d.X.GCS..1*-0.63786	+b$d1.GCS*-2.71744	+b$d1.bun*0.52039	+b$d1.d.X.BUN..1*0.45308
	+b$d1.lactate*0.29553	+b$d1.createnin*-0.2694	+b$d.X.HCT..11*1.67211	+b$d1.pao2*-0.28836	+b$d1.paco2*-0.41355	+b$d1.d.X.Na..1*0.23602	
	+b$d1.lactate.d*0.25241	+b$d1.d.X.HCO3.*0.34784	+b$d1.d.X.Temp.*-0.24007	+b$d.X.Na.1*0.7556	+b$d1.agee*0.99375	+b$d1.d.X.Albumin.*-0.21477
	+b$d1.d.X.Glucose.*0.14364	+b$d1.d.X.Creatinine..1*-0.17765	+b$d1.ast*0.14487	+b$d.X.DiasABP..11*0.71979	+b$d.X.HCT.1*1.55271)



####################################jining
#jining
#Lactate.1
#Lactate.1
#Extraction the data
Subset24<-subset(t24, select=-X.RecordID.)
Subset48<-subset(t48, select=-X.RecordID.)
Delta<-Subset24-Subset48
ValidationSet<- data.frame(cbind(t24,Delta))

#Extracting the variables for the logistic model
ValSubset<-subset(ValidationSet, select=c(X.RecordID.,X.Age., X.DiasABP., X.GCS. , X.HCO3. , X.HCT. , X.HR. , X.K. , X.NIDiasABP. , X.Na. , X.Temp. , X.BUN..1 , X.Creatinine..1 , X.DiasABP..1 ,
X.HR..1, X.NIDiasABP..1 , X.Na..1  , X.PaCO2..1 , X.Temp..1  , X.WBC..1 , X.BUN.  , X.Creatinine. ,
X.Glucose. , X.Lactate.  , X.PaO2.  , X.Platelets.  , X.Urine.  , X.Weight.  , X.Mg..1 , X.ICUType.  , X.MechVent.))
	
#Log transformation
ValSubset_2<-replace(ValSubset[, c( "X.BUN.", "X.Creatinine.", 	 "X.Glucose." , "X.Lactate."  , "X.PaO2."  , "X.Platelets."  , "X.Urine." ,"X.Weight."  , "X.Mg..1")], , 1)
ValSubset_3<-subset(ValSubset,select=c ("X.BUN.", "X.Creatinine.", 	 "X.Glucose." , "X.Lactate."  , "X.PaO2."  , "X.Platelets."  , "X.Urine." ,"X.Weight."  , "X.Mg..1"))
ValSubset_1<- ValSubset_2+ ValSubset_3

Var_1<-replace(ValSubset_1[, c ("X.BUN.", "X.Creatinine.", 	 "X.Glucose." , "X.Lactate."  , "X.PaO2."  , "X.Platelets."  , "X.Urine." ,"X.Weight."  , "X.Mg..1")], 
ValSubset_1[,c ("X.BUN.", "X.Creatinine.", 	 "X.Glucose." , "X.Lactate."  , "X.PaO2."  , "X.Platelets."  , "X.Urine." ,"X.Weight."  , "X.Mg..1")]==0, 1)


Log_1<-log10(Var_1)
VarNor<-subset(ValidationSet, select=c(X.RecordID.,X.Age., X.DiasABP., X.GCS. , X.HCO3. , X.HCT. , X.HR. , X.K. , X.NIDiasABP. , X.Na. , X.Temp. , X.BUN..1 , X.Creatinine..1 , X.DiasABP..1 ,X.GCS..1,X.Glucose..1	,X.HCO3..1,	X.HCT..1,
X.HR..1, X.NIDiasABP..1 , X.Na..1  , X.PaCO2..1 , X.Temp..1  , X.WBC..1 , X.ICUType.  , X.MechVent.))
VarLog<-data.frame(cbind(VarNor,Log_1))
#Upload matrix (Min,Max,Median,Mean,Std)
Ranges<-matrix(
c(-2.931788088,-4.991871097,	-1.955340967,	-3.19349387,	-2.906231889,	-3.025206339,	-3.005646747,	-4.697963119,	-6.316690383,	-17.81527166,	-5.24659202,	-11.15473814,	-8.060183788,	-4.274982279,	-6.958523009,	-7.63721675,	-4.683086753,	-4.976089775,	-6.206248907,	-7.107897327,	-9.915323476,	-10.56276104,	-5.156197132,	-2.935062376,	-1.600483426,	-4.020017278,	-2.017178013,	-3.875726147,	-4.381801349,	-4.669653686,	-6.91063195,	-8.098375159,
1.334002657,	4.130394335,	1.155747808,	4.739979569,	4.103153531,	3.373568144,	6.713015548,	4.758235901,	6.844329613,	3.174707678,	7.497471628,	8.65640186,      9.492857124,	7.089512945,	8.341200705,	3.8302355,	4.61220678,	4.258111093,	18.22195187,	21.63985191,	3.955648922,	10.51648159,	7.38487439,	2.954185239,	5.062382639,	4.550957393,	4.904824302,	2.839772341,	2.904145163,	3.670282227,	4.626332871,	10.8729273,
0.181086239,	-0.001455303,	0.015015257,	0.01588858,	-0.144958845,	-0.063182502,	-0.144741829,	-0.084022953,	0.026809717,	0.037154474,	0.008802496,	0.079843935,	0.037366579,	0.157547302,	-0.116460715,	0.011667898,	-0.016704511,	0.011776403,	-0.039472028,	0.014802642,	-0.047619061,	0.028371817,	-0.035986679,	-0.117036108,	-0.287589122,	-0.094240987,	-0.195529099,	0.003631955,	0.124739263,	0.125581162,	0.008208008,	0.156530218,
66.85864064,	58.36995804,	10.54208359,	22.92432554,	31.95070862,	88.11734369,	4.18600814,	56.43796299,	138.8718014,	36.84828908,	-0.184334197,	-0.011042211,	-0.426992716,	-0.530200233,	13.70851559,	-0.533102,	0.972391541,	0.36812208,	0.442787385,	-0.136364185,	0.471207074,	-0.122888071,	0.356732414,	1.395686256,	0.362698826,	2.144113788,	0.51849072,	2.150082926,	2.265356275,	1.940280011,	1.896594561,	-0.049863287,
17.3473113,	11.69300186,	3.857170551,	4.762821049,	5.178770723,	16.5538732,	0.594217581,	12.01328354,	4.78179756,	0.92370084,	8.160662319,	0.55577852,	7.456010729,	2.683005219,	61.89654256,	2.837014938,	3.335917604,	10.88280936,	9.951031255,	3.357341098,	5.695346926,	1.058477534,	4.35528973,	0.290153361,	0.177144965,	0.146221085,	0.184595847,	0.185441162,	0.242191786,	0.415508331,	0.125795517,	0.176240041
), nrow=5, ncol=32, byrow=TRUE)

M=c( "X.Age.", "X.DiasABP.", "X.GCS." , "X.HCO3." , "X.HCT." , "X.HR." , "X.K." , "X.NIDiasABP." , "X.Na." , "X.Temp." , "X.BUN..1" , "X.Creatinine..1" , "X.DiasABP..1" ,
"X.GCS..1","X.Glucose..1"	,"X.HCO3..1",	"X.HCT..1",
"X.HR..1", "X.NIDiasABP..1", "X.Na..1"  , "X.PaCO2..1" , "X.Temp..1"  , "X.WBC..1" , "X.BUN."  , "X.Creatinine." ,
"X.Glucose." , "X.Lactate."  , "X.PaO2."  , "X.Platelets."  , "X.Urine."  , "X.Weight."  , "X.Mg..1")
colnames(Ranges)<-paste(M , sep="")

#Standarization
VarCont<-subset(VarLog, select=-c(X.RecordID., X.ICUType.  , X.MechVent.))
DataOut=VarCont
for(j in 1:ncol(VarCont)){
for (i in 1:nrow(VarCont)){
DataOut[i,j]<-(VarCont[i,j]-Ranges[4,j])/Ranges[5,j]}}

#Missing values
DataOut2=DataOut
for(j in 1:ncol(DataOut)){
for (i in 1:nrow(DataOut)){
if(is.na(DataOut[i,j])==TRUE){
DataOut2[i,j]<-Ranges[3,j]}
else
{DataOut2[i,j]<-DataOut2[i,j]}}}

#Outliers
DataOut3=DataOut2
for(j in 1:ncol(DataOut2)){
for (i in 1:nrow(DataOut2)){
if((DataOut2[i, j]<=Ranges[1,j])== TRUE || (DataOut2[i, j]>=Ranges[2,j])==TRUE)
{DataOut3[i, j]<-NA}
else
{DataOut3[i, j]<-DataOut3[i, j]}
}}
Ranges2<-matrix(
c( 0.1810862, -0.001455303,  0.01501526,  0.01588858, -0.1449588, -0.0631825, -0.1447418,  -0.08402295,   0.02680972  , 0.03715447,  0.008802496 ,     0.07984394,   0.03736658,

0.1575473,   -0.1164607,  0.0116679, -0.01670451 , 0.0117764  ,  -0.03947203 , 0.01480264, -0.04761906 ,  0.02837182, -0.03598668, -0.1170361 ,   -0.2875891, -0.09424099,

-0.1955291,  0.003631955,    0.1247393,  0.1255812,  0.008208008 , 0.15653022,	3,1), nrow=1, ncol=34, byrow=TRUE)
M=c( "X.Age.", "X.DiasABP.", "X.GCS." , "X.HCO3." , "X.HCT." , "X.HR." , "X.K." , "X.NIDiasABP." , "X.Na." , "X.Temp." , "X.BUN..1", "X.Creatinine..1", "X.DiasABP..1","X.GCS..1","X.Glucose..1","X.HCO3..1", "X.HCT..1", "X.HR..1", "X.NIDiasABP..1", "X.Na..1" , "X.PaCO2..1" , "X.Temp..1" , "X.WBC..1" , "X.BUN." , "X.Creatinine.","X.Glucose." , "X.Lactate." , "X.PaO2." , "X.Platelets." , "X.Urine." , "X.Weight." , "X.Mg..1", " X.ICUType.", " X.MechVent.")
colnames(Ranges2)<-paste(M , sep="")

SubsetB<-subset(VarLog, select=c( X.ICUType., X.MechVent.))
DataOut4<-data.frame(cbind(DataOut3, SubsetB))

#Missing Values 2
Val=DataOut4
for(j in 1:ncol(DataOut4)){
for (i in 1:nrow(DataOut4)){
if(is.na(DataOut4[i,j])==TRUE){
Val[i,j]<-Ranges2[1,j]}
else
{Val[i,j]<-Val[i,j]}}
}

SubsetC<-subset(VarLog, select=c( X.RecordID.))
Val2<-data.frame(cbind(Val, SubsetC))

#Logistic Model
attach(Val2, warn.conflicts=FALSE)
LogModel1<- 0.24700*X.Age. -0.10596*X.DiasABP. -1.14655* X.GCS. + 0.06563* X.HCO3. + 0.10478*X.HCT. +0.31262* X.HR. -0.07651*X.K. + 
   -0.13791* X.NIDiasABP. -0.13281* X.Na. -0.35529*X.Temp. -0.33219* X.BUN..1 + 0.19644* X.Creatinine..1 + 0.08843*X.DiasABP..1 + 
    0.83896*X.GCS..1  -0.26208*X.Glucose..1 + 0.21503*X.HCO3..1 -0.13543* X.HCT..1  -0.16196*X.HR..1 + 0.20817*X.NIDiasABP..1  -0.21593*X.Na..1  -0.19061*X.PaCO2..1 +0.26140*X.Temp..1  -0.06916*X.WBC..1 + 0.64054*X.BUN.  -0.13759*X.Creatinine. + 
    0.20441*X.Glucose. + 0.24079*X.Lactate.  -0.15721*X.PaO2.  -0.09627*X.Platelets.  -0.26113*X.Urine.  -0.23382*X.Weight.  -0.06223*X.Mg..1 + 
     0.21225*X.ICUType.  -0.69089*X.MechVent.
Y=LogModel1
Yhat<-exp(Y)/(1+exp(Y))
Threshold1= 0.7816000
Fitted<- ifelse(Yhat>Threshold,1,0)




################################
a=t24
tropmodel=0
alpmodel=0
lacmodel=0
generalmodel=0
lacm=0
alpm=0
tropm=0
tropalpm=0
troplacm=0
alplacm=0
allm=0

y2=exp(y)/(1+exp(y))
LogModel2=exp(LogModel)/(1+exp(LogModel))
LogModel12=exp(LogModel1)/(1+exp(LogModel1))
y12=exp(y1)/(1+exp(y1))

if(!is.na(a$X.TroponinI.) || !is.na(a$X.TroponinT.))
{  tropmodel=1  }

if (!is.na(a$X.ALP.))
{ alpmodel=1}

if (!is.na(a$X.Lactate. ))
{ lacmodel=1}

if (tropmodel==0 & alpmodel==0 & lacmodel==0)
{  
thresh1=0.28
w=c(0,	0,	0.54,	0.46)



ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}

}

if (tropmodel==0 & alpmodel==0 & lacmodel==1)
{  
thresh1=0.28
w=c(0,	0.5,	0,	0.5)
ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}

}


if (tropmodel==1 & alpmodel==0 & lacmodel==0)
{  
thresh1=0.28
w=c(0.34,	0,	0,	0.66)
ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}


}

if (tropmodel==0 & alpmodel==1 & lacmodel==0)
{  
thresh1=0.3362
w=c(0,0,0.42,0.58)
ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}

}


if (tropmodel==1 & alpmodel==1 & lacmodel==0)
{ w=c(0,	0,	0.82,	0.18)

thresh1=0.3362
ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}

}


if (tropmodel==1 & alpmodel==0 & lacmodel==1)
{ 
thresh1=0.28 
w=c(0,	0,	0.54,	0.46)
ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}


}


if (tropmodel==0 & alpmodel==1 & lacmodel==1)
{ w=c(0,	0.58,	0,	0.42)
thresh1=0.3362
ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}

}


if (tropmodel==1 & alpmodel==1 & lacmodel==1)
{  w=c(0,	0,	0.84,	0.16)
thresh1=0.3362
ab1=w[1]*y2+w[2]*LogModel2+w[3]*y12+w[4]*LogModel12
ab=ab1
thresh=w[1]*threshold+w[2]*Threshold+w[3]*thresh1+w[4]*Threshold1
predict=0
if (ab >= thresh)
{predict=1}

}

#############################

#*******************************************************************************Alireza***********************************


cat(sprintf("%i,%i,%f\n", patientRecordID, predict, ab));





