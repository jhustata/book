# program define

[video](https://jhjhm.zoom.us/rec/share/8x0apHVqmnUHnuBfzLXMuvRRXkExSGeoQAw5rEs9OvKSmzs1bvhPfLD2pGu6NRY.BYToPUwpMdnR-h25?startTime=1681414214000) 04/13/2023 Includes introduction to `program define`

[video](https://jhjhm.zoom.us/rec/share/NBtdk4SUC-ra9q7_tuGZEjuwS6o8cjB8U2dBnc_hSV7jM8joxdhlQ2ebQc8cILE2.GlIilOilIbw2w9tQ?startTime=1682019152000) 04/20/2023 Includes exercise in debugging & discussion of HW1

Let's recap what we've covered thus far:

1. dofiles
2. macros
3. programs

If you replace the `quietly {` line of code in your .do file structure with `program define name` and the `}` with `end` you'd have written your very first program!

Can you apply this **hint** to the script used to assign you by [last name](https://jhustata.github.io/book/aaa.html) to a TA? Write a program called `tokenize` that outputs a `.log file` that offers a user some output to achieve the purpose of the tokenize script.

```Stata

qui {

    if 0 { //dofiles

        1. quietly
        2. if {
        3. code-block

    }

    if 1 { //macros

        //system-defined, constant
        creturn list
        global workdir `c(pwd)' //`c(pwd)' -> `filepath` if file isn't in `pwd`

        //program-defined, estimates & return
        use ${workdir}/transplants, clear //vincent's idea for your hw1
        stset end_date,failure(died) origin(transplant_date)
        stcox age gender i.race prev_ki
        ereturn list

        lincom _b[prev_ki]
        return list
        di exp(r(estimate))

        //user-defined 
        stcox prev_ki
        lincom _b[prev_ki]
        return list 
        di r(p)

        qui tab died prev_ki, chi
        return list
        local pvalue: di %4.3f r(p)

    }

    if 2 { //programs?

    }

}

```

Now you have successfully written your first program. Its now a Stata command; however, its role is highly specific.

How may we generalize its function and tailor it to user-defined needs? **Perhaps by deploying user-defined macros**?


