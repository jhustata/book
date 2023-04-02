local aesthetic=10.1 //no meaning 
local loop=`aesthetic'

foreach command in "if 10" noisily quietly {
	
    `command' {
		      
			  if `loop' == `aesthetic' { //functional
		
				 local command: di "if"
		
	          }
			  
			  local loop = `loop' + 1 //divergence,emergence
			  
			  if 0 { //background: local,if,update
			  	
				  1. local macros -> `name'
				  2. if conditionals: aesthetics,functionality
				  3. update of `loop' macro value
				
			  }
	
              if 1 { //methods: macros,logfile,settings
        
                  timer on 1
				  
                  global url https://data.nber.org/mortality/
                  global filename mort1959.dta
				  global logfile wk1.ph.340.700-`command'
                  
				  cls
                  capture log close
                  log using ${logfile}.log, replace 
                   
                  set more off
				  version 15
				  noi di "`c(current_time)' `c(current_date)'" 
        
                  timer off 1
        
              }
    
              if 2 { //results:data,year,save
        
                  timer on 2
        
                  forvalues i=1959/1961 {
            
                      use "${url}`i'/mort`i'", clear 
					  noi di ""
					  noi di "# of deaths in `i'=`c(N)'"
					  noi di ""
                      save y`i', replace 
            
                  timer off 2

                  }
        
        
        
              }
    
              if 3 { //conclusion:N as `i'->2017???
    
                  timer on 3
        
                  clear 
                  forvalues i=1959/1961 {
            
                      append using y`i'
            
                  }
         
        
                  timer off 3
        
              }
    
              if 4 { //acknowledge:i=1959/1961 -> pilot
        
                  timer on 4
        
                  noi di "# of deaths: `c(N)' & # of variables: `c(k)'"
                  noi lookfor year
                  g deaths=1
                  
                  preserve 
                  collapse (count) deaths, by(datayear)
				     save twoway.mort.dta,replace
                     noi di "# of deaths: `c(N)' & # of variables: `c(k)'"
                     noi list 
                     #delimit ;
                     line deaths datayear, 
                       sort 
                        ti("United States")
                        xti("Year"); 
                     #delimit cr
                  restore
        
                  noi di "# of deaths: `c(N)' & # of variables: `c(k)'"
                  timer off 4
        
              }
    
              if 5 { //reference:emerging,supersize.dta
        
        
                  save mort.dta, replace 
        
                    
              }
    
    noi timer list 
	timer clear  
    log close 
    
    }
    
}
