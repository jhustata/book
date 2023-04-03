# lab1 

video: [tutorial](https://jhjhm.zoom.us/rec/share/XjpGCpJkfYBIATTHMS93sFQmjJRdrFatmiWe-9JmYjNOSWHINrmbkqQK1amABUUQ.2bvUmmqBZ0dMd3LD?startTime=1680430835000)
[lab1.do](lab1.do)
[lab1.log](lab1.log)

data: [transplants.dta](transplants.dta) 

zoom links: [M](https://JHUBlueJays.zoom.us/j/96760923747) [T](https://JHUBlueJays.zoom.us/j/99476415268) [W](https://jhubluejays.zoom.us/j/98628544091?pwd=ZGx5NTN1RHNzNDUrQ3c3Uys0RVYrUT09) [Th](https://JHUBlueJays.zoom.us/j/3393703103) F

Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. An answer key will be provided on Friday April 7, 2023.

1. Start Stata and open your do-file editor.

2. You will now write your first do-file following the guidelines on `structure`, `indentation`, and `annotation` given in [chapter: pwd](eee.md).

3. We want to load `transplants.dta`. But before that, let’s check your working directory. See the bottom left side of the console (the main Stata window). You may also type `pwd` on the console. Is it where your `transplants.dta` is located? If not, use one of these two methods:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a) Next time, launch Stata by double-clicking on `transplants.dta`.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b) Type `cd c:\your\actual\path` (windows OS) on the console (NOT in your do file). In class and on my Mac OS my directory was `/Users/d/desktop`
    
4. Now let’s get back to your do file. Load `transplants.dta` (double-click on the file or type `use transplants.dta, clear`

5. How many observations does the dataset have?

6. How many adults (age>18) does the dataset have?

7. How many observations have missing bmi?

8.  Generate a new variable called agecat. The value of agecat is 1 for patients younger than 18, 2 for those from 18 to 65, and 3 for those older than 65.

9. What are the means of age and bmi?

10. Now preserve your dataset (type `help preserve` to learn more).

11. Drop all patients who are younger than 18 or older than 65, or have missing value for age.

12. Again, what are the means of age and bmi? restore the dataset. Yet again, what are the means of age and bmi?

13. What happened? Leave a comment on your do-file explaining what you just did. Remember, your homework (and all other) .do file scripts should have 1-3 comments per block of code. Do not use your comments/annotation to define the Stata commands you've used. Thats what the `help` command is for. Instead, give yourself or a reader some context.

14. Lab 1 is almost over. Let Stata say "that was easy!"

15. The last bit. Close your log file. Never forget to close log files! If you hadn't created a log file, this is a reminder to do so. Preferably in the block of code that you may have designated using `if 1 {`

16. You have all your commands so far in your do file, right? Run your entire do file and make sure your do file does exactly the same thing.




