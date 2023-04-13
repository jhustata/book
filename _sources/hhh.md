# program define

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

        //program-defined, estimates & return
        qui regress y x1 x2 x3
        ereturn list

        qui lincom _b[x1]
        return list

        //user-defined 
        qui tab abo sex, chi
        return list
        local pvalue: di %4.3f r(p)

    }

    if 2 { //programs?

    }

}

```

Now you have successfully written your first program. Its now a Stata command; however, its role is highly specific.

How may we generalize its function and tailor it to user-defined needs? **Perhaps by deploying user-defined macros**?


