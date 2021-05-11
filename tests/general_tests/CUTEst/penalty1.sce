//---------penalty1.mod--------

/*
N=10; In scilab:
fval = 0.0001305;
Cpu_Time: 0.076
 output  = 

  Iterations = 14
  Cpu_Time = 0.076
  Objective_Evaluation = 22
  Dual_Infeasibility = 0.0000189
  Message = "Optimal Solution Found"
  
  for same n in NEOS server, fval = 4.6053629348787437e-07 (scaled) 
  for same n in NEOS server, fval = 7.0876536396749192e-05 (unscaled) 
  f = 7.08765e-05

N=100; In scilab:
fval = 0.0635000;
Cpu_Time: 0.008
 output  = 

  Iterations = 1
  Cpu_Time = 0.008
  Objective_Evaluation = 2
  Dual_Infeasibility = 0.00002
  Message = "Optimal Solution Found"

  for same n in NEOS server, fval = 7.4530367665711525e-10 (scaled) 
  for same n in NEOS server, fval = 1.0086932506988202e-03 (unscaled) 
  f = 0.00100869

N=1000; In scilab:
  fval  = 2.1897404
 output  = 

  Iterations = 32
  Cpu_Time = 0.188
  Objective_Evaluation = 40
  Dual_Infeasibility = 0.4246078
  Message = "Optimal Solution Found"

For same n in gamsworld site list, fval = 0.00968618

for same n in NEOS server, fval or objective = 6.4394978143979231e-08 (scaled)
for same n in NEOS server, fval = 6.4394978143979227e+00(unscaled)
f = 6.4395
*/

//funcprot(0);
N=1000;
M = N+1;

x0 = zeros(1,N);
i = 1 : N;
x0(1,i) = i;
a = 10^-5;

function y=f(x)
    N=1000;
    M = N+1;
    a = 10^-5;
    j = 1:N;
    term1 =( sum((x(j)).^2)  - 0.25 ).^2; 
    term2 =sum(a .*( (x(j) - 1).^2) );
  
    y = term1+ term2;
endfunction

function g=fGrad(x)
    N=1000;
    M = N+1;
    a = 10^-5;
    j = 1:N;
    sqsum = sum( (x(j)).^2 );
    
    g = zeros(1,N);
    g(1,j) = (4.*x(j)).*(sqsum - 0.25) + 2.*a.*(x(j)-1) ;  
endfunction

options = struct("MaxIter", [1000000], "CpuTime", [600000], "GradObj", fGrad, "Hessian","off","GradCon","off","HessianApproximation", [1] );
[x,fval,exitflag,output] =fot_fmincon(f, x0,[],[],[],[],[],[],[],options)