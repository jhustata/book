qui {
	
	if 0 { //background:hw2,trials,iterate
	
	    1. use this code to test
		2. your deliverables for hw2
		3. fix any issues and retry 
	
	}
	
	if 1 { //methods:macros,logfile,settings
	
	    //`cd filepath` before running this (or any) script
		#delimit ;
	    global workdir `c(pwd)' ; //`c(pwd)' doesn't have to be your workdir
		
		capture log close test ;
		log using text_yourname.log, 
		    text replace name(test);
		
		cls ;
		clear all ;
	
	} ;
	
	if 2 { ; //results:data,programs,output
	
	    //q1
		do Assignment2-solutions.do ;
		
		
		//q2
	    use transplants,clear ;
		
		//this programs should work on any dataset and any variable
		noi unilogit age gender wait_yrs, 
		    outcome(died);
			
		noi unilogit age gender wait_yrs if age>60, 
		    outcome(died);
		#delimit cr
		
	}
	
	noi { // prime test
	
		prime, n(-1) //Invalid input: enter a natural number greater than 1.
		prime, n(0) //Invalid input: enter a natural number greater than 1.
		prime, n(1) //Invalid input: enter a natural number greater than 1.
		prime, n(2) // prime
		prime, n(100) // not prime
		prime, n(1033) // prime
	}
	
	log close test
	
}
