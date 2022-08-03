function [risk,prediction]=physionet2012(time,param,value)
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

load('helpers.mat');
%   threshold
%   h
%   train_dvs
%   train_labels
%   w
%
%   subtract
%   divide
%
%   all_bin_cuts
%   motifs

% load CCF features
f = create_CCF(param, value);

% convert data into a grid
M = create_grid(time, param, value);

% count the motifs
m = count_motifs_newdata( M, 1, 3, all_bin_cuts, motifs );

% scale features
x = [f m];
x = x - subtract;
x = x ./ divide;

% append for bias term
x = [x 1];
%x = [1 x];

% apply classifier
dv = w*x';

% calibrate results
risk = kernel_regress(dv, train_dvs, train_labels, h);
prediction = (dv >= threshold);

end