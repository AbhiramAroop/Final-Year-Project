function [alarm,risk]=hemoalarm(in,ll,ul)

% This function calculate number of alarms for a hemodynamic input
% ll is lower limit 
% ul is upper limit
% if one limit is not avaiable, its argument should be '0'
c=in;
a=rmunreported(c);
t=a(:,1);
a1=a(find(a(:,1)<=1440),:);
a2=a(find(a(:,1)>1440),:);

risk=[0;0];
alarm=[0;0];

if ~isempty(a1)
    
    if ((ll~=0) && (ul~=0))
        dd=find(a1(:,2)>ul);
        ddd=find(a1(:,2)<ll);
        alarm(1)=length(dd)+length(ddd);
        risk(1)=~isinf(1/alarm(1));
    end
    if (ll==0)
        dd=find(a1(:,2)>ul);
        %     ddd=find(a(:,2)<ll);
        alarm(1)=length(dd);
        risk(1)=~isinf(1/alarm(1));
    end
    if (ul==0)
        dd=find(a1(:,2)<ll);
        %     ddd=find(a(:,2)<ll);
        alarm(1)=length(dd);
        risk(1)=~isinf(1/alarm(1));
    end
    
end

if ~isempty(a2)
    
    if ((ll~=0) && (ul~=0))
        dd=find(a2(:,2)>ul);
        ddd=find(a2(:,2)<ll);
        alarm(2)=length(dd)+length(ddd);
        risk(2)=~isinf(1/alarm(2));
    end
    if (ll==0)
        dd=find(a2(:,2)>ul);
        %     ddd=find(a(:,2)<ll);
        alarm(2)=length(dd);
        risk(2)=~isinf(1/alarm(2));
    end
    if (ul==0)
        dd=find(a2(:,2)<ll);
        %     ddd=find(a(:,2)<ll);
        alarm(2)=length(dd);
        risk(2)=~isinf(1/alarm(2));
    end
    
end

if isempty(a1)
    if ~isempty(a2)
        risk(1)=risk(2);
        alarm(1)=alarm(2);
    end
end

if isempty(a2)
    if ~isempty(a1)
        risk(2)=risk(1);
        alarm(2)=alarm(1);
    end
end
