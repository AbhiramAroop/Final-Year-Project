function [prob,died]=physionet2012(tm,category,val)
% [prob,SAPS_SCORE,died]=physionet2012(tm,category,val)
%
% Sample Submission for the PhysioNet 2012 Challenge. Variables our:
%
% tm      - (Nx1 Cell Array) Cell array containing time of measurement
% category- (Nx1 Cell Array) Cell array containing type (category)
%           measurement
% value   - (Nx1 Cell Array) Cell array containing value of measurement
%
%%
load sortingIndicesE1_fromSingleFtAnalysis.mat
num_fts_touse = 48;
THRESHOLD = 0.32;

test_ft = func_physioFeatures(tm,category,val, num_fts_touse,sortingIndicesE1);

load('models.mat');
for votingid = 1 : 100
    net.IW=IW{votingid};
    net.LW=LW{votingid};
    net.b=b{votingid};
    predictions(votingid) = sim(net, test_ft);
end
prob = mean(predictions);
died=prob>THRESHOLD;

% adjusting the probability using a polynomial function
x=[-0.0000    5.6159   -7.1387];
adp=0;
n=length(x);
for i=1:n
    adp=adp+x(i)*prob.^i;
end
adp=adp+(1-sum(x))*prob.^(n+1);
adp(adp<0)=0;
adp(adp>1)=1;
prob=adp;

