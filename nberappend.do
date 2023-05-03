qui {
	qui {
		if c(N) {
			1.appended 1959-2017
			2.create one large file
			3.save that analytic file
		}
		if c(N)<1{
			que mem
			capture log close
			log using nberappend.log,replace 
		}
		if c(N)<2{
			timer on 2
			forval i=1959/2017 {
				noi di "appending... mort`i'.dta"
				append using mort`i'.dta,force
				timer off 2
			}
		}
		if c(N)>3{
			noi di "obs:`c(N)', vars:`c(k)'"
			lab data "mortality in the united states, 1959-2017"
			save mort1959_2017.dta,replace 
		}
	  timer list 
	  log close 
	}
}
