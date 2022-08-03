% Function to calculate nanoflares for each parameter 
% and put these into an array which is returned to genresults

function [nanoflares]=phys_nanoflare(cat_time, cat_val, phys_filter_table);

% Ignore if less than 10 values
if numel(cat_val) < 10
    m1 = NaN;
    m2 = NaN;
    m3 = NaN;
    m4 = NaN;
else  
    % Convert time to minutes    
    [yr,mo,day,hr,minutes,sec] = datevec(cat_time);
    cat_time=[day,hr,minutes,sec];
    day2_index = find(cat_time(:,1)==2);
    cat_time(:,2)=cat_time(:,2)+((cat_time(:,1)-1).*24);
    cat_time(:,3)=cat_time(:,3)+(cat_time(:,2).*60);
    cat_time = cat_time(:,3);

    % Firstly the local points of minima were determined.
    % A minimum was defined as a point which had three points on either side with
    % values of emission measure greater than it.
    shift_cat_val_min3 = [cat_val(4:end); 9999; 9999; 9999];
    shift_cat_val_min2 = [cat_val(3:end); 9999; 9999];
    shift_cat_val_min1 = [cat_val(2:end); 9999];
    shift_cat_val_plus1 = [9999; cat_val(1:end-1)];
    shift_cat_val_plus2 = [9999; 9999; cat_val(1:end-2)];
    shift_cat_val_plus3 = [9999; 9999; 9999; cat_val(1:end-3)];

    minima_index = find(cat_val <= shift_cat_val_min3 & cat_val <= shift_cat_val_min2 & cat_val <= shift_cat_val_min1 & ...
    cat_val <= shift_cat_val_plus3 & cat_val <= shift_cat_val_plus2 & cat_val <= shift_cat_val_plus1);

    minima_val_array = cat_val(minima_index);
    minima_time_array = cat_time(minima_index);      

    % The peaks were then defined as those points which have one
    % point on one side and two points on the other side lower than it
    shift_cat_val_min2 = [cat_val(3:end); -9999; -9999];
    shift_cat_val_min1 = [cat_val(2:end); -9999];
    shift_cat_val_plus1 = [-9999; cat_val(1:end-1)];
    shift_cat_val_plus2 = [-9999; -9999; cat_val(1:end-2)];

    one_side = find(cat_val >= shift_cat_val_min2 & cat_val >= shift_cat_val_min1 & ...
    cat_val >= shift_cat_val_plus1);

    other_side = find(cat_val >= shift_cat_val_min1 & cat_val >= shift_cat_val_plus2 &...
    cat_val >= shift_cat_val_plus1); 

    maxima_index = unique([one_side; other_side]);

    % In addition the peaks must have flux at least 10% above the background level.
    if length(minima_index) < 10
        m1 = NaN;
        m2 = NaN;
        m3 = NaN;
        m4 = NaN;
    else 
        % The time profiles of these brightenings were then fitted using a spline
        % fit, and the total intensity, peak intensity and duration of each
        % brightening were determined.

        % Set background provided there are enough points
        background_val = spline(minima_time_array,minima_val_array,cat_time);

        % Uncomment to plot example figures
%       figure
%       plot(cat_time,cat_val,'-');
%       hold on
%       plot(cat_time,background_val,'-','Color',[.6 0 0]);
%       hold on
%       plot(cat_time(maxima_index),cat_val(maxima_index),'x','Color',[.6 0 0]);
        % title(['Plot over time with minima'])
         
        % Maxima array
        temp_val_maxima = max(cat_val(maxima_index),0) - max(background_val(maxima_index),0);

        % Mean intensity of maxima
        mean_val_maxima = nanmean(temp_val_maxima);
        
        % Mean intensity of maxima in first 24h / second 24h
        first24h_maxind = cat_time(maxima_index) <= 1440;
        second24h_maxind = cat_time(maxima_index) > 1440;
        maxima_change = mean(cat_val(first24h_maxind))/mean(cat_val(second24h_maxind));

        % Final values
        m1 = length(minima_index(minima_index>0)); % Number of minima
        m1(m1 == 0) = NaN;
        m2 = length(maxima_index(maxima_index>0)); % Number of maxima
        m2(m2 == 0) = NaN;
        m3 = mean_val_maxima; % Mean intensity of maxima
        m4 = maxima_change; % Mean intensity of maxima in first 24h / second 24h

    end
    
    clear('temp_val_maxima','background_val')
end

% If value(s) is NaN change it to the mean
m1(isnan(m1)) = phys_filter_table(:,9);
m1(isinf(m1)) = phys_filter_table(:,9);
m2(isnan(m2)) = phys_filter_table(:,10);
m2(isinf(m2)) = phys_filter_table(:,10);
m3(isnan(m3)) = phys_filter_table(:,11);
m3(isinf(m3)) = phys_filter_table(:,11);
m4(isnan(m4)) = phys_filter_table(:,12);
m4(isinf(m4)) = phys_filter_table(:,12);

% Return the values
nanoflares = [m1 m2 m3 m4];
    
% EOF