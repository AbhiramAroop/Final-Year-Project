function Y_hat = kernel_calibrate( X_new, X, Y, besth )

% Given a set of training data decision values (X) and their labels (Y),
% use kernel regression to estimate outcome probabilities (Y_hat) for a
% new set of data decision values (X_new)
%
% Inputs:
%   X_new - new data (1-dimensional) points, usually classifier outputs
%   X - training data points
%   Y - training data labels (0/1)
%
%   Y_hat - estimated outcome probabilities for each of the new points

    
    % make sure negative labels aren't -1
    Y(Y < 0) = 0;
    
	%{
    % test over a range of kernel bandwidths using inner cross-validation
    % use hosmer-lemeshow chi-squared score as the selection criteria
    [TRN,TST] = cv_split(5,Y);
    hs = 10.^(-3:0.1:0);
    bestH = Inf;
    besth = NaN;
    for h=hs
        meanH = 0;
        for iter=1:length(TRN)
            icv_Y_hat = kernel_regress(X(TST{iter}), X(TRN{iter}), Y(TRN{iter}), h);
            H = lemeshow([Y(TST{iter})' icv_Y_hat], 0);
            meanH = meanH + H;
        end
        meanH = meanH / length(TRN);
        %disp(['h: ' num2str(h) '   H: ' num2str(meanH)]);
        if meanH < bestH
            bestH = meanH;
            besth = h;
        end
    end
    %}
	
    Y_hat = kernel_regress(X_new, X, Y, besth);
    
end