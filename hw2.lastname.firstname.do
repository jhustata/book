qui {
	
	if 0 {
		1. This is the solution for assignment 2
		2. There are multiple ways of solving the same question
		3. We do not limit students on ways of achieving the anticipated tasks
		4. However, please left a note if they used outside packages
	}
	
	if 1 { // general setting
		
		cls
		set more off
		capture log close
		log using "hw2.lastname.firstname", replace
		set varabbrev on
		
	}
	
	if 2 { // question 1.i
		
		use "hw2_pra_hist.dta", clear
		// import dataset
		capture program drop Question1_i
		program define Question1_i
			quietly {
				// disp the headline of table
				noisily disp "Question 1.i)"
				noisily disp "Visit" ///
				_col(20) "Count"
				// get number of visits to be used in loop
				sum visit_id
				local visit_min = r(min)
				local visit_max = r(max)
				forvalues visit_n = `visit_min' / `visit_max' {
					// count and store patient numbers
					count if (!(missing(pra)) & visit_id == `visit_n')
					local pra_visit_count = r(N)
					// display the result and establish the table
					noisily disp `visit_n' ///
					_col(20) `pra_visit_count'
				}
			}
		end
		noisily Question1_i
	}
	
	if 3 { // Question 1.ii
		
		capture program drop Question1_ii
		capture drop peak_pra
		program define Question1_ii
			quietly {
				/* since px_id has repeated values in different hosp_id
					establish a loop using hosp_id to avoid counting multiple
					patients' data with same px_id. */
				// get hosp_id information for loop in hosp_id
				sum hosp_id
				local hosp_min = r(min)
				local hosp_max = r(max)
				// gen the varaible for storing information
				gen peak_pra = .
				// loop using hosp_id to make sure only count hosp specific patient
				forvalues hosp = `hosp_min' / `hosp_max' {
					// find out how many patients are in each hosp
					sum px_id if hosp_id == `hosp'
					local px_min = r(min)
					local px_max = r(max)
					// for each of the patient, get the largest pra value
					forvalues px_n = `px_min' / `px_max' {
						sum pra if px_id == `px_n' & hosp_id == `hosp'
						// replace and store the largest pra value for each patient
						replace peak_pra = r(max) if px_id == `px_n' & hosp_id == `hosp'
					}
				}
				// gen a tag to ensure one patient only used once in summarization of peak_pra
				egen peak_pra_tag = tag(hosp_id px_id peak_pra)
				// get median and IQR
				sum peak_pra if peak_pra_tag == 1, detail
				local IQR_l = r(p25)
				local Med = r(p50)
				local IQR_u = r(p75)
				// display results
				noisily disp ///
					"Question 1.ii): The median (IQR) of peak_pra is " ///
					%2.1f `Med' " (" ///
					%2.1f `IQR_l' "-" %2.1f `IQR_u' ")."
				// clean unnecessary variable
				capture drop peak_pra_tag
			}
		end
		noisily Question1_ii
		
	}
	
	
	if 4 { // Question 1.iii
		
		capture program drop Question1_iii
		program define Question1_iii
			quietly {
				// merge region into dataset
				merge m:1 hosp_id using "hw2_hosp.dta", keep(match) nogen
				preserve
				// get and store the max peak_pra in each region and store in region_max
				// using a loop that run through each region
				capture drop region_max
				gen region_max = .
				// get level of different regions and store them in region_type
				levelsof region
				local region_type = r(levels)
				foreach reg_type of local region_type {
					sum peak_pra if region == "`reg_type'"
					replace region_max = r(max) if region == "`reg_type'"
				}
				// generate a tag to ensure every patient only got listed once
				capture drop region_max_tag
				egen region_max_tag = tag(hosp_id px_id peak_pra)
				// format the table
				sort region px_id
				// show the results
				noisily list region px_id peak_pra ///
					if peak_pra == region_max & region_max_tag == 1, ///
					sepby(region) noobs
				capture drop region_max_tag region_max
			}
		end
		noisily Question1_iii
		
	}
	
	if 5 { // Question 2
		
		capture program drop unilogit
		program define unilogit
			// add syntax to allow varlist/outcome input and allow if
			syntax varlist [if], outcome(varname)
			quietly {
				// preserve and keep for if option
				preserve
				capture keep `if'
				// establish a checker
				local significant_var ""
				// display the header of output
				noisily di "Significantly associated with `outcome':"
				// perform uni-variable logistic regression
				foreach xvar of varlist `varlist'{
					logistic `outcome' `xvar'
					// get p value
					lincom `xvar'
					local p = r(p)
					// display variable and p-value when significant
					if `p' < 0.05 {
						local significant_var `significant_var' "`xvar'"
						noisily di "`xvar' (p=" ///
							%4.3f `p' ")"
					}
				}	
				// display a gentle reminder if no significant
				if "`significant_var'" == "" {
					noisily di "There is no variable significantly associated with" ///
					" variable `outcome'"
				}
				restore
				// restore if dropped
			}
		end
		
	}
	
	if 6 { // Question 3
		
		noi di "Question 3: I estimate that it took me 4 hours to complete this assignment."
		
	}
	
	if 7 { // Bonus Question
		capture program drop prime
		program define prime
			// using syntax to allow input n as an option
			syntax , n(real)
			
			quietly {
				// prepare two screener
				// mod_n to check if input number is natural number or not
				local mod_n = mod(`n', 1)
				// prime_scanner to check if inputted number is prime or not
				local prime_scanner = 1
				
				if `n' <= 1 {  
					// check if inputted number is less than 1
					noisily di "Invalid input: enter a natural number greater than 1."
				} 
				else if `mod_n' != 0 { 
					// check if inputted number is not a nutural number
					noisily di "Invalid input: enter a natural number greater than 1."
				} 
				else {
					// check for prime using a loop that
					// check the mod of the inputted numbers and 2,3,5,7
					// and see if the number can be divided by them
					foreach i of num 2, 3, 5, 7 {
						local mod_scanner = mod(`n', `i')
						if `mod_scanner' == 0 {
							// set scanner to 0 if the mod is 0 for any of 2,3,5,7
							local prime_scanner = 0
						}
						// an extra check in case inputted number equals to 2,3,5,7
						// which are prime numbers themselves
						if `n' == `i' {
							local prime_scanner = 1
						}
					}
					if `prime_scanner' == 1 {
						noisily di "`n' is a prime number."
					} 
					else {
						noisily di "`n' is not a prime number."
					}
				}
			}
		end

	}
}
