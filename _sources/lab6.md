# lab6

lab4: [solutions](lab4.md)

data: [transplants.dta](transplants.dta) [donors_recipients.dta](donors_recipients.dta) [donors.dta](donors.dta)

zoom: [M](https://JHUBlueJays.zoom.us/j/96760923747) [T](https://JHUBlueJays.zoom.us/j/99476415268) [W](https://jhubluejays.zoom.us/j/98628544091?pwd=ZGx5NTN1RHNzNDUrQ3c3Uys0RVYrUT09) [Th](https://JHUBlueJays.zoom.us/j/3393703103) [F](https://JHUBlueJays.zoom.us/j/8581993134)

This lab is optional; you are NOT required to complete these questions. Please use this lab as an opportunity to review the course material and prepare yourself for the homework questions. Sample responses to the lab questions will be provided separately.

1. Start Stata, open your do-file editor, write the header, and load `transplants.dta`.

2. Get a 10% random sample of the dataset. Specifically, follow these steps. (1) Set a seed number. (2) Generate a variable that includes a random number between 0 and 1 following a uniform distribution. (3) Sort by the random variable. (4) Keep the first 10% observations and drop the rest. (5) Drop the random variable.

3. Clear and re- load `transplants.dta`.

4. Generate a variable called `fake_age` which is a normally distributed random variable with mean and standard deviation equal to the mean and standard deviation of the actual age variable.

5. Make a scatter plot of peak PRA by age in transplant recipients. Does it look like there's a relationship between peak PRA and age, and if so, what is the relationship?

6. The graph of proportion of ECD transplants by age from the lecture was a little messy. Remake the graph with the age rounded to the nearest ten years.

   + (From the lecture)

     ![Picture1](Picture1.png)

   + (After rounding)

     ![Picture2](Picture2.png)

7. You have all your commands in your do file, right? Run your do file from the beginning and make sure your do file does exactly the same thing.

