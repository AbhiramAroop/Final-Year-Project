function y=f_prctile75(name, record)

%Get the value of parameter name at times time
[~,values]=getTimeSeries(name, record);
%Compute the feature value
if isempty(values),
    y=NaN;
else
    y=prctile(values,75);
end

