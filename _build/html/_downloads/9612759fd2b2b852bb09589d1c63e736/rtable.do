qui {
	
	if 0 { //background
		
		1. third-party estimation programs
		2. no e() macros available
		3. r(table) comes in handy
		
	}
	
	if 1 { //methods
		
		cls
	    use transplants,clear
        stset end_date,origin(transplant_date) fail(died)
		stcox age gender i.race prev_ki
		matrix define cox=r(table)

		}
	
	
	if 2 { //results
		
		putexcel set rtable,replace 
		
		tokenize "`c(ALPHA)'"
		
		forvalues i=1/9 {
			
			forvalues j=1/9 {
				
				local xlsx_cellvalue: di %3.2f cox[`j',`i']
				noi di `value'
				putexcel ``i''`j'=("`xlsx_cellvalue'")
				
			}
			
			
			
		}
		
	}

	
}
