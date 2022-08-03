function index_sort=dtsort(cvars)


for i=1:length(cvars)
    
    c=cvars{i};
    if ~strcmp(cvars{i},'')
        c1=char(c);
        cn_organ(i,1)=str2num(c1(2:end));
    else
        cn_organ(i,1)=0;
    end
    
end

num_organ=cn_organ(find(cn_organ~=0));
ss=sort(num_organ);
p=ss(1);
i=1;
while i<length(ss)
    
    if ss(i+1)~=ss(i)
        p=[p;ss(i+1)];
    end
    i=i+1;
    
end
i_organ=p;
clear i ss p num_organ c c1 cn_organ
index_sort=i_organ;