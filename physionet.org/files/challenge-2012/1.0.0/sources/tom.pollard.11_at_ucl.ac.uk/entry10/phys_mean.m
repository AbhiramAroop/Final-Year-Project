% Function to calculate a mean for each parameter

function [mean_val] = phys_mean(cat_time, cat_val, phys_filter_table);

mean_val = nanmean(cat_val);

% If value(s) is NaN change it to the mean
mean_val(isnan(mean_val)) = phys_filter_table(:,3);
mean_val(isinf(mean_val)) = phys_filter_table(:,3);
    
% EOF