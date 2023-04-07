# lab2

lab1: [solutions](lab1.md)

data: [transplants.dta](transplants.dta) 

zoom: [M](https://JHUBlueJays.zoom.us/j/96760923747) [T](https://JHUBlueJays.zoom.us/j/99476415268) [W](https://jhubluejays.zoom.us/j/98628544091?pwd=ZGx5NTN1RHNzNDUrQ3c3Uys0RVYrUT09) [Th](https://JHUBlueJays.zoom.us/j/3393703103) [F](https://JHUBlueJays.zoom.us/j/8581993134)

This lab is optional; you are NOT required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be provided on Friday 14, 2023.

1. Start Stata, open your do-file editor, write the header, and load `transplants.dta`.

2. Calculate the mean value of age using `sum`.

3. Stata should have some values in the memory as `r()` values. Ask Stata to display the list of the `r()` values.

4. Display the mean value. Store the mean value as a local macro ``mean’`. Display the local macro `mean’.

5. Now let’s try something more useful. Calculate the mean value of age. Print the following sentence: `The mean age is XX.X years`. Replace `XX` with correct values. Round to tenths (e.g. 35.2 years). 

6. Calculate the median (IQR) of age. Print the following sentence: `The median [IQR] age is XX [XX-XX] years`. Replace `XX` with correct values. Round to whole numbers (e.g. 37 years). 

7. Calculate the standard deviation of age among patients with blood type O (`abo==4`). Print the following sentence: `The SD of age among patients with blood type O is XX.X`. Replace `XX` with correct values. Round to tenths (e.g. 8.2). 

8. Regress BMI on age and sex (using `regress bmi age gender`) without displaying the regression output. Print the following sentence: `Per 1-year increase in age, BMI increases by X.XX`. Replace `XX` with the regression coefficient of age. Round to hundredths (e.g. 0.74). 

9. Now we will do the same thing, but using a program. Define a program named `bmi_age`. This program will regress BMI on age and sex without displaying the regression output, and print: `Per 1-year increase in age, BMI increases by X.XX`. Replace `XX` with the regression coefficient of `age`. Round to hundredths (e.g. 0.74). 

10. You have all your commands in your do file, right? Run your do file from the beginning and make sure your do file does exactly the same thing.
