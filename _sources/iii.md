# capture 

Let's talk about flexible programs

```stata
use ../downloads/transplants, clear

capture program drop table1_v 
program define table1_v 
    
	syntax varlist
	
	    qui {
			
            disp "Variable, mean(SD), range" 

			foreach v of varlist `varlist' {
				
				quietly sum `v'
				
				#delimit ;
				noi di "`v'"  
				    _col(15) %3.2f r(mean) "("  %3.2f r(sd) ")" 
					_col(30) %3.2f r(min) "-" %3.2f r(max)
				;
				#delimit cr

        }

} 
end


table1_v age wait_yrs rec_wgt_kg
```