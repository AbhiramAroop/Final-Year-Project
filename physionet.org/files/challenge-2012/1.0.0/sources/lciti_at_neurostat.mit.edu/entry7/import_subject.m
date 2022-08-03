function subj = import_subject(tm, category, val, IHD)

fields =  {'RecordID' 'Age' 'Gender' 'Height' 'ICUType' ... % Descriptors
    'ALP' 'ALT' 'AST' 'Albumin' 'BUN' 'Bilirubin' ... % Time Series
    'Creatinine' 'DiasABP' 'FiO2' 'GCS' 'Glucose' 'HCO3' 'HCT' 'HR' ...
    'K' 'Lactate' 'MAP' 'MechVent' 'Mg' 'NIDiasABP' 'NIMAP' 'NISysABP' ...
    'Na' 'PaCO2' 'PaO2' 'Platelets' 'SaO2' 'SysABP' 'Temp' 'Urine' ...
    'WBC' 'Weight' 'pH'};


% convert timestamp from hh:mm to seconds
sec = ([3600 60] * sscanf(cell2mat(tm'), '%2d:%2d', [2 inf]))';

% all meaningful measures are positive, if negative set to NaN
val(val < 0) = NaN;

% import all fields
for i = 1:length(fields)
    field = fields{i};
    ix = find(strcmpi(field, category));
    rec.(field) = [sec(ix(:)) val(ix(:))];
end

% Fields w/ ad-hoc processing
rec.CumUrine = [rec.Urine(:,1) cumsum(rec.Urine(:,2))];
rec.DiasABP = sortrows([rec.DiasABP; rec.NIDiasABP]);
rec.MAP = sortrows([rec.MAP; rec.NIMAP]);
rec.SysABP = sortrows([rec.SysABP; rec.NISysABP]);
rec = rmfield(rec, {'NIDiasABP' 'NIMAP' 'NISysABP'});
%%% rec.Age = max(rec.Age, 100); % Age 200 means 90+, set it at 100  %%%LC WRONG
rec.Age = min(rec.Age, 100); % Age 200 means 90+, set it at 100
rec = rmfield(rec, 'MechVent'); % They all are under mechanical ventilation, nothing to learn from this field


% Descriptors
subj.RecordID = rec.RecordID(1,2);
subj.Desc.Age = rec.Age(1,2);
subj.Desc.Gender = rec.Gender(1,2);
subj.Desc.Height = rec.Height(1,2);

subj.Desc.ICUType1 = 0;
subj.Desc.ICUType2 = 0;
subj.Desc.ICUType3 = 0;
subj.Desc.ICUType4 = 0;
subj.Desc.(sprintf('ICUType%d', rec.ICUType(1,2))) = 1;

% Time Series
rec = rmfield(rec, {'RecordID' 'Age' 'Gender' 'Height' 'ICUType'});
subj.TSeries = rec;

if nargin >= 4
    subj.IHD = IHD;
end
