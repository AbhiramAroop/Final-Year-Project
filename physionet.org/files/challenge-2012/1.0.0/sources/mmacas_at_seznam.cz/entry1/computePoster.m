%This function simply apply Bayes formula assuming normal distributions
%and the same covariance matrix of class conditional densities
%Thus, the classifier is linear.
function [poster1, poster2]=computePoster(X)
%The parameters of normal distribution are loaded from file
parameters;
%The priors are changed, it works better
Pw2=0.35;Pw1=0.65;%POZOR
%Bayes formulas
poster2=mvnpdf(X,xw2mean,xw12cov)*Pw2./mvnpdf(X,xmean,xcovariance);
poster1=mvnpdf(X,xw1mean,xw12cov)*Pw1./mvnpdf(X,xmean,xcovariance);