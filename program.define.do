capture program drop covidrisk 
program define covidrisk //qui {
	
	if 0 { //levels in .dofile structure
		
		1. quietly
		2. if 
		3. code-block
		4. script->program
		5. generalize
		
	}
	
	if 1 { //create dataset
		
		clear 
		set obs 1000
		set seed 340600
		g age=round(rnormal(40,15))
		g female=rbinomial(1,.6)
		g race=round(runiform(0,100))
		#delimit ;
		recode race
		    (0/70=1 "White")
			(71/83=2 "Hispanic")
			(84/92=3 "Black")
			(93/99=4 "Asian")
			(100=5 "Other"),
			    gen(race_cat)
			;
		#delimit cr
		g months1=rweibull(1,1)
		g months2=rweibull(1,2)
		g months3=rweibull(4,4)
		#delimit ;
		twoway (kdensity months1)
		       (kdensity months2)
			   (kdensity months3,
			       legend(on
				       ring(0)
					   pos(3)
					   col(1)
				   )
				   ylab(,
				       angle(360)
				   )
				   xti("Months")
				   yti("Proportion")
			   )
		;
		#delimit cr
		g months=months1 if inrange(age,65,100)
		replace months=months2 if inrange(age,40,64)
		replace months=months3 if inrange(age,0,39)
		#delimit ;
		g logor= .5 +
		         .3*age + 
		         -.1*female + 
				 0^cond(race_cat==1,1,0) * 
				 1.5^cond(race_cat==2,1,0) *
				 2^cond(race_cat==3,1,0) *
				 -.5^cond(race_cat==4,1,0) *
				 4^cond(race_cat==5,1,0) 
		;
		#delimit cr
		g prob=exp(logor)/(1+exp(logor))
		g covid=prob
		
	}
	
	if 2 { //time-to-event analysis
		
		#delimit ;
		recode age 
		    (min/20=1 "<20 years")
			(21/39=2 "20-39 years")
			(40/64=3 "40-64 years")
			(65/max=4 "65+ years"),
			    gen(age_cat)
		;
		#delimit cr
		
		stset months,fail(covid)
		#delimit ;
		sts graph, 
		    fail 
			by(age_cat)
			ti("Positive COVID-19 test: 05/2020-10/2020")
			yti("%",
			    orientation(horizontal))
			per(100)
			ylab(0(20)100,
			    angle(360)
				format(%3.0f)
			)
			tmax(5)
			xti("Months")
			legend(on
			    ring(0)
				pos(11)
				col(1)
				lab(1 "<20 years")
				lab(2 "20-39 years")
				lab(3 "40-64 years")
				lab(4 "65+ years")
			)
		;
		#delimit cr
		stcox age female i.race_cat 
		
	}
	
end //}
