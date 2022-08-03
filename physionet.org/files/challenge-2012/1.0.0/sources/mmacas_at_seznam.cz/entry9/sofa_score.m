function [SOFA_SCORE]=sofa_score(varargin)
% [SOFA_SCORE]=sofa_score(tm,category,val,truncated)
%
% Calculates SOFA scores. Variables are:
%
%tm      - (Nx1 Cell Array) Cell array containing time of measurement
%category- (Nx1 Cell Array) Cell array containing type (category)
%           measurement
%value   - (Nx1 Cell Array) Cell array containing value of measurement
%truncated - (Logical) Optional flag, if true, will attempt to calculate
%             "truncated" SOFA even if some of the input variables are
%             missing. Default is 0 (false) .
% SAP_SCORE - (Scalar) Value between 0 and 56 representing the severity of
%             the patient's status (higher scores are worse).  A NaN
%             value is returned along with a warning message if the SOFA
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

%SOFA variable names
SOFA={{'NIMAP'},{'PaO2','FiO2','MechVent'},{'Creatinine'},...
    {'Bilirubin'},{'Platelets'},{'GCS'}};

MX_SOFA=56; %Max SOFA value

%Convert SOFA info into tables [min range, max range, SOFA score;...]
%Also convert the units in the table to match the units of the data
MechVent=49; %Equivalent to a RespRate that will yield a SOFA value of 3
PaO2 = [401,10000,0;301,400,1;201,300,2;101,200,3;0,100,4];
Platelets = [151,10000,0;101,150,1;51,100,2;21,50,3;0,20,4];
Bilirubin = [0,1.2,0;1.21,1.9,1;2,5.9,2;6,11.9,3;12,1000,4];
NIMAP = [0,70,1];
GCS=[14.9,15,0;13,14,1;10,12,2;6,9,3;0,5,4];
Creatinine = [0,1.19,0;1.2,1.9,1;2,3.4,2;3.5,4.9,3;5,2000,4];


%Only use data for the first 32 hrs (standard SOFA)
tm=cell2mat(tm);
fr_data=find(str2num(tm(:,1:2))<48);
val=val(fr_data);
tm=tm(fr_data);
category=category(fr_data);

%Loop through all SOFA variables, adding risk points to SOFA_SCORE according to their tables
SOFA_SCORE=NaN;
for s=1:length(SOFA)
    %Get data for the selected category only (If more than one name exist for the variables, merge data)
    sofa_var=SOFA{s};
    sig_ind= val.*0;
    eval(['table=' regexprep(sofa_var{1},' ','_') ';'])
    for i=1:length(sofa_var)
        sig_ind=sig_ind | strcmp(sofa_var(i),category);
    end
    tmp_data=val(sig_ind);
    
    if(strcmp(sofa_var{1},'PaO2'))
        %For Respiration, check Mechanical Ventilation flag
        %If subject is on ventillation, this is equivalent to having a
        %RespRate that will yield a SOFA value of 3
        tmp_category=category(sig_ind);
        mech_vent_ind=find(strcmp(sofa_var(2),tmp_category)==1);
        if(~isempty(mech_vent_ind) && any(mech_vent_ind))
            tmp_data=MechVent;
        else
           tmp_category=category(sig_ind);
           indx = find(sig_ind);
           FiO2_ind=find(strcmp(sofa_var(3),tmp_category)==1);
           PaO2_ind=find(strcmp(sofa_var(1),tmp_category)==1);
           for m = 1:length(PaO2_ind)
                for n = 1:length(FiO2_ind)
                    tmp_data(end+1) = val(indx(PaO2_ind(m)))/(val(indx(FiO2_ind(n)))+eps);
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
            warning(['No SOFA score for variable ' sofa_var{:} '... exiting.'])
            SOFA_SCORE=NaN;
            break
        else
            warning(['No variable ' sofa_var{:} '... attempting truncated SOFA.'])
        end
    else
        mn=nanmin(tmp_data);
        mn_sofa_ind=find( ( mn(1) >= table(:,1) & mn(1) <= table(:,2) ) ==1);
        mn_sofa_val=table(mn_sofa_ind,3);
        if isempty(mn_sofa_val), mn_sofa_val = 0; end
        mx=nanmax(tmp_data);
        mx_sofa_ind=find( ( mx(1) >= table(:,1) & mx(1) <= table(:,2) ) ==1);
        mx_sofa_val=table(mx_sofa_ind,3);
        if isempty(mx_sofa_val), mx_sofa_val = 0; end
        %Add worst case scenario to SOFA SCORE
        if(isnan(SOFA_SCORE))
            SOFA_SCORE= nanmax(mn_sofa_val,mx_sofa_val);
        else
            SOFA_SCORE= SOFA_SCORE + nanmax(mn_sofa_val,mx_sofa_val);
        end
    end
end

if isnan(SOFA_SCORE), SOFA_SCORE = MX_SOFA; end % if all data is missing


