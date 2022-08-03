function y = f_trend(name,record)

%return slope of a line 

[time_series,values]=getTimeSeries(name, record);

if length(values) > 1
    p=polyfit(time_series,values,1);
    y = p(1);
else
    y = NaN;

end

