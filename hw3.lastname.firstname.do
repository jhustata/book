qui {
	
	if 0 {
		
		1. This is one potential solution to Assignment 3
		2. There are many ways of achieving anticipated goals in questions
		3. We do not limit students on how they solve the problem
		4. However, please leave a note for students if they used outside packages
		
	}
	
	if 1 { // general settings
		
		cls
		macro drop _all
		clear all
		set more off
		set varabbrev on
		capture log close
		log using "Assignment3.lastname.firstname.log ", replace
		
	}
	
	if 2 { // Question 1
		
		capture program drop Question1
		program define Question1
			quietly {
				use transplants, clear
				drop if missing(transplant_date)
				
				// get the year of each transplant
				capture drop transplant_yr
				gen transplant_yr = yofd(transplant_date)
				
				// get axis range
				sum transplant_yr
				local x_min = r(min)
				local x_max = r(max)
				
				// actual plot using histogram, but at the end treat it as a line plot
				tw ///
					hist transplant_yr, freq /// first use the histogram function, using frequency instead of proportion
					xlabel(`x_min' (2) `x_max') ylabel(0 (100) 600) /// make reasonable x axis range and labels
					recast(line) lwidth(thick) lcolor(navy) /// covert the boxes to a line graph and then adjust line
					title("Trends in kidney transplantation") ytitle("Number of cases") xtitle("Calendar year") // change the titles
				graph export q1_FirstnameLastname.png, as(png) replace
				}
		end
		Question1
		
	}
	
	if 3 { // Question 2
		
		capture program drop Question2
		program define Question2
			quietly {
				// use transplants, clear
				drop if missing(peak_pra)
				sum age, detail
				local a_min = floor(r(min) / 10) * 10
				local a_max = floor(r(max) / 10) * 10
				twoway ///
					(scatter peak_pra age if prev_ki == 0, mcolor(blue) msize(small) xlabel(`a_min'(10)`a_max')) /// scatter plot 1 if no prev_ki, with blue matter color and smalle size
					(scatter peak_pra age if prev_ki == 1, mcolor(red) msize(small)), /// scatter plot 2 if prev_ki, with red matter color and smalle size
					legend(order(2 "Re-transplant" 1 "First-time transplant")) /// reorder and give text to legend
					xtitle("Recipient age") ytitle("Peak PRA") // changes title
				graph export q2_FirstnameLastname.png, as(png) replace
				}
		end
		Question2
		
	}
	
	if 4 { // Question 3
		
		capture program drop Question3
		program define Question3
			quietly {
				use transplants, clear
				drop if missing(peak_pra)
				// preserve to allow restore original set after plot
				preserve
				
				// get national average 
				sum peak_pra
				local average = r(mean) 
				local national_line_label = `average' + 1 // set up national average line label position
				
				/* using collapse to complete
				// collapse (mean) peak_pra, by(ctr_id)
				// sort peak_pra */
				
				// calcaulte the mean of peak_pra in each ctr
				capture drop pra_mean
				bys ctr_id: egen pra_mean = mean(peak_pra)
				capture drop pra_tag
				egen ctr_id_tag = tag(ctr_id)
				sum pra_mean if ctr_id_tag == 1

				// prepare a variable to be used in flexing the y axis range
				local pra_max = round(r(max))
				
				// drop to get rid off duplicated points
				drop if ctr_id_tag != 1
				
				// prepare for xaxis
				sort pra_mean	
				capture drop ctr_n
				gen ctr_n = _n
				
				// set up yaxis larger end
				local yaxis_max = 5 * (floor(`pra_max' / 5) + 1 )
				// actual plot
				tw scatter pra_mean ctr_n, ///
						ylabel(0 (5) `yaxis_max') /// yaxis modification
						 xscale(off) /// xaxis modification
						 title("Average peak PRA of the receipients at each center") ytitle("Peak PRA") /// title name
						 yline(`average') text(`national_line_label' 7 "National Average")
				graph export q3_FirstnameLastname.png, as(png) replace
				restore
			}
		end
		Question3
		
	}
	
	if 6 { // Bonus Question
		
		noi di "Question 4: I estiamte that it took me 4 hours to complete this assignment"
		
	}
	
	if 5 { // Bonus Question
		
		capture program drop sampmean
		program define sampmean
			syntax, at(numlist) [mean(real 0)] [sd(real 1)] [uniform] 
			quietly {
				// clear the memory to allow program to work
				clear
				
				// get the numlist for future tokenize
				local i_numlist "`at'"
				// count for categories to gen values and prepare for loop
				local num_count = 0
				foreach i of numlist `at' {
					local num_count = `num_count' + 1
				}
				// set up observantions and variables
				set obs `num_count'
				capture drop x_count
				capture drop x_value
				capture drop y_value
				gen x_count = _n
				gen x_value = .
				gen y_value = .
				
				// generate randomized numbers
				if "`uniform'" == "uniform" {
						// in the situation of uniform
					if `sd' == 1 {
						local sd = sqrt(1/12)
					}
					if `mean' == 0 {
						local `mean' = 0.5
					}
					// replace mean and sd to default if not specified
					// calculate uniform range based on mean and sd of uniform distribution
					local spread = sqrt(`sd' ^ 2 * 12) / 2
					local u_limit = `spread' + `mean'
					local l_limit = 0 - `spread' + `mean'
					// generate random numbers
					forvalues i = 1 / `num_count' {
						// tokenize numlist to find out how many rows of data in need
						tokenize `i_numlist'
						local i_temp = ``i''
						// change the x_value to store the information
						replace x_value = `i_temp' if x_count == `i'
						// expand to the rows in need
						expand `i_temp' if x_count == `i'
						// generate random number in uniform distribution
						replace y_value = runiform(`l_limit', `u_limit') if x_count == `i'	
					}
				}
				else {
						// in non-uniform situation
					forvalues i = 1 / `num_count' {
						// tokenize numlist to find out how many rows of data in need
						tokenize `i_numlist'
						local i_temp = ``i''
						// change the x_value to store the information
						replace x_value = `i_temp' if x_count == `i'
						// expand to the rows in need
						expand `i_temp' if x_count == `i'
						// generate random number in uniform distribution
						replace y_value = rnormal(`mean', `sd') if x_count == `i'	
					}
				}
				
				// get a tag for future use in line graph
				capture drop tag
				egen tag = tag(x_count)
				// calculate the mean of each group
				capture drop y_mean
				bys x_count: egen y_mean = mean(y_value)
				
				// get an idea of where should mean=xxx be placed
				sum y_value
				local y_max = r(max)
				// help centralize the plot to make the plot looks nicer
				local xmax = `num_count' + 1
				
				// prepare for the twoway command
				local sc_com ""
				local label_str ""

				// creates appropriate tw command by nesting macros
				forvalue i = 1 / `num_count' {
					// get mean for each group to be used in text()
					sum y_mean if x_count == `i'
					local y_mean = floor(r(mean) * 100) / 100
					// get x_value of each group for labeling
					sum x_value if x_count == `i'
					local x_num = int(r(mean))
					// a string macro to help nesting and ensuring correct command formatting
					local text "Mean=`y_mean'"
					// using nested macro, every time a new num in the numlist, 
					// plot a separate graph between y_value and that num. 
					// then add the graph to the original one
					local sc_com "`sc_com' (scatter y_value x_count if x_count == `i', jitter(5) msize(.25) text(`y_max' `i' "`text'") mcolor(navy))"
					// a string macro to help nesting and ensuring correct command formatting
					local temp_str `" "`x_num'" "'
					// creates appropriate labels for use in actual plotting command
					local label_str "`label_str' `i' `temp_str'"
				}
				// plotting out the graph
				tw `sc_com' ///
						(line y_mean x_count if tag == 1, lwidth(thick) lcolor(maroon)), /// Plot the line graph of means
						legend(off) xlabel(0 " " `label_str' `xmax' " ") xtitle("") 
			}
		end
		
	}
	
	log close
	
}
