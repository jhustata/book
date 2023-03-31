# lab1

[transplants.dta](transplants.dta)

This lab is optional; you are **NOT** required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be provided separately.

1. Start Stata and open your do-file editor or your favorite text editor.

2. You will now write your first do-file. In the text editor or Stata do-file editor, write the header. That is, start logging, describe the purpose of this script as a comment, specify the version for which the script was written, and clear memory. Your homework scripts should start this way. (Your other scripts too!) Code for a .do file header was given in lecture 1.

3. We want to load `transplants.dta`. But before that, let’s check your working directory. See the bottom left side of the console (the main Stata window). You may also type `pwd` on the console. Is it where your `transplants.dta` is located? If not, use one of these two methods:

&nbsp;&nbsp;&nbsp; 1) Next time, launch Stata by double-clicking on `transplants.dta`.
&nbsp;&nbsp;&nbsp; 2) Type `cd c:/your/actual/path` on the console (NOT in your do file). 
    
4. Now let’s get back to your do file. Load `transplants.dta`


5. How many observations does the dataset have?

6. How many adults (age>18) does the dataset have?

7. How many observations have missing bmi?

8.  Generate a new variable called agecat. The value of agecat is 1 for patients younger than 18, 2 for those from 18 to 65, and 3 for those older than 65.


9. What are the means of age and bmi?

10. Now preserve your dataset.

11. Drop all patients who are younger than 18 or older than 65, or have missing value for age.

12. Again, what are the means of age and bmi? restore the dataset. Yet again, what are the means of age and bmi?

13. What happened? Leave a comment on your do-file explaining what you just did. Remember, your homework (and all other) scripts should have 1-2 comment(s) per major task.

14. Lab 1 is almost over. Let Stata say "that was easy!"

15. The last bit. Close your log file. Never forget to close log files!

16. You have all your commands so far in your do file, right? Run your entire do file and make sure your do file does exactly the same thing.




