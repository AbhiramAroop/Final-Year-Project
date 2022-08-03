function [M]=create_grid(varargin)

truncated=0;
inputs={'tm','category','val','truncated'};
for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end

features = {{'Albumin'},{'ALP'},{'ALT'},{'AST'},{'Bilirubin'},{'BUN'},...
        {'Cholesterol'},{'Creatinine'},{'DiasABP'},{'FiO2'},{'GCS'},{'Glucose'},...
        {'HCO3'},{'HCT'},{'HR'},{'K'},{'Lactate'},{'Mg'},{'MAP'},{'MechVent'},...
        {'Na'},{'NIDiasABP'},{'NIMAP'},{'NISysABP'},{'PaCO2'},{'PaO2'},{'pH'},...
        {'Platelets'},{'RespRate'},{'SaO2'},{'SysABP'},{'Temp'},{'TropI'},{'TropT'},...
        {'Urine'},{'WBC'}};

data = NaN(length(features),24);

tm=cell2mat(tm);
tm_mins=str2num(tm(:,1:2))*60 + str2num(tm(:,4:5));

for t=2:2:48
    fr_data_lower = find(tm_mins<t*60);
    fr_data_upper = find(tm_mins>=(t-2)*60);
    fr_data=intersect(fr_data_lower,fr_data_upper);
    tmp_val=val(fr_data);
    tmp_category=category(fr_data);

    for f=1:length(features)
        feat_var=features{f};
        sig_ind= tmp_val.*0;
        sig_ind= sig_ind | strcmp(feat_var,tmp_category);
        tmp_data=tmp_val(sig_ind);

        if(isempty(tmp_data))
            continue;
        else
            data(f,t/2) = mean(tmp_data);
        end
    end
end

M = data;