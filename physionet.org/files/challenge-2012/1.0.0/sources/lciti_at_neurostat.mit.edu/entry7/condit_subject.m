function [SubjectsC, Condit] = condit_subject(Subjects, Condit)

learning = ischar(Condit);
if learning
    Condit = struct('fn_name', Condit);
end
condit_fn = str2func(Condit.fn_name);

SubjectsC = Subjects;

f1 = {'Desc', 'TSeries'};
for i1 = 1:length(f1)
    f2 = fieldnames(Subjects(1).(f1{i1}));
    for i2 = 1:length(f2)
        if learning
            vals = cell2mat(arrayfun(@(x) x.(f1{i1}).(f2{i2})(:,end), Subjects, 'UniformOutput', false));
            Condit.(f1{i1}).(f2{i2}) = condit_fn(vals);
        end
        for s = 1:length(Subjects)
            SubjectsC(s).(f1{i1}).(f2{i2})(:,end) = condit_fn(Subjects(s).(f1{i1}).(f2{i2})(:,end), Condit.(f1{i1}).(f2{i2}));
        end
    end
end
