function [APACHE_SCORE]=apacheII_score(varargin)
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
APACHE={{'Age'},{'Temp'},{'NIMAP'},{'HR'},{'RespRate','MechVent'},...
    {'PaO2','FiO2'},{'pH'},{'Na'},{'K'},{'Creatinine'},{'HCT'},...
    {'WBC'},{'GCS'}};

MX_APACHE=56; %Max APACHE value

%Convert APACHE info into tables [min range, max range, APACHE score;...]
%Also convert the units in the table to match the units of the data
Age = [0,44,0;45,54,2;55,64,3;65,74,5;75,200,6];
Temp=[41,50,4;39,40.9,3;38.5,38.9,1;36,38.4,0;34,35.9,1;32,33.9,2;30,31.9,3;0,29.9,4];
NIMAP = [160,400,4;130,159,3;110,129,2;70,109,0;50,69,2;0,49,4];
HR=[180,250,4; 140,179,3;110,139,2;70,109,0;55,69,2;40,54,3;0,39,4];
RespRate=[50,80,4;35,49,3;25,34,2;12,24,0;10,11,1;6,9,2;0,5,4];
MechVent=49; %Equivalent to a RespRate that will yield a APACHE value of 3
FiO2 = 2;
PaO2 = [70,1000,0;61,69,1;55,60,3;0,54,4];
pH = [7.7,14,4;7.6,7.69,3;7.5,7.59,1;7.33,7.49,0;7.25,7.32,2;7.15,7.24,3;0,7.14,4];
Na=[180,1000,4;160,179,3;155,159,2;150,154,1;130,149,0;120,129,2;111,119,3;0,110,4];
K=[7,100,4;6,6.9,3;5.5,5.9,1;3.5,5.4,0;3,3.4,1;2.5,2.9,2;0,2.4,4];
Creatinine = [3.5,20,4;2,3.4,3;1.5,1.9,2;0.6,1.4,0;0,0.59,2];
HCT =[60,1000,4;50,59.9,2;46,49.9,1;30,45.9,0;20,29.9,2;0,19.9,4];
WBC=[40001,100000;20001,40000;15001,20000;3000,15000;1000,2999;0,999]/1000;
WBC(:,3)=[4;2;1;0;2;4];
GCS=[3,3,12;4,4,11;5,5,10;6,6,9;7,7,8;8,8,7;9,9,6;10,10,5;11,11,4;12,12,3;13,13,2;14,14,1;15,15,0];



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
                tmp_data=FiO2;
            end
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


