
clearvars -except settings
close all;clc

data_root = '/_space_/Temp/CinC/';
set_name='set-a';
results='/_space_/Temp/CinC/Outcomes-a.txt';

condit = 'condit7';

if exist('settings', 'var')
    cellfun(@(f) evalin('caller', [f '=a.' f ';']), fieldnames(settings))
end

%       set_name='set-b';
%       fname_out='Outputs-b.txt'
%       results=[];


data_dir=[data_root filesep set_name filesep];
records=dir([data_dir '*.txt']);
records=sort({records.name});

I=length(records);
%Subjects(I,1) = struct();
display(['Processing records ...'])

% The file of known outcomes contains six columns.  The Challenge goal is
% to predict the sixth column, IHD (in-hospital death).
variables={'record_id_res','SAPS','SOFA','LOS','Survival','IHD'};
fid_result=fopen(results,'r');
C=textscan(fid_result,'%f %f %f %f %f %f','delimiter', ',','HeaderLines',1);
fclose(fid_result);
for n=1:length(variables)
    eval([variables{n} '=C{:,n};'])
end

% Each Challenge .txt file (record) contains data for one patient, in 3 columns
% (timestamp, parameter, and value).  During each iteration of the loop below,
% the contents of a single record are loaded into arrays named tm,
% category, and val.  Each data set (A, B, and C) contains 4000 records.
header={'tm','category','val'};
for i=1:I
    record_id=records{i}(1:end-4);
    fname=[data_dir record_id '.txt'];
    
    fid_in=fopen(fname,'r');
    C=textscan(fid_in,'%q %q %f','delimiter', ',','HeaderLines',1);
    fclose(fid_in);
    for n=1:length(header)
        eval([header{n} '=C{:,n};'])
    end

    %%% Ad hoc part
    Subjects(i,1) = import_subject(tm,category,val,IHD(record_id_res==str2double(record_id)));

    if(~mod(i,500))
        disp(['Processed: ' num2str(i) ' records out of ' num2str(I)])
    end

end
disp('*** All records processed')
save([data_root filesep set_name '_Subj.mat'], '-v7', 'Subjects');

disp('Conditioning ....')

[SubjectsC, Condit] = condit_subject(Subjects, condit);

save([data_root filesep set_name '_SubjC.mat'], '-v7', 'SubjectsC', 'Condit');
disp('*** All records processed')
