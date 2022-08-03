function [risk,prediction,recordFeatures]=physionet2012(time,param,value)
% [risk,prediction]=physionet2012(time,param,value)
% 
% Sample Submission for the PhysioNet 2012 Challenge. Variables are:
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

load('newmodel');
model.w = -model.w;
recordFeatures = [];
for v=1:length(kNames)
	values = [];
	for a=1:length(param)
		if strcmp(param{a},kNames{v})
			values(end+1) = value(a);
		end
	end
	if length(values) > 0
		recordFeatures = [ recordFeatures min(values) max(values) mean(values) var(values) values(end) ];
	else
		recordFeatures = [ recordFeatures 0 0 0 0 0 ];
	end
end
recordFeatures = (recordFeatures - avgs)./stds;
recordFeatures(find(isnan(recordFeatures))) = 0;
prediction = model.w*[recordFeatures 1]';
risk = prediction;
if prediction > 0
	prediction = 1;
else
	prediction = 0;
end
risk = -risk;
if risk < splits(3)
	risk = split_probs(1);
else
	for s=length(splits):-1:3
		if risk > splits(s)
			risk = split_probs(s-2);
			break;
		end
	end
end
