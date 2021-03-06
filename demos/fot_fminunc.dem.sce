mode(1)
//
// Demo of fot_fminunc.sci
//

//Find x in R^2 such that it minimizes the Rosenbrock function
//f = 100*(x2 - x1^2)^2 + (1-x1)^2
//Objective function to be minimised
function y= f(x)
y= 100*(x(2) - x(1)^2)^2 + (1-x(1))^2;
endfunction
//Starting point
x0=[-1,2];
//Gradient of objective function
function y= fGrad(x)
y= [-400*x(1)*x(2) + 400*x(1)^3 + 2*x(1)-2, 200*(x(2)-x(1)^2)];
endfunction
//Hessian of Objective Function
function y= fHess(x)
y= [1200*x(1)^2- 400*x(2) + 2, -400*x(1);-400*x(1), 200 ];
endfunction
//Options
options=list("MaxIter", [1500], "CpuTime", [500], "GradObj", fGrad, "Hessian", fHess);
//Calling Ipopt
[xopt,fopt,exitflag,output,gradient,hessian]=fot_fminunc(f,x0,options)
// Press ENTER to continue
halt()   // Press return to continue
 
//Find x in R^2 such that the below function is minimum
//f = x1^2 + x2^2
//Objective function to be minimised
function y= f(x)
y= x(1)^2 + x(2)^2;
endfunction
//Starting point
x0=[2,1];
//Calling Ipopt
[xopt,fopt]=fot_fminunc(f,x0)
// Press ENTER to continue
halt()   // Press return to continue
 
//The below problem is an unbounded problem:
//Find x in R^2 such that the below function is minimum
//f = - x1^2 - x2^2
//Objective function to be minimised
function y= f(x)
y= -x(1)^2 - x(2)^2;
endfunction
//Starting point
x0=[2,1];
//Gradient of objective function
function y= fGrad(x)
y= [-2*x(1),-2*x(2)];
endfunction
//Hessian of Objective Function
function y= fHess(x)
y= [-2,0;0,-2];
endfunction
//Options
options=list("MaxIter", [1500], "CpuTime", [500], "GradObj", fGrad, "Hessian", fHess);
//Calling Ipopt
[xopt,fopt,exitflag,output,gradient,hessian]=fot_fminunc(f,x0,options)
//========= E N D === O F === D E M O =========//
