//Primal infeasible mps file

//Reference : enlight9.mps.gz problem file,http://miplib.zib.de/miplib2010.php

[xopt,fopt,status,output]=fot_intlinprog("enlight9.mps",[1],[2])

// !--error 10000 
//fot_intlinprog: Unexpected number of input arguments : 3 provided while should be in the set of [1 2]
//at line     211 of function fot_intlinprog called by :  
//[xopt,fopt,status,output]=fot_intlinprog("enlight9.mps",[1],[2])
//at line       5 of exec file called by :    
//exec fot_intlinprog_mps_input.sce
