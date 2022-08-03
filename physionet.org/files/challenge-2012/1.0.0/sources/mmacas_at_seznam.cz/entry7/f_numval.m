function y=f_numval(name, record)

%Get the value of parameter name at times time
[~,values]=getTimeSeries(name, record);
%Compute the feature value
    y=length(values);

