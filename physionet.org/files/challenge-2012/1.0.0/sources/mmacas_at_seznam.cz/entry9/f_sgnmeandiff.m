function y=f_sgnmeandiff(name, record)

%Get the value of parameter name at times time
[~,values]=getTimeSeries(name, record);
%Compute the feature value
if isempty(values),
    y=NaN;
else
    y=sign(mean(diff(values)));
end

