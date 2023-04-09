qui {
	
	if 0 { //background,context
		
		1.chapter: delimit
		2.generalized: adult,exam,lab
		3.product: three .do files
		
	}
	
	if 1 { //settings,logfile,macros
		
		clear 
		capture log close 
		//log using nhanes.ael.log, replace 
		
        global url https://wwwn.cdc.gov/nchs/data/nhanes3/1a/ 
		global fyl adult exam lab 
		global range 1387/2624 2627/3865 2892/5259 5262/7629 640/995 998/1353
		
	}
	
	if 2 { //translate .sas -> .do
		
		local range=1
		forvalues i=1/3 { 

		   if 2.2 { //import .sas read-in commands
		   	
				local file: di word("$fyl",`i')
		        import delimited using "${url}`file'.sas",clear
				noi di "import using `file'.sas"

		   }

		   if 2.3 { //export .do read-in commands
		       preserve 
                  local num: di word("$range",`range')
		          keep in `num'
			      local range=`range'+1		          
				  keep v1

		          //sort id
		          //drop id
		          tempfile vars
		          format v1 %-20s
		          rename v1 concat 
		          keep concat 
		          save `vars'
		       restore 
		       
               local num: di word("$range",`range')
		       keep in `num'
			   local range=`range'+1
	           split v1, p(" = ")
	           gen concat="lab var "+v11+" "+v12
		       keep concat 
		       format concat %-20s
	           drop in `c(N)'
			   
			   local num=1
			   
			   if 0 {
			   
			        foreach v in $keepvars {
						
				        local var: di word("$keepvars",`num')
					    preserve
					        keep if strpos(concat,"`var'") | strpos(concat,"SEQN")    
					  	    save dat`num', replace 
						    noi 
					    restore 
					
					    local num=`num'+1
				
			       }
			   			   
			       clear
			       local N=wordcount("$keepvars")
			       forvalues i=1/`N' {
			   	
				        append using dat`i'
				        rm dat`i'.dta
				
			       }
			   
			   }
			   
			   duplicates drop 
		       tempfile labs
		       save `labs'

		       use `vars', clear
			   
			   local num=1
			   
			   if 0 {
			   
			        foreach v in $keepvars {
			   	 
				        local var: di word("$keepvars",`num')
					    preserve
					        keep if strpos(concat,"`var'") | strpos(concat,"SEQN")    
						    save dat`num', replace 
					    restore 
					
					    local num=`num'+1
				
			       }
			   
			       clear
			       local N=wordcount("$keepvars")
			       forvalues i=1/`N' {
			   	
				        append using dat`i'
				        rm dat`i'.dta
				
			       }
			   
			   }
			   
               duplicates drop 
		       g id=_n+2
		       insobs 1
		       replace concat="#delimit ;" in `c(N)'
		       insobs 1
		       replace concat="infix" in `c(N)'
		       insobs 1
		       replace concat="using ${url}`file'.dat ;" in `c(N)'
		       insobs 1
		       replace concat="#delimit cr" in `c(N)'
		       replace id=1 if concat=="#delimit ;"
		       replace id=2 if concat=="infix"
		       replace id=`c(N)' if concat=="using ${url}`file'.dat ;"
		       replace id=id-1 if concat=="using ${url}`file'.dat ;"
		       replace id=`c(N)' if concat=="#delimit cr"
			   sort id
			   drop id
			   append using `labs'
			   format concat %-20s
               noi count
    	       noi outfile using "`file'.do", noquote replace
			   noi di "outfile using `file'.do"
			    
			
		   }
		   
		} 
		
		//log close 
		
	}
	
}
