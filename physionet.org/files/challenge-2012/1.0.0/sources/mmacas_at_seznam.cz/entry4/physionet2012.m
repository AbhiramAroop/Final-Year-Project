%Written by Martin Macas 2012
%Function needs statistical toolbox
function [risk,prediction]=physionet2012(time,param,value)

if (~iscell(value))
value=cellstr(num2str(value));%This works for genresults,
%but does not correspond to 
%physionet2012.m, where "value" should be cell array. 
end


%Feature extraction uses extraction scripts f_******.mat
x=extractFeatures(time,param,value);

%Computation of posterior probabilities using Bayes formula
[Pw1x, Pw2x]=computePoster(x);

%Correction of posterior probabilities
if Pw2x>1,Pw2x=1;end
if Pw2x<0,Pw2x=0;end

%Risk is proportional to aposterior probability
risk=0.5*Pw2x;%POZOR

%Prediction is based on MAP principle
prediction=Pw2x>Pw1x;



