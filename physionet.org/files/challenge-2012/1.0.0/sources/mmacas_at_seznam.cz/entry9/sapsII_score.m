function [SAPS_SCORE]=saps_scoreII(varargin)
% [SAPS_SCORE]=saps_score(tm,category,val,truncated)
%
% Calculates SAPS scores. Variables are:
%
%tm      - (Nx1 Cell Array) Cell array containing time of measurement
%category- (Nx1 Cell Array) Cell array containing type (category)
%           measurement
%value   - (Nx1 Cell Array) Cell array containing value of measurement
%truncated - (Logical) Optional flag, if true, will attempt to calculate
%             "truncated" SAPS even if some of the input variables are
%             missing. Default is 0 (false) .
% SAP_SCORE - (Scalar) Value between 0 and 56 representing the severity of
%             the patient's status (higher scores are worse).  A NaN
%             value is returned along with a warning message if the SAPS
%             score cannot be calculated.
%
% Written by Ikaro Silva, 2012
%
% Version 1.0
%
% Reference:
% Gall et al, "A simplified acute physiology score for ICU patients",
% Critical Care Medicine (1984), 12(11).

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

%SAPS variable names
SAPSII={{'Age'},{'HR'},{'NiSysABP'},{'Temp'},...
    {'PaO2','MechVent','FiO2'},{'Urine'},{'BUN'},{'WBC'},...
    {'K'},{'Na'},{'HCO3'},{'Billirubin'},{'GCS'}};

MX_SAPS=56; %Max SAPS value

%Convert SAPS info into tables [min range, max range, SAPS score;...]
%Also convert the units in the table to match the units of the data
Age=[0,39,0;40,59,7;60,69,12;70,74,15;75,79,16;80,200,18];
HR=[0,39,11;40,69,2;70,119,0;120,159,4;160,1000,7];
NiSysABP=[0,69,13;70,99,5;100,199,0;200,10000,2];
Temp=[0,38.99,0;39,100,3];
PaO2 = [0,99.99,11;100,199,9;200,10000,6];
Urine = [0,0.499,0.011;0.5,0.999,0.004;1,100,0].*1000;
BUN = [0,27.99,0;28,83,6;84,10000,10];
WBC = [0,0.99,12;1,19.9,0;20,10000,3];
K = [0,2.99,3;3,4.9,0;5,10000,3];
Na = [0,124.99,5;125,144,0;145,100000,1];
HCO3 = [0,14.99,6;15,19,3;20,10000,0];
Billirubin = [0,3.99,0;4,5.9,4;6,10000,9];
GCS = [3,5,26;6,8,13;9,10,7;11,13,5;14,15,0];

%Only use data for the first 24 hrs (standard SAPS)
tm=cell2mat(tm);
fr_data=find(str2num(tm(:,1:2))<24);
val=val(fr_data);
tm=tm(fr_data);
category=category(fr_data);

%Loop through all SAPS variables, adding risk points to SAPS_SCORE according to their tables
SAPS_SCORE=NaN;
for s=1:length(SAPSII)
    %Get data for the selected category only (If more than one name exist for the variables, merge data)
    saps_var=SAPSII{s};
    sig_ind= val.*0;
    eval(['table=' regexprep(saps_var{1},' ','_') ';'])
    for i=1:length(saps_var)
        sig_ind=sig_ind | strcmp(saps_var(i),category);       
    end
    tmp_data=val(sig_ind);


    
    if(strcmp(saps_var{1},'PaO2'))
        
        tmp_category=category(sig_ind);
        mech_vent_ind=find(strcmp(saps_var(2),tmp_category)==1);
        PaO2_ind=find(strcmp(saps_var(1),tmp_category)==1);
        FiO2_ind=find(strcmp(saps_var(3),tmp_category)==1);
        
        if(~isempty(mech_vent_ind) && any(mech_vent_ind) && ~isempty(PaO2_ind) && any(PaO2_ind) && ~isempty(FiO2_ind) && any(FiO2_ind))
            
            tmp_data = min(tmp_data(PaO2_ind))/max(tmp_data(FiO2_ind)); %PaO2/FiO2
            
        else
            tmp_data=[];
        end
    end
    if(strcmp(saps_var{1},'Urine'))
        %For Urine output, get cumulative over 24hrs
        tmp_data=sum(tmp_data);
    end
    
    %Set out of bound values to NaN
    tmp_data(tmp_data < min(table(:,1)))=NaN;
    tmp_data(tmp_data > max(table(:,2)))=NaN;
    %Get the lowest and highest values for the measured variable
    if(all(isnan(tmp_data)) || isempty(tmp_data))
        if(~truncated)
            warning(['No SAPS score for variable ' saps_var{:} '... exiting.'])
            SAPS_SCORE=NaN;
            break
        else
            warning(['No variable ' saps_var{:} '... attempting truncated SAPS.'])
        end
    else     

            mn=nanmin(tmp_data);
            mn_saps_ind=find( ( mn(1) >= table(:,1) & mn(1) <= table(:,2) ) ==1);
            mn_saps_val=table(mn_saps_ind,3);
            if isempty(mn_saps_val), mn_saps_val = 0; end
            mx=nanmax(tmp_data);
            mx_saps_ind=find( ( mx(1) >= table(:,1) & mx(1) <= table(:,2) ) ==1);
            mx_saps_val=table(mx_saps_ind,3);
            if isempty(mx_saps_val), mx_saps_val = 0; end
        
        %Add worst case scenario to SAPS SCORE
        if(isnan(SAPS_SCORE))
            SAPS_SCORE= nanmax(mn_saps_val,mx_saps_val);
        else
            SAPS_SCORE= SAPS_SCORE + nanmax(mn_saps_val,mx_saps_val);
        end
    end
end


