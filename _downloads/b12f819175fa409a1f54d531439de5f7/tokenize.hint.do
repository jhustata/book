qui {
	
	if 0 { //background 
		
		/*
		1. chapter: tokenize https://jhustata.github.io/book/aaa.html
		2. bibliography: https://jhustata.github.io/book/zzz.html
		3. among other things... "creating a counter with alphabets"
		*/
		
	}
	
	if 1 { //methods
		
		timer on 1
		
		global ph340600 "/users/d/desktop"
		global url1 https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/
		global url2 https://wwwn.cdc.gov/Nchs/Nhanes/2001-2002/
		global url3 https://wwwn.cdc.gov/Nchs/Nhanes/2003-2004/
		global datafile1 DEMO.XPT 
		global datafile2 DEMO_B.XPT 
		global datafile3 DEMO_C.XPT 
		cls
		cd $ph340600 //direct .log file  here
		
		capture log close
		log using tokenize.hint.log, replace 
		
		noi di ""
		noi di "c-class command: c(alpha) & c(ALPHA): "
		noi di ""
		noi di "`c(alpha)'"
		noi di "`c(ALPHA)'"
		
		timer off 1
		
	}
	
	if 2 { //results
		
		timer on 2
		
		noi di ""
		noi di word("`c(ALPHA)'", 5) 
		noi di ""
		
		forvalues i = 7/9 {
			
			noi di word("`c(ALPHA)'", `i')
			
		}
		
		noi di ""
		foreach letter in `c(alpha)' {
			
			noi di "`letter'"
			
		}
		
		noi di ""
		tokenize `c(alpha)'
		
        forvalues i = 1/26 {
			
			noi di "letter `i' is ``i''"
			
}
		
		timer off 2
		
	}
	
	if 3 { //conclusion
		
		timer on 3
		
		import sasxport5 "${url1}${datafile1}", clear
		noi di ""
		noi di "HINT: bonus point challenge in chapter: tokenize"
		noi di "$datafile1"

		import sasxport5 "${url2}${datafile2}", clear
		noi di "$datafile2"
	
		import sasxport5 "${url3}${datafile3}", clear
		noi di "$datafile3"
		noi di ""
		
		timer off 3
		
	}
	
	if 4 { //acknowledgements
		
	}
	
	if 5 { //references
		
	}
	
	noi timer list 
	timer clear 
	log close 
	
}

