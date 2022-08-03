function y = f_vardiff(name,record)

%Get the value of parameter name at times time
[~,values]=getTimeSeries(name, record);
%Compute the feature value

if length(values)<=1,
    y=NaN;
else
    y=var(diff(values));
end

