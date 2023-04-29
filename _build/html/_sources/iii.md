# capture 

[video](https://jhjhm.zoom.us/rec/share/v0m2jFUdZ5JZPtweKMAZlAbR0pQg07H7SaK3PllQ7u8Y1FtDFYN3VdYwBqsjw7jZ.GKpzR2_veBwZCfi9?startTime=1682624085000)

Let's talk about flexible programs. We'll discuss this with demos using `transplants.dta`. We started off with quite inflexible programs:

```stata

use transplants, clear

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
use transplants, clear

capture program drop table1_v1
program define table1_v1
    
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


table1_v1 age wait_yrs rec_wgt_kg 
```

In this program the user specifies the variables to be included in the `table1_v` output. If we may recall `chapter 2: r(mean)`:

local macro

	 name -> `varlist'
     content -> age wait_yrs rec_wgt_kg

This snippet shouldn't confuse you:

```stata

			foreach v of varlist `varlist' {

```
`foreach v of varlist` is the syntax for a loop. It generates a local macro `v`

What? Yup, every loop syntax generates a local macro and its the programmer who assigns the `name` to the macro. In this example, the `content` of the macro is...

```stata
  `varlist'
```
it is holds user-defined `content` as contrasted with system/programmer-defined `names` (as the programmer you are now a part of the system). 

Now lets add some more flexibility in the next iteration of `table1`

```stata

use transplants, clear

capture program drop table1_v2
program define table1_v2
    
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

And this?

```stata

use transplants, clear 

capture program drop table1_v4
program define table1_v4
    
	syntax [varlist] [if], [round]
	
	    qui {
			
			local D %3.0f
			
			if "`round'" != "" {
				
				local D %3.0f
				
			}
			
			else {
				
				local D %3.2f
				
			}
			
            disp "Variable, mean(SD), range" 

			foreach v of varlist `varlist' {
				
				quietly sum `v' `if'
				
				#delimit ;
				noi di "`v'"  
				    _col(15) `D' r(mean) "(" `D' r(sd) ")" 
					_col(30) `D' r(min) "-" `D' r(max)
				;
				#delimit cr

        }

} 
end


table1_v4 age peak_pra, round

```

And the *coda*...

```stata

use transplants, clear

capture program drop table1_v5
program define table1_v5
    
	syntax [varlist] [if], [title(string)] [precision(int 1)] 
	
	    qui {
			
			if "`title'" != "" {
				
				noi di "`title'"
				
			}
			
			assert inrange(`precision',0,6)
			local pplus = `precision'+1
			local D %`pplus'.`precision'f
						
            disp "Variable, mean(SD), range" 

			foreach v of varlist `varlist' {
				
				preserve 
				    capture keep `if'
				    quietly sum `v' 
				
				    #delimit ;
				    noi di "`v'"  
				        _col(15) `D' r(mean) "(" `D' r(sd) ")" 
					    _col(30) `D' r(min) "-" `D' r(max)
				    ;
				    #delimit cr
				restore 

        }

} 
end

table1_v5 age bmi wait_yrs if age>40, precision(2) title("Study Population")

```

In this coda, subtle variants when compared with iterations 1-4 are introduced:

```stata

, title(string)] //title is programmer-defined, string is a programmer-constraint but the content will be user-defined

, [precision(int 1)] //precision is programmer-defined, int is a programmer-constraint but the actual integer will be user-defined

//note: %`pplus'.`precision'f has identical structure to, say, %3.2f; the integer to the left MUST > the integer to the right of '.`
local D %`pplus'.`precision'f 

capture keep `if' //keeps subset defined by user; if the user doesn't use the conditional `if', the `capture' insures that Stata doesn't return an error 

//this means the programmer doesn't have to  include an `if' option with each command that has `syntax varlist if`

preserve
    //more on this later!
restore

```