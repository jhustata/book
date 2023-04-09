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
		          g id=_n+2
		          insobs 1
		          replace v1="#delimit ;" in `c(N)'
		          insobs 1
		          replace v1="infix" in `c(N)'
		          insobs 1
		          replace v1="using ${url}`file'.dat ;" in `c(N)'
		          insobs 1
		          replace v1="#delimit cr" in `c(N)'
		          replace id=1 if v1=="#delimit ;"
		          replace id=2 if v1=="infix"
		          replace id=`c(N)' if v1=="using ${url}`file'.dat ;"
		          replace id=id-1 if v1=="using ${url}`file'.dat ;"
		          replace id=`c(N)' if v1=="#delimit cr"
		          sort id
		          drop id
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
		       tempfile labs
		       save `labs'

		       use `vars', clear
		       append using `labs'
			   
			   preserve 
			     
				   g rvarselect=.
				   forvalues i=1/4 {
				   	
				       set seed 340600 
				      replace  rvarselect=round(runiform(0,100))
			           recode rvarselect (0/25=1)(26/50=2)(51/75=3)(76/100=4)
					   noi tab rvarselect
				   
			          #delimit ;
                       //apply to only variable; keep all labels
				       keep if strpos(concat,"SEQN")    |
				               strpos(concat,"delimit") |
				               strpos(concat,"infix")   |
						       strpos(concat,"using")   |
						       rvarselect==`i'
						    ;
						
			          #delimit cr	
				      //drop rvarselect
					  
                      noi count
    	              noi outfile using "`file'-`i'.do", noquote replace
			          noi di "outfile using `file'.do"
			   
			   
			        }
					
			   restore 
			   

			    
			
		   }
		   
		} 
		
		//log close 
		
	}
	
}
