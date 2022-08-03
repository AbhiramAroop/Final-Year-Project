function out=satur(in,ll,ul)

% This function returns the saturation value of the given input and lower
% limit and upper limit

out=zeros(size(in,1),1);

for i=1:size(in,1)
    if in(i)<=ll
        out(i)=0;
    elseif in(i)>=ul
        out(i)=1;
    else
        l=abs(ul-ll);
        l1=abs(in(i)-ll);
        out(i)=(l1/l);
    end
end

end