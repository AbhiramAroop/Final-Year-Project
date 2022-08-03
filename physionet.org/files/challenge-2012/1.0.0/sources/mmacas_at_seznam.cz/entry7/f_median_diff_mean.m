function y = f_median_diff_mean(name,record)

%Get the value of parameter name at times time
[~,values]=getTimeSeries(name, record);
%Compute the feature value

if isempty(values)
    y=NaN;
else
    y = abs(diff([median(values) mean(values)]));
end

