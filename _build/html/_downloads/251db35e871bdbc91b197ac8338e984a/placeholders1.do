**homework 1**

set more off
version 15

qui {
	
	if 1  { //load data
		
		capture log close

		global HOME `c(pwd)' 
		
		log using "${HOME}\hw1.lastname.firstname.log", replace
		
		import delimited "${HOME}\hw1.txt", clear
	
	}
	
	if 2  { //question 1
	
		
		count
		return list
		
		noi di "  "
		noi di "Question 1: There are `r(N)' records in the dataset."
				
	}

	
	
	if 3  { //question 2
		
		sum init_age if female == 0 & ~mi(init_age), det
		return list
		
		local m25: di %2.0f r(p25)
		local m50: di %2.0f r(p50)
		local m75: di %2.0f r(p75) 

		sum init_age if female == 1 & ~mi(init_age), det
		return list
		
		local f25: di %2.0f r(p25)
		local f50: di %2.0f r(p50)
		local f75: di %2.0f r(p75) 
		
		noi di "  "
		noi di "Question 2: The median [IQR] age is `m50' [`m25'-`m75'] among males and `f50' [`f25'-`f75'] among females."
		
		}
	
	
			
	if 3  { //question 3
	
		
		tab prev female, mi
		
		count if prev == 0 & female == 0
		return list
		local mnoprev: di %2.1f r(N)
		
		count if prev == 1 & female == 0
		return list
		local mprev: di %2.1f r(N)
		
		local mtot: di %2.1f `mprev'+`mnoprev'
		
		count if prev == 0 & female == 1
		return list
		local fnoprev: di %2.1f r(N)
		
		count if prev == 1 & female == 1
		return list
		local fprev: di %2.1f r(N)
		
		local ftot: di %2.1f `fprev'+`fnoprev'
		
		local male_prev_perc: di %2.1f (100*`mprev'/`mtot')
		
		local female_prev_perc: di %2.1f (100*`fprev'/`ftot')
		
		noi di "  "
		noi di "Question 3: `male_prev_perc'% among males and `female_prev_perc'% among females have history of previous transplant."
				
	}
	
	
	
	if 4 { //question 4
	
		gen htn = 0
		replace htn = 1 if dx == "4=Hypertensive"
		
		label define htn 1 "Yes" 0 "No"
		label values htn htn
		
		noi di "Question 4:"
		noi tab htn
				
	}

	
	
	
	if 5 { // question 5
	
		*define program to output table 1
		capture program drop table1
		program define table1
	
		putexcel set "${HOME}\table1", replace 
		putexcel A1="Question 5"
		putexcel A2= "Age, median (IQR)"
		putexcel A3 = "Previous transplant, %"
		
		count if female == 0
		local male: di %2.0f r(N)
		putexcel B1= "Males (N=`male')"
		
		count if female == 1
		local female: di %2.0f r(N)
		putexcel C1= "Females (N=`female')"
		
		sum init_age if female == 0 & ~mi(init_age), det
		return list
		
		local m25: di %2.0f r(p25)
		local m50: di %2.0f r(p50)
		local m75: di %2.0f r(p75) 

		sum init_age if female == 1 & ~mi(init_age), det
		return list
		
		local f25: di %2.0f r(p25)
		local f50: di %2.0f r(p50)
		local f75: di %2.0f r(p75)
		
		putexcel B2= "`m50' [`m25'-`m75']"
		putexcel C2= "`f50' [`f25'-`f75']"
		
		count if prev == 0 & female == 0
		return list
		local mnoprev: di %2.1f r(N)
		
		count if prev == 1 & female == 0
		return list
		local mprev: di %2.1f r(N)
		
		local mtot: di %2.1f `mprev'+`mnoprev'
		
		count if prev == 0 & female == 1
		return list
		local fnoprev: di %2.1f r(N)
		
		count if prev == 1 & female == 1
		return list
		local fprev: di %2.1f r(N)
		
		local ftot: di %2.1f `fprev'+`fnoprev'
		
		local male_prev_perc: di %2.1f (100*`mprev'/`mtot')
		
		local female_prev_perc: di %2.1f (100*`fprev'/`ftot')
		
		putexcel B3= "`male_prev_perc'%"
		putexcel C3= "`female_prev_perc'%"
		
		putexcel A4= "Cause of ESRD:"
		putexcel A5= "Glomerular, %"
		putexcel A6= "Diabetes, %"
		putexcel A7= "PKD, %"
		putexcel A8= "Hypertensive, %"
		putexcel A9= "Renovascular, %"
		putexcel A10= "Congenital, %"
		putexcel A11= "Tubulo, %"
		putexcel A12= "Neoplasm, %"
		putexcel A13= "Other, %"
		
		gen dx2=.
		replace dx2 = 1 if dx == "1=Glomerular"
		replace dx2 = 2 if dx == "2=Diabetes"
		replace dx2 = 3 if dx == "3=PKD"
		replace dx2 = 4 if dx == "4=Hypertensive"
		replace dx2 = 5 if dx == "5=Renovascular"
		replace dx2 = 6 if dx == "6=Congenital"
		replace dx2 = 7 if dx == "7=Tubulo"
		replace dx2 = 8 if dx == "8=Neoplasm"
		replace dx2 = 9 if dx == "9=Other"
		
		foreach dx in 1 2 3 4 5 6 7 8 9 {
			
			count if female == 0
			local tot: di r(N)
			
			count if dx2 == `dx' & female == 0
			local var_`dx'_m: di r(N)
			
			local totm_`dx': di %3.1f (100*(`var_`dx'_m'/`tot'))
			
			count if female == 1
			local tot: di r(N)
			
			count if dx2 == `dx' & female == 1
			local var_`dx'_f: di r(N)
			
			local totf_`dx': di %3.1f (100*(`var_`dx'_f'/`tot'))
		}
		
		putexcel B5= "`totm_1'%"
		putexcel C5= "`totf_1'%"
		
		putexcel B6= "`totm_2'%"
		putexcel C6= "`totf_2'%"
		
		putexcel B7= "`totm_3'%"
		putexcel C7= "`totf_3'%"
		
		putexcel B8= "`totm_4'%"
		putexcel C8= "`totf_4'%"
		
		putexcel B9= "`totm_5'%"
		putexcel C9= "`totf_5'%"
		
		putexcel B10= "`totm_6'%"
		putexcel C10= "`totf_6'%"
		
		putexcel B11= "`totm_7'%"
		putexcel C11= "`totf_7'%"
		
		putexcel B12= "`totm_8'%"
		putexcel C12= "`totf_8'%"
		
		putexcel B13= "`totm_9'%"
		putexcel C13= "`totf_9'%"
		
		end
	
		*run program to make excel book
		table1
		
		import excel using "${HOME}\table1.xlsx", sheet("Sheet1")  clear
		
		format A B C %-10s
		
		noi di "  "
		noi list, table noobs noheader clean
	
	}

	if 6 { // question 6
	
		
		import delimited "${HOME}\hw1.txt", clear 
		
		logistic received_kt init_age female 
		
		matrix define m=r(table)
		matrix list m
		
		local or_age: di %3.2f (m[1,1])
		di `or_age'
		
		local or_age_low: di %3.2f (m[5,1])
		di `or_age_low'
		
		local or_age_high: di %3.2f (m[6,1])
		di `or_age_high'
		
		
		local or_fem: di %3.2f (m[1,2])
		di `or_fem'
		
		local or_fem_low: di %3.2f (m[5,2])
		di `or_fem_low'
		
		local or_fem_high: di %3.2f (m[6,2])
		di `or_fem_high'
		
		putexcel set "${HOME}\table2", replace 
	
		putexcel A1 = "Question 6"
		putexcel A2 = "Variable"
		putexcel A3 = "Age"
		putexcel A4 = "Female"
		putexcel B2 = "OR"
		putexcel C2 = "(95% CI)"
		
		putexcel B3 = "`or_age'"
		putexcel B4 = "`or_fem'"
		putexcel C3 = "(`or_age_low' - `or_age_high')"
		putexcel C4 = "(`or_fem_low' - `or_fem_high')"
		
		import excel using "${HOME}\table2.xlsx", sheet("Sheet1")  clear
		
		format A B C %-10s
		
		noi di "  "
		noi list, table noobs noheader clean
	}
	
	if 7 { // question 7
	
		import delimited "${HOME}\hw1.txt", clear 
		
		count
		local count: di %3.0f `r(N)'
		di `count'
		
		logistic received_kt init_age female
		ereturn list
		local regression_count: di %3.0f `e(N)'
		di `regression_count'
		
		noi di "  "
		noi di "Question 7: This regression included `regression_count' observations whereas the study dataset has `count' observations in total."
	
	}
	
	if 8 { // question 8
		
		noi di "  "
		noi di "Question 8: I estimate that it took me 20 hours to complete this assignment."
		
	}
}



