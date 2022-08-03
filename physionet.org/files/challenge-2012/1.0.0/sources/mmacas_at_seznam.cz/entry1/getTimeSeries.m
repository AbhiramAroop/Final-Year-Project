%This file simply obtains time series for parameter named
%"name" and form the record variable
%Time is time of measurement of the parameter and
%value is the value of the parameter.
%The function is used by the feature extractors.
function [time,value]=getTimeSeries(name, record);
   

time=[];value=[];

for i=2:length(record{1}),
    
    parameter=record{2}(i);
    
    if strcmp(parameter, name),
        
        %time format hh:mm changed to mm only
        thours=record{1}{i};
        time=[time;str2double(thours(1:2))*60+str2double(thours(4:5))];
        
        %Value 0f the parameter at the time
        value=[value;str2double(record{3}(i))];
    
    end    
end