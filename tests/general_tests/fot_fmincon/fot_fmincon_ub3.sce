
//Check if lower bound is column vector of correct dimensions

function y=fun(x)
y=x(1)+x(2);
endfunction

x0 = [1,2];
A = [3,4];
b = [7];
Aeq = [];
beq = [];
lb = [2,4];
ub = [3;4;7];
options=struct("MaxIter", [1500], "CpuTime", [500], "Gradient", "OFF", "Hessian", "OFF");

//Error
//fot_fmincon: Expected Column Vector (number of Variables X 1) for upper bound (8th Parameter) 
//at line     448 of function fot_fmincon called by :  
//[xopt,fopt,exitflag,output,lambda,gradient,hessian] = fot_fmincon (fun, x0, A, b, Aeq, beq, lb, ub);
//at line      24 of exec file called by :    
//exec fot_fmincon_ub3.sce

[xopt,fopt,exitflag,output,lambda,gradient,hessian] = fot_fmincon (fun, x0, A, b, Aeq, beq, lb, ub);
