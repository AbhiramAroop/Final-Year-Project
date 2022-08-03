function [features] = func_physioFeatures(tm,category,val, num_fts_touse,sortingIndicesE1)
%%
%Only use data for the first 48 hrs (standard SAPS)
tm=cell2mat(tm);
hour = tm(:,1:2);
minute = tm(:,4:5);
tm = hour + minute / 60;
ft_count = 0;
%% Age
var='Age';
table=[0,45,0;46,55,1;56,65,2;66,75,3;76,200,4];
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
else
    ft_count = ft_count + 1;
    features(ft_count) = mean(tmp_data);
end
%% Urine
var='Urine';
table=[5,20,0.002;3.5,4.999,0.001;0.7,3.499,0;0.5,0.699,0.002;0.2,0.499,0.003;0,0.199,0.004].*1000; %Convert from L to mL
table=table.*2; %we use 48 hr data instead of 24 hr
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
else
    ft_count = ft_count + 1;
    features(ft_count) = sum(tmp_data);
end
%% FiO2 / PaO2
%
var1='FiO2';
sig_ind1 = strcmp(var1,category);
tmp_data1 = val(sig_ind1);
tmp_tm1 = tm(sig_ind1);
tmp_data1(tmp_data1 < 0.21)=NaN;
tmp_data1(tmp_data1 > 1)=NaN;
tmp_tm1 = tmp_tm1( ~isnan(tmp_data1) );
tmp_data1 = tmp_data1( ~isnan(tmp_data1) );
if isempty(tmp_data1)
    tmp_tm1 = -1;
    tmp_data1 = 0.21;
end
%
var2='PaO2';
sig_ind2 = strcmp(var2,category);
tmp_data2 = val(sig_ind2);
tmp_tm2 = tm(sig_ind2);
tmp_data2(tmp_data2 < 20)=NaN;
tmp_data2(tmp_data2 > 500)=NaN;
tmp_tm2 = tmp_tm2( ~isnan(tmp_data2) );
tmp_data2 = tmp_data2( ~isnan(tmp_data2) );
if isempty(tmp_data2)
    tmp_tm2 = -1;
    tmp_data2 = 85;
end
ft_count = ft_count + 1;
features(ft_count) = func_integration_mean(tmp_data2,tmp_tm2) / func_integration_mean(tmp_data1,tmp_tm1);
%% GCS
var='GCS';
table=[13,15,0;10,12,1;7,9,2;4,6,3;3,3,4];
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% HCO3
var='HCO3';
table=[40,100,4;30,39.9,1;20,29.9,0;10,19.9,1;5,9.9,3;2,4.9,4];
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% SysABP, NISysABP
var='SysABP';
table=[80,149,0;55,79,2;150,189,2;190,300,4;20,54,4];
sig_ind = strcmp(var,category);
var='NISysABP';
sig_ind = sig_ind | strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% BUN
var='BUN';
BUN=[55,100;36,54.9;29,35.9;7.5,28.9;3.5,7.4;1,3.4].*2.8; %Convert to mg/dL
BUN(:,3)=[4;3;2;1;0;1];
BUN(:,1)=[BUN(2:end,2)+eps;BUN(end,1)];
table=BUN;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% Temp
var='Temp';
Temp=[36,38.4,0;34,35.9,1;38.5,38.9,1;32,33.9,2;30,31.9,3;39,40.9,3;41,45,4;15,29.9,4];
table=Temp;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% WBC
var='WBC';
WBC=[40,200,4;20,39.9,2;15,19.9,1;3,14.9,0;1,2.9,2;0.100,0.9,4];
table=WBC;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% Glucose
var='Glucose';
Glucose=[44.5,1000;27.8,44.4;14,27.7;3.9,13.9;2.8,3.8;1.6,2.7;0.5,1.5].*18;%Convert to mg/dL
Glucose(:,3)=[4;3;1;0;2;3;4];
Glucose(:,1)=[Glucose(2:end,2)+eps;Glucose(end,1)];
table=Glucose;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% Na
var='Na';
Na=[180,200,4;161,179,3;156,160,2;151,155,1;130,150,0;120,129,2;110,119,3;50,109,4];
table=Na;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% K
var='K';
K=[7,20,4;6,6.9,3;5.5,5.9,2;3.5,5.4,0;3,3.4,1;2.5,2.9,2;0.5,2.4,4];
table=K;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% Creatinine
var='Creatinine';
Creatinine=[0.5,1.2,0; 0.1,15,1];
table=Creatinine;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%% HR
var='HR';
HR=[70,109,0;55,69,2;110,139,2;40,54,3;140,179,3;180,250,4;10,39,4];
table=HR;
sig_ind = strcmp(var,category);
tmp_data = val(sig_ind);
tmp_tm = tm(sig_ind);
tmp_data(tmp_data < min(table(:,1)))=NaN;
tmp_data(tmp_data > max(table(:,2)))=NaN;
tmp_tm = tmp_tm( ~isnan(tmp_data) );
tmp_data = tmp_data( ~isnan(tmp_data) );
if isempty(tmp_data)
    [i j]=find(table(:,3)==0);
    % min
    ft_count = ft_count + 1;
    features(ft_count) = table(i,1);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = table(i,2);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = mean([table(i,1) table(i,2)]);
    % slope
    ft_count = ft_count + 1;
    features(ft_count) = 0;
else
    % min
    ft_count = ft_count + 1;
    features(ft_count) = min(tmp_data);
    % max
    ft_count = ft_count + 1;
    features(ft_count) = max(tmp_data);
    % weighted mean
    ft_count = ft_count + 1;
    features(ft_count) = func_integration_mean(tmp_data,tmp_tm);
    % last data point
    ft_count = ft_count + 1;
    features(ft_count) = tmp_data(end);
    % slope
    ws = warning('off','all');
    p = polyfit(tmp_tm,tmp_data,1);
    ft_count = ft_count + 1;
    features(ft_count) = p(1);
end
%%
features = features';
features = features(sortingIndicesE1(1:num_fts_touse));
