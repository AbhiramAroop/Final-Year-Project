function [APACHE_SCORE]=apacheI_score(varargin)
% [APACHE_SCORE]=apache_score(tm,category,val,truncated)
%
% Calculates APACHE scores. Variables are:
%
%tm      - (Nx1 Cell Array) Cell array containing time of measurement
%category- (Nx1 Cell Array) Cell array containing type (category)
%           measurement
%value   - (Nx1 Cell Array) Cell array containing value of measurement
%truncated - (Logical) Optional flag, if true, will attempt to calculate
%             "truncated" APACHE even if some of the input variables are
%             missing. Default is 0 (false) .
% SAP_SCORE - (Scalar) Value between 0 and 56 representing the severity of
%             the patient's status (higher scores are worse).  A NaN
%             value is returned along with a warning message if the APACHE
%             score cannot be calculated.
%
% Jakub Kuzilek, 2012
%
% Based on Ikaro Silva saps_score function.
%
% Version 1.0

truncated=0;
inputs={'tm','category','val','truncated'};
for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end

if iscell(val)
    for m = 1:length(val)
        val{m} = str2num(val{m});
    end
    val=cell2mat(val);
end

%APACHE variable names
APACHE={{'HR'},{'NIMAP'},{'Lactate'},{'pH'},{'RespRate','MechVent'},...
    {'PaO2'},{'PaCO2'},{'Urine'},{'BUN'},{'Creatinine'},{'Albumin'},...
    {'Bilirubin'},{'ALP'},{'HCT'},{'WBC'},{'Platelets'},{'Temp'},...
    {'Glucose'},{'Na'},{'K'},{'HCO3'},{'GCS'}};

MX_APACHE=56; %Max APACHE value

%Convert APACHE info into tables [min range, max range, APACHE score;...]
%Also convert the units in the table to match the units of the data
HR=[180,250,4; 141,179,3;111,140,2;70,110,0;56,69,2;41,55,3;0,40,4];
NIMAP = [160,400,4;131,159,3;111,130,2;70,110,0;51,69,2;0,50,4];
Lactate = [8,20,4;3.5,7.9,3;0,3.4,0];
pH = [7.7,14,4;7.6,7.69,3;7.51,7.59,1;7.33,7.5,0;7.25,7.32,2;7.15,7.24,3;0,7.14,4];
RespRate=[50,80,4;35,49,3;26,34,2;12,25,0;10,11,1;7,9,2;0,6,4];
MechVent=49; %Equivalent to a RespRate that will yield a APACHE value of 3
PaO2 = [500,10000,4;351,499,3;200,350,1;0,199,0];
PaCO2 = [70,1000,4;61,69,3;50,60,2;30,49,0;25,29,2;20,24,3;0,19,4];
Urine=[5000,100000,2;3501,4999,1;700,3500,0;480,699,2;120,479,3;0,119,4]; %Convert from L to mL
BUN = [150,400,4;101,149,3;81,100,2;21,80,1;10,20,0;0,9,1];
Creatinine = [7,20,4;3.6,6.9,3;2.1,3.5,2;1.6,2,1;0.6,1.5,0;0,0.59,1];
Albumin = [8,40,4;3.5,7.9,0;2.5,3.4,1;0,2.4,2];
Bilirubin = [15,100,3;5.1,14.9,1;0,5,0];
ALP = [160,10000,1;0,159,0];
HCT =[60,1000;51,59;47,50;30,46;20,29;0,19];
HCT(:,3) = [4;2;1;0;2;4];
WBC=[40001,100000;20001,40000;15001,20000;3000,15000;1000,2999;0,999]/1000;
WBC(:,3)=[4;2;1;0;2;4];
Platelets = [1000000,10000000;600001,999999;80000,599999;20000,79999;0,19999]/1000;
Platelets(:,3) = [2;1;0;2;4];
Temp=[41,50,4;39.1,40.9,3;38.6,39,1;36,38.5,0;34,35.9,1;32,33.9,2;30,31.9,3;0,29.9,4];
Glucose=[800,10000,4;500,799,3;251,499,1;70,250,0;50,69,2;30,49,3;0,29,4];
Na=[180,1000,4;161,179,3;156,160,2;151,155,1;130,150,0;120,129,2;110,119,3;0,109,4];
K=[7,100,4;6.1,6.9,3;5.6,6,1;3.5,5.5,0;3,3.4,1;2.5,2.9,2;0,2.4,4];
HCO3=[40,200,3;31,39,1;20,30,0;10,19,1;5,9,3;0,4.9,4];
GCS=[0,3,4;4,6,3;7,9,2;10,12,1;13,15,0];

%Only use data for the first 32 hrs (standard APACHE)
tm=cell2mat(tm);
fr_data=find(str2num(tm(:,1:2))<32);
val=val(fr_data);
tm=tm(fr_data);
category=category(fr_data);

%Loop through all APACHE variables, adding risk points to APACHE_SCORE according to their tables
APACHE_SCORE=NaN;
for s=1:length(APACHE)
    %Get data for the selected category only (If more than one name exist for the variables, merge data)
    apache_var=APACHE{s};
    sig_ind= val.*0;
    eval(['table=' regexprep(apache_var{1},' ','_') ';'])
    for i=1:length(apache_var)
        sig_ind=sig_ind | strcmp(apache_var(i),category);
    end
    tmp_data=val(sig_ind);
    
    if(strcmp(apache_var{1},'RespRate'))
        %For Respiration, check Mechanical Ventilation flag
        %If subject is on ventillation, this is equivalent to having a
        %RespRate that will yield a APACHE value of 3
        tmp_category=category(sig_ind);
        mech_vent_ind=find(strcmp(apache_var(2),tmp_category)==1);
        if(~isempty(mech_vent_ind) && any(mech_vent_ind))
            tmp_data=MechVent;
        end
    end
    if(strcmp(apache_var{1},'Urine'))
        %For Urine output, get cumulative over 24hrs
        tmp_data=sum(tmp_data);
    end
    
    %Set out of bound values to NaN
    tmp_data(tmp_data < min(table(:,1)))=NaN;
    tmp_data(tmp_data > max(table(:,2)))=NaN;
    %Get the lowest and highest values for the measured variable
    if(all(isnan(tmp_data)) || isempty(tmp_data))
        if(~truncated)
            warning(['No APACHE score for variable ' apache_var{:} '... exiting.'])
            APACHE_SCORE=NaN;
            break
        else
            warning(['No variable ' apache_var{:} '... attempting truncated APACHE.'])
        end
    else
        mn=nanmin(tmp_data);
        mn_apache_ind=find( ( mn(1) >= table(:,1) & mn(1) <= table(:,2) ) ==1);
        mn_apache_val=table(mn_apache_ind,3);
        if isempty(mn_apache_val), mn_apache_val = 0; end
        mx=nanmax(tmp_data);
        mx_apache_ind=find( ( mx(1) >= table(:,1) & mx(1) <= table(:,2) ) ==1);
        mx_apache_val=table(mx_apache_ind,3);
        if isempty(mx_apache_val), mx_apache_val = 0; end
        %Add worst case scenario to APACHE SCORE
        if(isnan(APACHE_SCORE))
            APACHE_SCORE= nanmax(mn_apache_val,mx_apache_val);
        else
            APACHE_SCORE= APACHE_SCORE + nanmax(mn_apache_val,mx_apache_val);
        end
    end
end


