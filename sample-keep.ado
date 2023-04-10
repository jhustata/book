capture program drop samplekeep
program define samplekeep

	preserve 
	    
		if 0 { //background:recap,intro
			
			1. names: c(N), c(k)
			2. content: rows, columns
			3. program: to change values
			
		}
		
		if 1 { //methods:sample,keep
			
			global url https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/
			global datafile DEMO.XPT 
			
		}
		
		if 2 { //results:
			
			cls
			di "samplekeep program running..."
			di ""
			di ""
			
			import sasxport5 "${url}${datafile}", clear 
			di "rows: `c(N)' & columns: `c(k)' ... before programs' effects"
			di ""
			di ""
			
		}
		
		if 3 { //conclusions:
			
			lookfor age sex race 
			keep ridageyr riagendr ridreth2
			
			di "rows: `c(N)' & columns: `c(k)' ... after keep comand "
			di ""
			di ""
			
			sample 1
			di "rows: `c(N)' & columns: `c(k)' ... after sample command "
			
		}
		
		if 4 { //acknowledge: snippets from quietly
			
			//see https://jhustata.github.io/book/bbb.html
			
		}
		
		if 5 { //references
		
		    
			di ""
			di ""
			di ""
			di "Source: $url"
			
		}
	restore 
	
end
