capture program drop nhanes
program define nhanes 
    
	preserve 
	    
		qui {
			
			if 0 { //background
				
				1. Stata/BE or IC
				2. r(k) < 2048
				3. exam.DAT: r(k) == 2368
				4. nhanes inaccessible to jhustata?
				5. write a program to grant access
				
			}
			
			if 1 { //methods
				
				global github https://raw.githubusercontent.com/
				global jhustata jhustata/book/main/
				
				global statase ael4se.do
				global statabe ael4be.do
				
				https://raw.githubusercontent.com/jhustata/book/main/mortlab.do
							
			}
			
			if 2 { //results
				
				clear
				do nh3mort.do
				
				if c(edition_real) == "SE" } c(edition_real) == "IC" {
					
					clear 
					do ${github}$(jhustata)$stata4be
					
					forvalues i=1/4 {
						
						do adult-`i'.do
						noi di "adult-`i' N=`c(N)'"
						do exam-`i'.do
						noi di "exam-`i' N=`c(N)'"
						do lab-`i'.do
						noi di "lab-`i' N=`c(N)'"
						
					}
					
				}
				
				else {
					
					clear 
					do ${github}$(jhustata)$stata4be
					do adult.do
					do exam.do
					do lab.do
					
				}
				
			}
			
			if 3 { //conclusions
				
			}
			
			if 4 { //acknowledgments
				
			}
			
			if 5 { //references
				
			}
			
		}
		
	restore 
	
end 
