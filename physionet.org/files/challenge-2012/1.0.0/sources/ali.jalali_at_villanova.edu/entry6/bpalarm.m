function [alarm,risk]=bpalarm(in,hll,sll,sul,hul)

% This function calculate number of alarms for a hemodynamic input
% sll is soft lower limit 
% hll is hard lower limit 
% sul is soft upper limit
% hul is hard upper limit
% if one limit is not avaiable, its argument should be '0'
c=in;
a=rmunreported(c);
a1=a(find(a(:,1)<=1440),:);
a2=a(find(a(:,1)>1440),:);

risk=[0;0];
alarm=[0;0];

if ~isempty(a1)
    
    if ((hll~=0) && (hul~=0))
        dd=find(a1(:,2)>=sul);
        u_sat_in=a1(dd,2);
        u_sat=satur(u_sat_in,sul,hul);
        ddd=find(a1(:,2)<=sll);
        l_sat_in=a1(ddd,2);
        l_sat=rsatur(l_sat_in,sll,hll);
        alarm(1)=sum(u_sat)+sum(l_sat);
        risk(1)=~isinf(1/alarm(1));
    end
    if (hll==0)
        dd=find(a1(:,2)>=sul);
        u_sat_in=a1(dd,2);
        u_sat=satur(u_sat_in,sul,hul);
        %     ddd=find(a(:,2)<ll);
        alarm(1)=sum(u_sat);
        risk(1)=~isinf(1/alarm(1));
    end
    if (hul==0)
        dd=find(a1(:,2)<=sll);
        l_sat_in=a1(dd,2);
        l_sat=rsatur(l_sat_in,sll,hll);
        %     ddd=find(a(:,2)<ll);
        alarm(1)=sum(l_sat);
        risk(1)=~isinf(1/alarm(1));
    end
    
end

if ~isempty(a2)
    
    if ((hll~=0) && (hul~=0))
        dd=find(a2(:,2)>=sul);
        u_sat_in=a2(dd,2);
        u_sat=satur(u_sat_in,sul,hul);
        ddd=find(a2(:,2)<=sll);
        l_sat_in=a2(ddd,2);
        l_sat=rsatur(l_sat_in,sll,hll);
        alarm(2)=sum(u_sat)+sum(l_sat);
        risk(2)=~isinf(1/alarm(2));
    end
    if (hll==0)
        dd=find(a2(:,2)>=sul);
        u_sat_in=a2(dd,2);
        u_sat=satur(u_sat_in,sul,hul);
        %     ddd=find(a(:,2)<ll);
        alarm(2)=sum(u_sat);
        risk(2)=~isinf(1/alarm(2));
    end
    if (hul==0)
        dd=find(a2(:,2)<=sll);
        l_sat_in=a2(dd,2);
        l_sat=rsatur(l_sat_in,sll,hll);
        %     ddd=find(a(:,2)<ll);
        alarm(2)=sum(l_sat);
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

end