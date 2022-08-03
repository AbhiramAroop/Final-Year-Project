function [APACHE_SCORE]=apacheIII_score(varargin)
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
APACHE={{'Age'},{'HR'},{'NIMAP'},{'Temp'},{'RespRate','MechVent'},...
    {'PaO2','FiO2'},{'HCT'},{'WBC'},{'Creatinine'},{'Urine'},{'BUN'},{'Na'},...
    {'Albumin'},{'Bilirubin'},{'Glucose'},{'pH','PaCO2'}};

MX_APACHE=56; %Max APACHE value

%Convert APACHE info into tables [min range, max range, APACHE score;...]
%Also convert the units in the table to match the units of the data
Age = [0,44,0;45,59,5;60,64,11;65,69,13;70,74,16;75,84,17;85,200,24];
 %HR=[140,1000,10;130,139,9;120,129,7; 100,119,4;80,99,0;70,79,6;60,69,7;40,59,15;0,39,8];%ERR 
HR = [0,39,8;40,49,5;50,99,0;100,109,1;110,119,5;120,139,7;140,154,13;155,1000,17];% by Tade
 %NIMAP = [160,400,4;130,159,3;110,129,2;70,109,0;50,69,2;0,49,4];%ERR
NIMAP = [0,39,23;40,59,15;60,69,7;70,79,6;80,99,0;100,119,4;120,129,7;130,139,9;140,1000,10]; %by Tade
% Temp = [40,50,10;36,36.9,0;35,35.9,2;34,34.9,8;33.5,33.9,13;33,33.4,16;30,32.9,20]; 
Temp = [40,50,4;36,36.9,0;35,35.9,2;34,34.9,8;33.5,33.9,13;33,33.4,16;30,32.9,20]; %by Tade 'inverse'
 %RespRate=[50,2000,18;40,49,11;35,39,9;25,34,6;14,24,0;11,13,7;6,10,8;0,5,17];
RespRate=[50,2000,18;40,49,11;35,39,9;25,34,6;14,24,0;12,13,7;6,11,8;0,5,17];%by Tade 'inverse'
MechVent=49; %Equivalent to a RespRate that will yield a APACHE value of 3
FiO2 = 49;
PaO2 = [80,1000,0;70,79,2;50,69,5;0,49,15]; %'inverse'
HCT =[0,40.9,3;41,49,0;50,1000,3];
WBC=[0,1;1.1,2.9;3,19.9;20,24.9;25,100000];
WBC(:,3)=[19;5;0;1;5];
Creatinine = [0,0.4,3;0.5,1.4,0;1.5,1.94,4;1.95,1000,7];
Urine = [0,399,15;400,599,8;600,899,7;900,1499,5;1500,1999,4;2000,3999,0;4000,50000,1];
BUN = [0,16.9,0;17,19,2;20,39,7;40,79,11;80,1000,12];
Na=[0,119,3;120,134,2;135,154,0;155,10000,4];
Albumin = [0,1.9,11;2,2.4,6;2.5,4.4,0;4.5,1000,4];
Bilirubin = [0,1.9,0;2,2.9,5;3,4.9,6;5,7.9,8;8,1000,16];
Glucose = [0,39,8;40,59,9;60,199,0;200,349,3;350,10000,5];

pH = [0,7.19,1;7.2,7.29,2;7.3,7.34,3;7.35,7.44,4;7.45,7.49,5;7.5,7.65,6;7.65,1000,7];
PaCO2 = [0,24.9,1;25,29.9,2;30,34.9,3;35,44.9,4;45,49.9,5;50,1000,6];

pHPaCO2 = [12 12 12 12 12 4; 9 9 6 3 3 2; 9 9 0 0 1 1; 5 5 0 0 1 1; 5 5 0 2 12 12; 3 3 3 12 12 12; 0 3 3 12 12 12];



%Only use data for the first 24 hrs (standard APACHE II)
tm=cell2mat(tm);
fr_data=find(str2num(tm(:,1:2))<24);
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
    
    if(strcmp(apache_var{1},'PaO2'))
        
        %For Respiration, check Mechanical Ventilation flag
        %If subject is on ventillation, this is equivalent to having a
        %RespRate that will yield a APACHE value of 3
        tmp_category=category(sig_ind);
        FIO2_ind = find(strcmp(apache_var(2),tmp_category)==1);
        if(~isempty(FIO2_ind) && any(FIO2_ind))
            if(max(val(FIO2_ind)) >= 0.5)
                tmp_data=[];
            end
        end
    end
    
    
    if(strcmp(apache_var{1},'pH'))
        %For Respiration, check Mechanical Ventilation flag
        %If subject is on ventillation, this is equivalent to having a
        %RespRate that will yield a APACHE value of 3
        tmp_category=category(sig_ind);
        indx = find(sig_ind);
        pH_ind = find(strcmp(apache_var(1),tmp_category)==1);
        PaCO2_ind = find(strcmp(apache_var(2),tmp_category)==1);
        if(~isempty(PaCO2_ind) && any(PaCO2_ind) && ~isempty(pH_ind) && any(pH_ind))
            tmp_data = [];
            for m = 1:length(pH_ind)
                for n = 1:length(PaCO2_ind)
                    tmp_data(end+1) = pHPaCO2(pH(find(val(indx(pH_ind(m))) >= pH(:,1) & val(indx(pH_ind(m))) <= pH(:,2),1),3),PaCO2(find(val(indx(PaCO2_ind(n))) >= PaCO2(:,1) & val(indx(PaCO2_ind(n))) <= PaCO2(:,2),1),3));
                end
            end
            tmp_data = tmp_data';
            
        end
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
        if(~strcmp(apache_var{1},'pH'))
            mn=nanmin(tmp_data);
            mn_apache_ind=find( ( mn(1) >= table(:,1) & mn(1) <= table(:,2) ) ==1);
            mn_apache_val=table(mn_apache_ind,3);
            if isempty(mn_apache_val), mn_apache_val = 0; end
            mx=nanmax(tmp_data);
            mx_apache_ind=find( ( mx(1) >= table(:,1) & mx(1) <= table(:,2) ) ==1);
            mx_apache_val=table(mx_apache_ind,3);
            if isempty(mx_apache_val), mx_apache_val = 0; end
        else
            mn_apache_val = nanmin(tmp_data);
            mx_apache_val = nanmax(tmp_data);
        end
        %Add worst case scenario to APACHE SCORE
        if(isnan(APACHE_SCORE))
            APACHE_SCORE= nanmax(mn_apache_val,mx_apache_val);
        else
            APACHE_SCORE= APACHE_SCORE + nanmax(mn_apache_val,mx_apache_val);
        end
    end
end


