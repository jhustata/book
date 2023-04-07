qui {
	
	if 3 { //if3jhustatasnippet: multicategory variables, edit accordingly!
			
		timer on 3
	    
		capture label drop race 
        #delimit ;
        lab def race 
           1 "White" 
           2 "Black"
           3 "Hispanic"
           4 "Asian";
        lab values DMARETHN race; 
        #delimit cr
        
        local v: var lab DMARETHN
        putexcel A4="`v', %"
        local vl: value label DMARETHN
        
        levelsof DMARETHN, local(race)  
        return list 
        
        count if !missing(DMARETHN)
        global N=r(N)
        
        local row=5
        
        foreach l of numlist `race' {
    
            local per: lab `vl' `l'
            qui sum DMARETHN if DMARETHN==`l'
            local percent: di %3.1f r(N)*100/$N
            di "`per', % : `percent'"
            putexcel A`row' = "   `per'"
            putexcel B`row' = "`percent'"
            local row=`row' + 1
		
		timer off 3

    }
	
}
