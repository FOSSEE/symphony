//Find x in R^6 such that:
// Check if the number of input is more
conMatrix= [1,-1,1,0,3,1;
-1,0,-3,-4,5,6;
2,5,3,0,1,0
0,1,0,1,2,-1;
-1,0,2,1,1,0];
conLB=[1;2;3;-%inf;-%inf];
conUB = [1;2;3;-1;2.5];
lb=[-1000;-10000; 0; -1000; -1000; -1000];
ub=[10000; 100; 1.5; 100; 100; 1000];
//and minimize 0.5*x'*Q*x + p'*x with
p=[1; 2; 3; 4; 5; 6]; Q=eye(6,5);
nbVar = 6;
nbCon = 5;
x0 = repmat(0,nbVar,1);
param = list("MaxIter", 300, "CpuTime", 100);
[xopt,fopt,exitflag,output,lambda]=qpipopt(nbVar,nbCon,Q,p,lb,ub,conMatrix,conLB,conUB,x0,param,[])

//Error
//qpipopt: Unexpected number of input arguments : 12 provided while should be 9, 10 or 11
//at line      91 of function qpipopt called by :  
//[xopt,fopt,exitflag,output,lambda]=qpipopt(nbVar,nbCon,Q,p,lb,ub,conMatrix,conLB)