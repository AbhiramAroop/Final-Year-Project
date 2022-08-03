function [risk,prediction]=physionet_CCC(time,param,value)
% [risk,prediction]=physionet2012(time,param,value)
% 
% time       - (Nx1 Cell Array) Cell array containing time of measurement
% param      - (Nx1 Cell Array) Cell array containing type (category) of
%               measurement
% value      - (Nx1 Cell Array) Cell array containing value of measurement
%
% 
% risk       - (Scalar) estimate of the risk of the patient dying in hospital
% prediction - (Logical)Binary classification if the patient is going to die
%               in the hospital (1 - Died, 0 - Survived)
% 
% Example:
% [risk,prediction]=physionet2012(time,param,value)
% 
% Written by Chih-Chun Chia, 2012
% 
% Version 1.1
%
 
%TH=0.265; %Threshold for classifying the patient as non-survivor

tm = time;
category = param;
val = value;
load('B.mat');

AllVars = {{'Age'},{'Height', 'Weight'},{'ICUType'}, {'Albumin'},{'ALP'}, {'ALT'}, ...
            {'AST'}, {'Bilirubin'},{'BUN'},{'Creatinine'}, {'DiasABP'},{'FiO2'},{'GCS'},...
            {'Glucose'},{'HCO3'},{'HCT'},{'HR'},{'K'},{'Lactate'}, {'Mg'}, {'MAP'},...
            {'Na'},{'NIDiasABP'},{'NIMAP'},{'NISysABP'},{'PaCO2'},...
            {'PaO2'},{'pH'},{'Platelets'},{'RespRate','MechVent'},{'SaO2'},{'SysABP'},{'Temp'},...
            {'Urine'},{'WBC'}};
			
		UsefulVars = {{'Age'},{'Height', 'Weight'},{'ICUType'}, {'HR'}, {'Bilirubin'},{'BUN'},{'pH'},...
			{'Urine'},{'WBC'},{'Platelets'},{'HCT'},{'Creatinine'},{'Na'},{'K'},{'HCO3'},...
			{'RespRate','MechVent'},{'Temp'},{'GCS'},{'FiO2'},{'PaO2'},...
            {'DiasABP'},{'MAP'},{'NIDiasABP'},{'NIMAP'},{'NISysABP'},{'SysABP'}};
        AllVars = UsefulVars;
        
features = zeros(1,length(AllVars));

for s=1:length(AllVars)
    %Get data for the selected category only (If more than one name exist for the variables, merge data)
	saps_var=AllVars{s};
	sig_ind= val.*0;
	for i=1:length(saps_var)
		sig_ind=sig_ind | strcmp(saps_var(i),category);
	end
	tmp_data=val(sig_ind);

	if(strcmp(saps_var{1},'RespRate'))
		tmp_category=category(sig_ind);
		mech_vent_ind=find(strcmp(saps_var(2),tmp_category)==1);
		if(~isempty(mech_vent_ind) && any(mech_vent_ind))
			tmp_data=49;
		end
	end

	if(strcmp(saps_var{1},'Height'))
		if (tmp_data(2) == -1 || tmp_data(1) == -1)
			tmp_data = NaN;
		else
			tmp_data = tmp_data(2) / (tmp_data(1)/100)^2;
		end
	end
	features(s) = mean(tmp_data);
	
	if (isnan(features(s))) 
		features(s) = MeanFeat(s);
	end
end


features = (features - Feature_Min)*Feature_ScaleRatio;

probs = mnrval(B, features);
risk = kernel_calibrate(probs(:,2)', dec_value', IHD', besth);
prediction=(risk>TH);

