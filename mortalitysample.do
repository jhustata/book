qui {
	if c(N) { //backgorund
	    c(N)=260m -> c(N)=260k
		sampling as has always 
		been done for centuries
		to lower costs of studying
		entire populations, nations
	}
	if c(N)<1 { //methods
		timer on 1
		global workdir c(pwd)
		capture log close
		log using mort1959_2017s.log, replace
	    set max_memory .
		timer off 1
	}
	if c(N)<2 { //results
		timer on 2
		use mort1959_2017.dta, clear
        sample .001
        save mort1959_2017s, replace 
		timer off 2
	}
	if c(N)<300000 { //
		timer on 3
		noi di "obs: `c(N)', vars:`c(k)'"
		timer off 3
	}
	else {
		noi di "dataset too large :("
	}
  timer list 
  log close 
}
