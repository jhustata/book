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


forvalues i=1/1 {

    quie {
    
              if 1 { //log,set,macro
        
                  timer on 1
        
                  capture log close
                  log using wk1.ph.340.700-`i'.log, replace 
        
                  cls 
        
                  global url https://data.nber.org/mortality/
                  global filename mort1959.dta
        
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
         
                  save mort.usa, replace 
        
                  timer off 3
        
              }
    
              if 4 {
        
                  timer on 4
        
                  noi di "# of deaths: `c(N)' & # of variables: `c(k)'"
                  noi lookfor year
                  g deaths=1
                  
                  preserve 
                  collapse (count) deaths, by(datayear)
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
        
        
                  save mort.fig, replace 
        
                    
              }
    
    timer list 
    log close 
    
    }
    
}

```

logfiles:

&nbsp;&nbsp;&nbsp; [quietly](wk1.ph.340.700-qui.txt)

&nbsp;&nbsp;&nbsp; [noisily](wk1.ph.340.700-noi.txt)
