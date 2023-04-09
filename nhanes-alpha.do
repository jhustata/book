capture program drop nhanes
program define nhanes 
    
	preserve 
	    
		qui {
			
			if 0 { //background:r(mean) 
				
				1. Stata/BE or IC
				2. r(k) < 2048
				3. exam.DAT: r(k) == 2368
				4. inaccessible to jhustata
				5. program to grant access
				
			}
			
			if 1 { //methods:$keepvars
				
				timer on 1
				
				global github https://raw.githubusercontent.com/
				global jhustata jhustata/book/main/
				global keepvars HSAGEIR BMPHT BMPWT HAZA8AK1 CEP GHP HAB1
				
				timer off 1
											
			}
			
			if 2 { //results:.dofiles
			
			    timer on 2
				
				clear
				
				do ${github}${$jhustata}nh3mort.do 
				
				if c(edition_real) == "SE"  | c(edition_real) == "IC" {
					
					clear 
					
					do ${github}${$jhustata}nhanes-alpha-if2.do 
					
				}
				
				else { 
					
					clear 
					
					do ${github}${$jhustata}nhanes-alpha-if0.do
					
				}
				
				
				timer off 2
				
			}
			
			if 3 { //conclusions:queueing
			
			    timer on 3
			
			    timer on 31
				clear
				do adult.do
				rename *,lower
				save adult.dta,replace 
				timer off 31
				
				timer on 32
				clear 
				do exam.do
				rename *,lower
				save exam.dta,replace 
				timer off 32
				
				timer on 33
				clear
				do lab.do
				rename *,lower
				save lab.dta,replace 
				timer off 33
				
				timer off 3
				
			}

			if 4 { //acknowledge:linkage
				
				timer on 4
				
				use adult, clear
				merge 1:1 seqn using exam,nogen
				merge 1:1 seqn using lab,nogen
				merge 1:1 seqn using nh3mort,nogen keep(matched)
				
				timer off 4
				
			}
			
			if 5 { //dataset4class:
				
				timer on 5
				
				compress
				lab dat "NHANES 1988-1994, survey & mortality"
				save "nh3andmort.dta", replace 
				
				timer off 5
				
			}
			
			if 6 { //survivalanalysis:
				
				timer on 6
				
        		lookfor mort
        		codebook mortstat
        		lookfor follow
        		g years=permth_exm/12

        		lookfor health
        		codebook hab1
        		global subgroup: var lab hab1
    
        		stset years, fail(mortstat)

        		#delimit ;
        		sts graph if inrange(hab1,1,5),
        		   by(hab1)
        		   fail
        		   ti("Morality in NHANES III",pos(11))
        		   subti("by self report: ${subgroup}",pos(11))
        		   yti("%",orientation(horizontal))
        		   xti("Years")
        		   per(100)
        		   ylab(0(20)80,
        		       format(%3.0f)
        		       angle(360)
        		   )
        		   legend(on
        		       lab(1 "Excellent")
        		       lab(2 "Good")
        		       lab(3 "Fair")
        		       lab(4 "Bad")
        		       lab(5 "Poor")
        		       ring(0)
        		       pos(11)
        		       col(1)
        		       order(5 4 3 2 1)
        		   )
        		   note("Source: RDC/NCHS/CDC/DHHS")  
        		;
        		#delimit cr
        		
        		graph export nh3andmort.png,replace 
        		
        		stcox i.hab1 if inrange(hab1,1,5)
		
		
				timer off 6
				
			}
			
			noi timer list 
			
		}
			
	restore 
	
end 
