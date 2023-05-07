# local v: di  

Lets recap the last 7 weeks:

* `help`
      * the help command followed by any command you wish to further explore 
      * e.g., `h twoway`

* `tokenize`
      * represent a numerical sequence (e.g. 1,2,3,...,6) 
      * as a sequence of letters (e.g. a,b,c,...,z or A,B,C,...,Z)

* `quietly`
      * how to control what is displayed in the Stata terminal
      * Stata uses this e.g. with the neat regression output, and with profile.do
      * may very easily be changed to `noisily` if that suits your needs

* `delimit`
      * neat way to mimic `SAS` in defining the end of **one "line" of code**
      * especially useful when dealing with graphical output and numerous graphing options
      * absolutely necessary if ever you wish to translate `.SAS` code into `.do`
      * may make accessible what otherwise were inaccessible datasets (e.g. [NHANES](https://pubmed.ncbi.nlm.nih.gov/?term=nhanes))

* `rnormal()`
      * simulating parametric distributions
      * you may develop this idea on your own in the future
      * `runiform()` & `rnormal()` are the only examples demonstrated in this class

* `pwd`
      * pwd
      * di c(pwd)
      * di "text with embedded `c(pwd)' for whatever reason"
      * global filepath c(pwd)

* `r(mean)`
      * creturn list
      * return list
      * ereturn list

* `by`
      * collapse (`statistic`) varname1 by(varname2)
      * egen varname1=`statistic`(varname2)
      * above commands are **equivalent** in many regards
      * on distorts the data; the other doesn't do so at all
      * useful created twoway plots or other graphical output

* `program define`
      * rigid, specific programs (without `syntax varlist` or `syntax, options`)
      * flexible, generalizable programs (with `syntax [varlist]`, `[options]`)

* `capture`
      * preventing error results and an arrested script
      * Stata is finicky, *pernickety* and this little preface to a command may spare you untold misery
      * we've used it most frequently before `program define` & `log using`
      * but, notably, we've used it as a parsimonous variant in `syntax varlist if`

* `twoway`
      * last weeks class, which we didn't cover because of `hw1`-related issues
      * notes have been updated to give you the best bang for your buck 
      * lookout for the following **very** important issues:

          * workflow;
          * open science; and,
          * chatGPTs take on these.

     * on your own, please go walk step-by-step, command-by-command, through the `twoway` examples offered

     * think about `if macro {` conditional code-blocks and your deployment of this artifices in future, very powerful Stata scripts!

**SO, TODAY,** we'll circle back to the method emplyed throughout this class:

      * defining macros
      * formatting them
      * embedding them in strings, text, figures, and excel
      * producing aesthically pleasing, richly informative output

But to what end?

      * the advanced Stata Programming class answers that question
      * open science
      * self-publication
      * collaboration
      * etc... 



* `local` maco
* `v` name
* `: di` display 
* content 
     * strings -> `""`
     * `c()` -> constants
     * `e()` -> estimates 
     * `r()` -> return values 
     * formats -> %3.2f 
     * limit is necessity, or your imagination... 

* [ex1](https://jhustata.github.io/book/ddd.html) local macro example
* [ex2](https://jhustata.github.io/book/eee.html) hw1.q5 solutions available to you since day!!!
* [ex3](https://jhustata.github.io/book/fff.html) global macro example
* [ex4](https://jhustata.github.io/book/ggg.html) spot `em 
* [ex5](https://jhustata.github.io/book/hhh.html) pvalue
* [ex6](https://jhustata.github.io/book/iii.html) in programs
* [ex7](https://jhustata.github.io/book/jjj.html) & in `stcox.ado`