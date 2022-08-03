function y=f_alldiff(name, record)

%Get the value of parameter name at times time
[~,values]=getTimeSeries(name, record);
%Compute the feature value
if length(values) < 2,
    y=NaN;
else
    y=all(diff(values));
end
