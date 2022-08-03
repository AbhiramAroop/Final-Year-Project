function [risk,prediction]=physionet2012(tm,category,val)

%   ,___,
%   [O.o]
%   /)__)
%   -"--"-

% Full list of parameters of interest
category_names = {{'Age'},{'Albumin'},{'ALP'},{'ALT'},{'AST'},{'Bilirubin'},{'BUN'},{'Cholesterol'},... % 1-8
    {'Creatinine'},{'DiasABP', 'NIDiasABP'},{'FiO2'},{'GCS'},{'Gender'},{'Glucose'},{'HCO3'},...        % 9-15
    {'HCT'},{'Height'},{'HR'},{'ICUType'},{'K'},{'Lactate'},{'Mg'},{'MAP','NIMAP'},{'MechVent'},...     % 16-24
    {'Na'},{'SysABP','NISysABP'},{'PaCO2'},{'PaO2'},{'pH'},{'Platelets'},...                            % 25-30
    {'RespRate'},{'SaO2'},{'Temp'},{'Urine'},{'WBC'},{'Weight'}};                                       % 33-36

% Array to populate with values for the NN
NN_input_scalar = [];

% Loop through each parameter (e.g. HR)
for i=1:length(category_names);
    
    % Get data for the selected parameter
    cat_name = category_names{i}; %select parameter
    val_index = ismember(category,cat_name); % create index for parameter
    cat_val = val(val_index); % select corresponding values
    cat_time = tm(val_index); % select corresponding times

    % Remove duplicate times
    [c,uniq_tm_index] = (unique(cat_time));
    cat_time = cat_time(uniq_tm_index);
    cat_val = cat_val(uniq_tm_index);

    % Filter to remove weirdy values
 	[phys_filter_table] = phys_filter(cat_name);
    cat_val(cat_val < min(phys_filter_table(:,1))) = NaN;
    cat_val(cat_val > max(phys_filter_table(:,2))) = NaN;

    % Convert weight to BMI
    if strcmp(cat_name,'Weight');
        height = nanmean(val(ismember(category,'Height')));
        if isnan(height) | height == -1 
            height = 158;
        end
        cat_val = cat_val./((height/100)^2);
    end
    
    % Analyse the parameter and add the results to the NN_input_scalar
    if strcmp('ICUType', cat_name) | strcmp('Height', cat_name);
        % ignore these parameters
    else
        % remaining parameters are processed here
        [mean_val] = phys_mean(cat_time, cat_val, phys_filter_table);
        [chi_var]=phys_chi_like_var(cat_time, cat_val, phys_filter_table);
        [grad_moments]=phys_tm_deriv_moment(cat_time, cat_val, phys_filter_table);
        [nanoflares]=phys_nanoflare(cat_time, cat_val, phys_filter_table);
        NN_input_scalar = [NN_input_scalar, mean_val, chi_var, grad_moments, nanoflares];
    end
    clear('mean_val','chi_var','grad_moments','nanoflares');
end

% Selected columns to input to neural net
select_index5 = [1,11,21,31,41,51,61,71,81,91,98,101,106,111, ...
113,131,141,155,169,171,181,191,201,209,211,226,231,232,241, ...
251,262,276,281,292,301,312,321,337];

NN_input_scalar = NN_input_scalar(:,select_index5);

% Choose net by ICU
if val(ismember(category,'ICUType')) == 1; % Coronary Care Unit
    load('net_SUB5_ICU1.mat');
elseif val(ismember(category,'ICUType')) == 2; % Cardiac Surgery Recovery Unit
    load('net_SUB5_ICU2.mat');
elseif val(ismember(category,'ICUType')) == 3; % Medical ICU 
    load('net_SUB5_ICU3.mat');
elseif val(ismember(category,'ICUType')) == 4; % Surgical ICU
    load('net_SUB5_ICU4.mat');
else % Catch unknown ICU type
 	load('net_SUB5_ICU3.mat'); 
end

% Process NN_input_scalar
NN_output = sim(net_sub5, NN_input_scalar');

% Check the result is sensible (in range and not a NaN) (+ INF!)
NN_output(isnan(NN_output)) = 0.25;

% Add risk and prediction based on result
risk = NN_output(1)
prediction = risk > 0.5 % Threshold for classifying patient as non-survivor

% EOF
