// Copyright (C) 2015 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author: Guru Pradeep Reddy Bhanu Priya Sayal
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
#include"OsiSolverInterface.hpp"
#include "OsiClpSolverInterface.hpp"
#include "CoinPackedMatrix.hpp"
#include "CoinPackedVector.hpp"

extern "C"{

#include <api_scilab.h>
#include <Scierror.h>
#include <localization.h>
#include <sciprint.h>
//Solver function
 const char fname[] = "linearprog";
/* ==================================================================== */
int sci_linearprog(scilabEnv env, int nin, scilabVar* in, int nopt, scilabOpt opt, int nout, scilabVar* out) 
{
	sciprint("no. of inputs: %d\n", nin);
	sciprint("no. of outputs: %d\n",nout);
	//Objective function
	double* obj = NULL;  
	//Constraint matrix coefficients
	double* conMatrix = NULL;  
	//Constraints upper bound
	double* conLB= NULL;
	//Constraints lower bound
	double* conUB= NULL;
	//Lower bounds for variables
	double* lb= NULL;  
	//Upper bounds for variables
	double* ub= NULL;
	//options for maximum iterations and writing mps
	//double* options= NULL;
	//Flag for Mps
	//double flagMps= NULL;
	//Number of rows and columns in objective function
	int nVars=0, nCons=0;

	int inr1 = 0;
    int inc1 = 0;
	int size1 = 0;
	
	if (nin !=8) 
	{
        	Scierror(999, "%s: Wrong number of input arguments: %d expected.\n", fname, 8);
        	return STATUS_ERROR; 
	}
	
	if (nout !=2) //Checking the output arguments

	{
		Scierror(999, "%s: Wrong number of output argument(s): %d expected.\n", fname, 2);
		return 1;
	}
	////////// Manage the input argument //////////
	
	//Number of Variables
	if (scilab_isInt32(env, in[0]) == 0 || scilab_isScalar(env, in[0]) == 0)
    	{
        	Scierror(999, "%s: Wrong type for input argument #%d: A int expected.\n", fname, 1);
        	return 1;
    	}

	scilab_getInteger32(env, in[0], &nVars);

	//Number of Constraints
	if (scilab_isInt32(env, in[1]) == 0 || scilab_isScalar(env, in[1]) == 0)
    	{
        	Scierror(999, "%s: Wrong type for input argument #%d: A int expected.\n", fname, 2);
        	return 1;
    	}

	scilab_getInteger32(env, in[1], &nCons);


	//Objective function from Scilab
	
	
	if (scilab_isDouble(env, in[2]) == 0 || scilab_isMatrix2d(env, in[2]) == 0)
    	{
        	Scierror(999, "%s: Wrong type for input argument #%d: A double matrix expected.\n", fname, 3);
       		return 1;
    	}	
		
		size1 = scilab_getDim2d(env, in[2], &inr1, &inc1);	
    	scilab_getDoubleArray(env, in[2], &obj);
		

	if (nCons!=0)
	{
		//conMatrix matrix from scilab
	
		if (scilab_isDouble(env, in[3]) == 0 || scilab_isMatrix2d(env, in[3]) == 0)
    		{
        		Scierror(999, "%s: Wrong type for input argument #%d: A double matrix expected.\n", fname, 4);
       			return 1;
    		}	
		
		scilab_getDoubleArray(env, in[3], &conMatrix);


		//conLB matrix from scilab
		
		if (scilab_isDouble(env, in[4]) == 0 || scilab_isMatrix2d(env, in[4]) == 0)
    		{
        		Scierror(999, "%s: Wrong type for input argument #%d: A double matrix expected.\n", fname, 5);
       			return 1;
    		}	
		

		scilab_getDoubleArray(env, in[4], &conLB);

		//conUB matrix from scilab
		if (scilab_isDouble(env, in[5]) == 0 || scilab_isMatrix2d(env, in[5]) == 0)
    		{
        		Scierror(999, "%s: Wrong type for input argument #%d: A double matrix expected.\n", fname, 6);
       			return 1;
    		}	
		
		scilab_getDoubleArray(env, in[5], &conUB);


	}

	//lb matrix from scilab
	
	if (scilab_isDouble(env, in[6]) == 0 || scilab_isMatrix2d(env, in[6]) == 0)
    	{
        	Scierror(999, "%s: Wrong type for input argument #%d: A double matrix expected.\n", fname, 7);
       		return 1;
    	}	
	
	scilab_getDoubleArray(env, in[6], &lb);




	//ub matrix from scilab
	if (scilab_isDouble(env, in[7]) == 0 || scilab_isMatrix2d(env, in[7]) == 0)
    	{
        	Scierror(999, "%s: Wrong type for input argument #%d: A double matrix expected.\n", fname, 8);
       		return 1;
    	}	
	
	scilab_getDoubleArray(env, in[7], &lb);



	//get options from scilab
	/*if (scilab_isDouble(env, in[8]) == 0 || scilab_isMatrix2d(env, in[8]) == 0)
    	{
        	Scierror(999, "%s: Wrong type for input argument #%d: A double matrix expected.\n", fname, 9);
       		return 1;
    	}	
	
	scilab_getDoubleArray(env, in[8], &lb);*/



	OsiSolverInterface* si = new OsiClpSolverInterface();
   //Defining the constraint matrix
   CoinPackedMatrix *matrix =  new CoinPackedMatrix(false , 0 , 0);
   matrix->setDimensions(0 , nVars);
   for(int i=0 ; i<nCons ; i++)
   	{
    	CoinPackedVector row;
	 	for(int j=0 ; j<nVars; j++)
	 		{
   				row.insert(j, conMatrix[i+j*nCons]);
   	 		}
        matrix->appendRow(row);
   	}
	//setting options for maximum iterations
    si->setIntParam(OsiMaxNumIteration,1500);

    //Load the problem to OSI
    si->loadProblem(*matrix , lb , ub, obj , conLB , conUB);

    //Solve the problem
    si->initialSolve();
	
	//Output the solution to Scilab
	//get solution for x
		

	const double* xValue;
	out[0] = scilab_createDoubleMatrix2d(env, nVars, 1, 0);
	scilab_getDoubleArray(env, out[0], &xValue);
	


	xValue = si->getColSolution();
	sciprint("%f\n", xValue[0]);
	sciprint("%f\n", xValue[1]);
	
	//get objective value
	double objValue = si->getObjValue();
	
		//get Status value
	double status_ = 0;
	if(si->isProvenOptimal())
			status_=0;
	else if(si->isProvenPrimalInfeasible())
			status_=1;
	else if(si->isProvenDualInfeasible())
			status_=2;
	else if(si->isIterationLimitReached())
			status_=3;
	else if(si->isAbandoned())
			status_=4;
	else if(si->isPrimalObjectiveLimitReached())
			status_=5;
	else if(si->isDualObjectiveLimitReached())
			status_=6;
		
	//get number of iterations
	double iterations  = si->getIterationCount(); 	
	
	//get reduced cost
	const double* Zl = si->getReducedCost();
	
	//get dual vector
	const double* dual = si->getRowPrice();
	

	
	
	//scilab_getDoubleArray(env, out[0], &xValue);



	

	out[1] = scilab_createDouble(env, objValue);
	/*out[2] = scilab_createDouble(env, status_);
	out[3] = scilab_createDouble(env, iterations);
	out[4] = scilab_createDoubleMatrix(env, 1 , nVars , 0);
	out[5] = scilab_createDoubleMatrix(env, 1 , nCons , 0);*/
	


	return 0;	

	}

}


  	
   
