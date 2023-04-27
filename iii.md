# capture 

Let's talk about flexible programs. First the sort of inflexible programs we started off with:

```stata

use ../downloads/transplants, clear

capture program drop table1
program define table1
    	
	    qui {
			
            disp "Variable, mean(SD), range" 

			foreach v of varlist age wait_yrs rec_wgt_kg  {
				
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

table1

```

This program is of value only to someone using `transplants.dta`, who happens to be interested in the `mean (sd)` of age wait_yrs rec_wgt_kg.

So lets try to add some flexibility to make this program useful beyond this dataset and selected variables.

We'll achieve this task by introducing `syntax varlist`, something we already did two weeks ago:

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

In this program the user specifies the variables to be included in the `table1_v` output. If we may recall `chapter 2: r(mean)`:

*local macro
     * name -> `varlist`
     * content -> `age wait_yrs rec_wgt_kg`

This snippet shouldn't confuse you:

```stata

			foreach v of varlist `varlist' {

```
`foreach v of varlist` is the syntax for a loop. It generates a local macro `v`

And `varlist` is a local macro named in the `syntax varlist` line of code of the   `table1_v` program

The content of this macro is to be determined by the user.

Now lets add even more flexibility in our next iteration of `table1`

```stata

use ../downloads/transplants, clear

capture program drop table1_v2
program define table1_v 2
    
	syntax [varlist]
	
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


table1_v2

```

What is the difference between `table1_v2` and `table1`?

And between `table1_v2` and `table1_v1`?

Let's add even **more** flexibility:

```stata

use ../downloads/transplants, clear

capture program drop table1_v3
program define table1_v3
    
	syntax [varlist] [if]
	
	    qui {
			
            disp "Variable, mean(SD), range" 

			foreach v of varlist `varlist' {
				
				quietly sum `v' `if'
				
				#delimit ;
				noi di "`v'"  
				    _col(15) %3.2f r(mean) "("  %3.2f r(sd) ")" 
					_col(30) %3.2f r(min) "-" %3.2f r(max)
				;
				#delimit cr

        }

} 
end


table1_v3 if age<20

```