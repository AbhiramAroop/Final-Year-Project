function ac=hemoacute(in,ll,ul,time)

% This function calculate acute period for a hemodynamic input if it has
% ll is lower limit
% ul is upper limit
% if one limit is not avaiable, its argument should be '0'
% time in minutes is the acute time provided by user

d=in;
aa=rmunreported(d);
a=aa;
b=0;
c=0;

if ((ll~=0) && (ul~=0))
    if size(aa,1)>1
        dd=find(a(2:end,2)>ul);
        ddd=find(a(2:end,2)<ll);
        j=2;
        while j<length(dd)
            t=a(dd(j-1),1);
            while dd(j)==dd(j-1)+1
                t=a(dd(j),1)+t;
                j=j+1;
                if j==length(dd)
                    break
                end
            end
            if t>time
                b=b+1;
            end
            t=0;
            j=j+1;
        end
        j=2;
        while j<length(ddd)
            t=a(ddd(j-1),1);
            while ddd(j)==ddd(j-1)+1
                t=a(ddd(j),1)+t;
                j=j+1;
                if j==length(ddd)
                    break
                end
            end
            if t>360
                c=c+1;
            end
            t=0;
            j=j+1;
        end
    end
    ac=b+c;
end


if (ll==0)
    if size(a,1)>1
        dd=find(a(2:end,2)>ul);
        j=2;
        while j<length(dd)
            t=a(dd(j-1),1);
            while dd(j)==dd(j-1)+1
                t=a(dd(j),1)+t;
                j=j+1;
                if j==length(dd)
                    break
                end
            end
            if t>time
                b=b+1;
            end
            t=0;
            j=j+1;
        end
    end
    ac=b;
end

if (ul==0)
    if size(a,1)>1
        dd=find(a(2:end,2)<ll);
        j=2;
        while j<length(dd)
            t=a(dd(j-1),1);
            while dd(j)==dd(j-1)+1
                t=a(dd(j),1)+t;
                j=j+1;
                if j==length(dd)
                    break
                end
            end
            if t>time
                b=b+1;
            end
            t=0;
            j=j+1;
        end
    end
    ac=b;
end