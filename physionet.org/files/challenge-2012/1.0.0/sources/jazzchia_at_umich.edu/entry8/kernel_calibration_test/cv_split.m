function [TRN, TST] = cv_split(k, labels)
% randomly split into k stratified folds for cross-validation
%
% Inputs:
%   k - number of folds
%   labels - data labels (to stratify folds)
%
% Outputs:
%   TRN - cell array with one entry for the training data indices for each
%           fold
%   TST - same as TRN but with test data indices

    if size(labels,1) < size(labels,2)
        labels = labels';
    end

    labels(labels < 0) = 0;
    pos = find(labels == 1);
    pos = pos(randperm(length(pos)));
    neg = find(labels == 0);
    neg = neg(randperm(length(neg)));

    pos_boundaries = round(linspace(1,length(pos)+1,k+1));
    neg_boundaries = round(linspace(1,length(neg)+1,k+1));
    
    TRN = cell(k,1);
    TST = cell(k,1);
    
    for a=1:k
        trn_a_pos = pos;
        trn_a_pos(pos_boundaries(a):pos_boundaries(a+1)-1) = [];
        trn_a_neg = neg;
        trn_a_neg(neg_boundaries(a):neg_boundaries(a+1)-1) = [];
        
        tst_a_pos = pos(pos_boundaries(a):pos_boundaries(a+1)-1);
        tst_a_neg = neg(neg_boundaries(a):neg_boundaries(a+1)-1);
        
        TRN{a} = [trn_a_pos; trn_a_neg];
        TST{a} = [tst_a_pos; tst_a_neg];
    end

end