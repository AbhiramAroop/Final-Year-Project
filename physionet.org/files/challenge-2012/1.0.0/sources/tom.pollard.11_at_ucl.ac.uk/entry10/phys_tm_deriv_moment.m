% Function to calculate a moments of the gradients

function [grad_moments]=phys_tm_deriv_moment(cat_time, cat_val, phys_filter_table);  

% Loop to ignore parameters with less than 5 values
if numel(cat_val) < 5
    m1 = NaN;
    m2 = NaN;
    m3 = NaN;
    m4 = NaN;
else  
    % Convert time to hours and minutes    
    [yr,mo,day,hr,minutes,sec] = datevec(cat_time);
    cat_time=[day,hr,minutes,sec];
    day2_index = find(cat_time(:,1)==2);
    cat_time(:,2)=cat_time(:,2)+((cat_time(:,1)-1).*24);
    cat_time(:,3)=cat_time(:,3)+(cat_time(:,2).*60);
    cat_time = cat_time(:,3);   

    % Calculate gradients
    tm_diff  = diff(cat_time);
    val_diff = diff(cat_val);
    slopes = val_diff./tm_diff;

    % Calculate average, variance, skewness, and kurtosis
    m1 = nanmean(slopes);
    m2 = nanvar(slopes);
    m3 = skewness(slopes);
    m4 = kurtosis(slopes);
end

% If value(s) is NaN change it to the mean
m1(isnan(m1)) = phys_filter_table(:,5);
m1(isinf(m1)) = phys_filter_table(:,5);
m2(isnan(m2)) = phys_filter_table(:,6);
m2(isinf(m2)) = phys_filter_table(:,6);
m3(isnan(m3)) = phys_filter_table(:,7);
m3(isinf(m3)) = phys_filter_table(:,7);
m4(isnan(m4)) = phys_filter_table(:,8);
m4(isinf(m4)) = phys_filter_table(:,8);

% Return values
grad_moments = [m1 m2 m3 m4];

% EOF