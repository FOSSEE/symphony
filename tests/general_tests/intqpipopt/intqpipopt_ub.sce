//Find x in R^6 such that:
//b is a string
A= [-1,1,0,3,1;
-1,0,-3,-4,5;
2,5,3,0,1
0,1,0,1,2;
-1,0,2,1,1];
b=[1;2;3;-%inf;-%inf];
lb=[-1000;-10000; 0; -1000; -1000; -1000];
ub="[10000; 100; 1.5; 100; 100; 1000];"
//and minimize 0.5*x'*H*x + f'*x with
f=[1; 2; 3; 4; 5; 6]; H=eye(6,6);

//  !--error 10000 
// intqpipopt: Expected type ["constant"] for input argument ub at input #9, but got "string" instead.
// at line      56 of function Checktype called by :  
// at line     198 of function intqpipopt called by :  
// [xopt,fopt,exitflag,output,lambda]=intqpipopt(H,f,intcon,A,b,[],[],lb,ub)
// at line      22 of exec file called by :    
// exec intqpipopt_ub.sce


[xopt,fopt,exitflag,output,lambda]=intqpipopt(H,f,intcon,A,b,[],[],lb,ub)