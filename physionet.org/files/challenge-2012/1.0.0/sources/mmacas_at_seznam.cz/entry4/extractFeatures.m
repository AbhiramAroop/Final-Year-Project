%This file calls feature extractors
function x=extractFeatures(time,param,value)

%input for extractors
record={time,param,value};

%This describes, which features must be extracted 
%in form Name of parameter, Extractor file
features={
'GCS', 'f_finalval'          
'BUN', 'f_finalval'          
'GCS', 'f_range'             
'Temp', 'f_prctile75'        
'Urine', 'f_sgnmeandiff'     
'Creatinine', 'f_finalval'   
'Creatinine', 'f_range'      
'Glucose', 'f_stdval'        
'Temp', 'f_minval'           
'Temp', 'f_stdval'  
};

%Call of extractors, x is the feature vector
x=[];
for j=1:size(features,1),
    x=[x feval(features{j,2},features{j,1},record)];
end

%NaNs are replaced by mean values of the particular feature
nanmeans=[12.3709   25.3981    5.3056   37.4171  -0.4105    1.3690    0.3765   31.7718   35.0261    0.7797];
x(isnan(x))=nanmeans(isnan(x));

%Precomputed normalization is applied
Wnormalization;
Wselection;
x=rot(indices).*x+offset(indices);

    
