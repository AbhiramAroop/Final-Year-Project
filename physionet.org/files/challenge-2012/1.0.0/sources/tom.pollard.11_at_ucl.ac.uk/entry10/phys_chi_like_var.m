% Function to calculate a 'value minus mean' variability

function [chi_var]=phys_chi_like_var(cat_time, cat_val, phys_filter_table);

% Ignore parameters with less than 5 values
if numel(cat_val) < 5
    calculated_val = NaN;
else
    % Take value at each point and subtract the mean, then square it
    mean_val=nanmean(cat_val);
    val_min_mean_sq=(cat_val-mean_val).^2;
        
    % Create an average for the record
    calculated_val = sqrt((nanmean(val_min_mean_sq))/numel(cat_val));
end
    
% Remove NaNs and Infs
calculated_val(isnan(calculated_val)) = phys_filter_table(:,4);
calculated_val(isinf(calculated_val)) = phys_filter_table(:,4);
    
% Save the value
chi_var = calculated_val;
    
% EOF