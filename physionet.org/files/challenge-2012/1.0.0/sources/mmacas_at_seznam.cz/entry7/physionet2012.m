%Written by Martin Macas 2012
%Implementation tested for MATLAB 2011b 7.13.0.564
%needs Statistics toolbox
function [risk,prediction]=physionet2012(time,param,value)
Pw2=0.28;%POZOR
beta=0.625;%risk correction

if (~iscell(value))
value=cellstr(num2str(value));%This works for genresults,
%but does not correspond to 
%physionet2012.m, where "value" should be cell array. 
end

%Feature extraction uses extraction scripts f_******.mat
x=extractFeatures(time,param,value);
load load_classifier;
[y,p]=predict(cl, x);

Pw2x=p(:,2);

%Risk is proportional to aposterior probability
risk=beta*Pw2x-0.015;%POZOR


%Prediction is based on MAP principle
prediction=y;


