// Check for the size of f matrix
//Find x in R^6 such that:

Aeq= [1,-1,1,0,3,1;
-1,0,-3,-4,5,6;
2,5,3,0,1,0];
beq=[1; 2; 3];
A= [0,1,0,1,2,-1;
-1,0,2,1,1,0];
b = [-1; 2.5];
lb=[-1000; -10000; 0; -1000; -1000; -1000];
ub=[10000; 100; 1.5; 100; 100; 1000];
x0 = repmat(0,6,1);
param = list("MaxIter", 300, "CpuTime", 100);
f=[1; 2; 3; 4; 5]; H=eye(6,6);
x0 = repmat(0,6,1);

// Error
//qpipoptmat: The number of rows and columns in H must be equal the number of elements of f
//at line     215 of function qpipoptmat called by :  
//[xopt,fopt,exitflag,output,lambda]=qpipoptmat(H,f,A,b,Aeq,beq,lb,ub,[],param)

[xopt,fopt,exitflag,output,lambda]=qpipoptmat(H,f,A,b,Aeq,beq,lb,ub,[],param)

