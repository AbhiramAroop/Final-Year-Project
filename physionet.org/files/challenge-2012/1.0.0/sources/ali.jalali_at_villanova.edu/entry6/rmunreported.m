function outp=rmunreported(inp)

a=inp;
t=a(:,1);
v=a(:,2);
c=find(v~=0);
t=t(c);
v=v(c);
outp=[t v];