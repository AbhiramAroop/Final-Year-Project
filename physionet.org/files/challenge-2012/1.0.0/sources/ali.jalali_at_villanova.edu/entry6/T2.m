%% Preparing input-output for test

age=zeros(1,1);

for i=1:1
    
    age(i)=patients_B.Age;
    if age(i)>=130
        age(i)=60;
    end
    
end

clear i

test_A=A1(:,i_A);
test_B=B1(:,i_B);
test_C=C1(:,i_C);
test_D=D1(:,i_D);
test_E=E1(:,i_E);
test_F=F1(:,i_F);
test_G=G1(:,i_G);
test_age=age/10;
test_in=[test_A test_B test_C test_D test_E ... 
    test_F test_G test_age];
max_test=[4 12 20 2 25 32  11 31 12 56 8 10 41 29 15 3 27 2 50 5 12 18 15 6 ...
    9 26 10];
test_in2=test_in./max_test;
% test_in=normc(test_in);
clear test_A test_B test_C test_D test_E ... 
    test_F test_G test_age