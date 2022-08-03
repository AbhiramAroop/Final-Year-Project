function result = func_integration_mean(data,time)
if length(data) ~= length(time)
    error('length of data not equal to time');
end
if length(data) == 1
    result = data(1);
    return;
end
if time(end) == time(1)
   result = mean(data);
   return;
end
result = sum((data(1:end-1)+data(2:end)).*(time(2:end)-time(1:end-1))/2)...
    / (time(end)-time(1));
