qui {
	
	if 0 { //background
		
		/*
		1. lab1
		2. revising ch pwd
		3. etc.
		*/
		
	}
	
	if 1 { //methods: macros, pwd, logfile 
		
		timer on 1
		
		global workdir1 /Users/d/Dropbox (Personal)/
		global workdir2 7a.τάξη,α/4.aesthetic/ph.340.600/	
		global datafile transplants.dta
		cd "${workdir1}${workdir2}"
		
		cls 
		capture log close 
		log using lab1.log, replace 

		timer off 1
		
	}
	
	if 2 { //results: data
		
		use ${datafile}
		noi di "Q5. How many observations does the dataset have? A5. `c(N)'"
		
	}
	
	if 3 {
		
	}
	
	if 4 {
		
	}
	
	if 5 {
		
	}
	
}
