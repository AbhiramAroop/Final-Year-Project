clc

age=zeros(1,1);

for i=1:1
    
    age(i)=patients_B.Age;
    if age(i)>=130
        age(i)=60;
    end
    
end

clear i

for i=1:1
    
    o_r(i,:)=[sum(A_F(i,:)) sum(B_F(i,:)) sum(C_F(i,:)) ...
        sum(D_F(i,:)) sum(E_F(i,:)) sum(F_F(i,:)) sum(G_F(i,:)) age(i)];
    
end

clear i

max_A=2;
max_B=3;
max_C=3;
max_D=5;
max_E=4;
max_F=6;
max_G=4;


max_age=max(age);

a=[max_A max_B max_C max_D max_E max_F max_G max_age];

for i=1:1
    orr(i,:)=o_r(i,:)./a;
end

clear i a max_A max_B max_C max_D max_E max_F max_G max_age

w=[4;3;2;4;2;3;2;4];

for i=1:1
    risk_prob(i)=(orr(i,:)*w)/16;
end

clear i w age