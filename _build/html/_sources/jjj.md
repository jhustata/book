# twoway

[Task](https://jhjhm.zoom.us/rec/share/wQFdA9HfocN5RMJek5hpLG4sgbAV3uf2cQCG6zf1TtUvHtS7FTDsJyrxWQ0899Bu.-f2SVivW9gZBLA_t):

Using the resources available to you at the National Bureau of Economic Research (NBER), reproduce the twoway plot shown under the output link below.

The Stata code provides several hints about how you may approach this challenge. Don't hesitate to ask questions on CoursePlus if you run into any trouble! 


Databases:


&nbsp;&nbsp;&nbsp; [cdc.gov](https://ftp.cdc.gov/pub/)

&nbsp;&nbsp;&nbsp; [nber.org](https://data.nber.org/mortality/)


Output:


&nbsp;&nbsp;&nbsp; [twoway](mortality.png)

   
Hint:

```stata

foreach command in noisily quietly {

    `command' {
    
              if 1 { //macros,logfile,settings
        
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
    
              if 2 { //timer,loop,data
        
                  timer on 2
        
                  forvalues i=1959/1961 {
            
                      use "${url}`i'/mort`i'", clear 
                      save y`i', replace 
            
                  timer off 2

                  }
        
        
        
              }
    
              if 3 { //clear,append,save
    
                  timer on 3
        
                  clear 
                  forvalues i=1959/1961 {
            
                      append using y`i'
            
                  }
         
        
                  timer off 3
        
              }
    
              if 4 {
        
                  timer on 4
        
                  noi di "# of deaths: `c(N)' & # of variables: `c(k)'"
                  noi lookfor year
                  g deaths=1
                  
                  preserve 
                  collapse (count) deaths, by(datayear)
				     save twoway.mort.dta,clear
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
    
              if 5 {
        
        
                  save mort.dta, replace 
        
                    
              }
    
    noi timer list 
	timer clear  
    log close 
    
    }
    
}

```

logfiles:

&nbsp;&nbsp;&nbsp; [quietly](wk1.ph.340.700-qui.txt)

&nbsp;&nbsp;&nbsp; [noisily](wk1.ph.340.700-noi.txt)

bonus .dofiles: spot the difference

&nbsp;&nbsp;&nbsp; [if 10 {](debugging.do)

&nbsp;&nbsp;&nbsp; [if 10 {](debugging_v2.do)