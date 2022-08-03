% thresh_failure=[0 1 4 1 1 0 0];
% failure_in=zeros(1,7);
age=patient.Age;
if age<30
    agee=1;
elseif age<40
    agee=2;
elseif age<50
    agee=3;
elseif age<60
    agee=4;
elseif age<65
    agee=5;
elseif age<70
    agee=6;
elseif age<75
    agee=7;
else
    agee=8;
end
icutype=patient.ICUType;

for mm=1:7
    first_day(mm)=org_alarm(2*mm-1);
    second_day(mm)=org_alarm(2*mm);
end
clear mm

all_in=first_day+second_day;
trend=second_day-first_day;
% for j=1:length(organs_failure)
%     if organs_failure(j)>thresh_failure(j)
%         failure_in(j)=1;
%     end
% end
% icu_input=[fail_organs agee];
icu_inp=[all_in agee];
icu_in=[org_alarm trend agee];
icu_i=[all_in trend agee];
icc=[first_day agee];
icc1=[org_alarm agee];