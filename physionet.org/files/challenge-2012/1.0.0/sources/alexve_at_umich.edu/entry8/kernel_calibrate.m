function Y_hat = kernel_calibrate( X_new, X, Y, h, MAX_NUM_SAMPLES )

% Given a set of training data decision values (X) and their labels (Y),
% use kernel regression to estimate outcome probabilities (Y_hat) for a
% new set of data decision values (X_new)
%
% Inputs:
%   X_new - new data (1-dimensional) points, usually classifier outputs
%   X - training data points
%   Y - training data labels (0/1)
%	h - fixed bandwidth parameter
%   MAX_NUM_SAMPLES - maximum number of samples to use (speeds up the
%                       kernel regression) (optional, default 5000)
%
%   Y_hat - estimated outcome probabilities for each of the new points

    % make sure vectors are column vectors
    X_new = enforce_col_vector(X_new);
    X = enforce_col_vector(X);
    Y = enforce_col_vector(Y);

    % remove NaNs rows from X/Y
    M = [X Y];
    M = remove_row_mvs(M);
    X = M(:,1);
    Y = M(:,2);
    
    % make sure negative labels aren't -1
    Y(Y < 0) = 0;
    
    Y_hat = kernel_regress(X_new, X, Y, h);
    
end




function [A, rows_with_mvs] = remove_row_mvs(A)

	missing = sum(isnan(A),2);
	rows_with_mvs = find(missing > 0);
	A(rows_with_mvs,:) = [];

end




function v = enforce_col_vector( v )

    if size(v,1) < size(v,2)
        v = v';
    end

end
