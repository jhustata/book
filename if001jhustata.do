qui {
	
	if 1 { //if1jhustatasnippet: macros,logfile,settings
		
		timer on 1
		
		global dofilename if1jhustata
	
	    capture log close
	    log using $if1jhustata, replace 
		
		set more off
		version 13
		
		timer off 1

    }
	
	if 99 { //if99jhustatasnippet: placeholder, log close in context
		
		timer on 99
		
		di c(N) "" c(k)
		
		timer off 99
		
	}
	
	//coda: timer,log
	timer list
	timer clear //optional
	
	log close
	
}
