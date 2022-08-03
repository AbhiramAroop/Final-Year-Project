%This file calls feature extractors
function x=extractFeatures(time,param,value)
warning off;
%input for extractors
record={time,param,value};

load load_features;
%This describes, which features must be extracted 
%in form Name of parameter, Extractor file


%Call of extractors, x is the feature vector
x=[];
for j=1:size(features,1),
    x=[x feval(features{j,2},features{j,1},record)];
end

%NaNs are replaced by mean values of the particular feature
load load_nanmeans;

x(isnan(x))=nanmeans(isnan(x));

    


warning on;