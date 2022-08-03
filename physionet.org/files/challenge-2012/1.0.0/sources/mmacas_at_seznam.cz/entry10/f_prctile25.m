function y=f_prctile25(name, record)

%Get the value of parameter name at times time
[~,values]=getTimeSeries(name, record);
%Compute the feature value
if isempty(values),
    y=NaN;
else
    y=prctile(values,25);
end

