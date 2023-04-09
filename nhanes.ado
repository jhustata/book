capture program drop nhanes
program define nhanes 
    
	preserve 
	    
		qui {
			
			if 0 { //background: r(mean) session
				
				1. Stata/BE or IC
				2. r(k) < 2048
				3. exam.DAT: r(k) == 2368
				4. inaccessible to jhustata
				5. program to grant access
				
			}
			
			if 1 { //methods: macros
				
				timer on 1
				
				global github https://raw.githubusercontent.com/
				global jhustata jhustata/book/main/
				global keepvars HSAGEIR BMPHT BMPWT HAZA8AK1 CEP GHP HAB1
				
				timer off 1
											
			}
			
			if 2 { //results
			
			    timer on 2
				
				clear
				do ${github}${$jhustata}nh3mort.do
				
				if c(edition_real) == "SE"  | c(edition_real) == "IC" {
					
					clear 
					do ael-beta.do
					
				}
				
				else { //queueing
					
					clear 
					
				}
				
				
				timer off 2
				
			}
			
			if 3 { //conclusions
			
			    timer on 3
			
			    timer on 31
				clear
				do adult.do
				save adult.dta,replace 
				timer off 31
				
				timer on 32
				clear 
				do exam.do
				save exam.dta,replace 
				timer off 32
				
				timer on 33
				clear
				do lab.do
				save lab.dta,replace 
				timer off 33
				
				timer off 3
				noi timer list 
				
			}

			
		}
		
	restore 
	
end 
