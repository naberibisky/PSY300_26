############################################################
# PSY 300
# In-Class Practice: Exploring Data in R
# SOLUTIONS
############################################################

# Today we worked with the sat.act dataset together.
# Now it is your turn to practice with a different dataset!

# For this activity, we will use the mtcars dataset.
# mtcars is built into R, so you do NOT need to install
# or load a package to access it.


############################################################
# PART 1: LOAD AND EXPLORE THE DATA ####

# 1. Load the mtcars dataset.
# Hint: use data()

data(mtcars)


# 2. Look at the first six rows of the dataset.

head(mtcars)


# 3. Look at the last six rows of the dataset.

tail(mtcars)


# 4. How many observations (rows) are in the dataset?
# Write the R code below.

nrow(mtcars)

# ANSWER: 32 observations


# 5. How many variables (columns) are in the dataset?
# Write the R code below.

ncol(mtcars)

# ANSWER: 11 variables


# 6. What are the names of the variables?
# Write the R code below.

colnames(mtcars)

# ANSWER:
# mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb



############################################################
# PART 2: FIGURE OUT WHAT THE VARIABLES MEAN ####

# We should NEVER assume that we know what variables mean
# just because we recognize their names!

# 7. Open the help file for mtcars.

?mtcars


# Using the documentation, answer these questions:

# What does mpg measure?
# ANSWER: Miles per US gallon


# What does hp measure?
# ANSWER: Gross horsepower


# What does cyl measure?
# ANSWER: Number of cylinders



############################################################
# PART 3: SUMMARIZE THE DATA ####

# 8. Use summary() to summarize the entire dataset.

summary(mtcars)


# 9. Find the mean miles per gallon (mpg).
# Hint: use the $ operator to access mpg.

mean(mtcars$mpg)

# ANSWER: approximately 20.09 MPG


# 10. Find the mean horsepower (hp).

mean(mtcars$hp)

# ANSWER: approximately 146.69 horsepower


# 11. Use table() to determine how many cars have
# 4, 6, and 8 cylinders.

table(mtcars$cyl)

# ANSWER:
# 4 cylinders: 11
# 6 cylinders: 7
# 8 cylinders: 14


# QUESTION:
# Which number of cylinders is most common in this dataset?
# ANSWER: 8 cylinders



############################################################
# PART 4: VISUALIZE THE DATA ####

# 12. Create a histogram of miles per gallon (mpg).
# Give your graph:
#   - an informative title
#   - an x-axis label
#   - a y-axis label

hist(mtcars$mpg,
  main = "Distribution of Miles Per Gallon",
  xlab = "Miles Per Gallon",
  ylab = "Frequency")


# QUESTION:
# What do you notice about the distribution of mpg?
# ANSWER:
# Most cars have MPG values somewhere around 15 to 25 MPG.
# There are also a smaller number of cars with relatively
# high MPG values above 30.
#
# NOTE: Other reasonable descriptions are completely fine!


# 13. Create a bar plot showing the number of cars
# with 4, 6, and 8 cylinders.

# Hint: First save the table as an object!

cylinder_table <- table(mtcars$cyl)

barplot(
  cylinder_table,
  main = "Number of Cars by Number of Cylinders",
  xlab = "Number of Cylinders",
  ylab = "Number of Cars"
)



############################################################
# PART 5: LOOK AT TWO VARIABLES TOGETHER ####

# Before running any code:
#
# Do you predict that cars with more horsepower will
# generally have higher or lower miles per gallon?
#
# PREDICTION:
# A reasonable prediction is that cars with more horsepower
# will tend to have LOWER MPG.


# 14. Create a scatterplot with:
#     horsepower (hp) on the x-axis
#     miles per gallon (mpg) on the y-axis

plot(
  mtcars$hp,
  mtcars$mpg,
  xlab = "Horsepower",
  ylab = "Miles Per Gallon",
  main = "Relationship Between Horsepower and MPG"
)


# 15. Calculate the correlation between hp and mpg.

cor(mtcars$hp, mtcars$mpg)

# ANSWER: approximately -0.776


# QUESTION:
# Based on the scatterplot and correlation, how would you
# describe the relationship between horsepower and MPG?
#
# ANSWER:
# There is a fairly strong negative relationship between
# horsepower and MPG. Cars with greater horsepower tend
# to have lower MPG.



############################################################
# BONUS: ADD A LINE ####

# If you finish early, add a regression line to your
# scatterplot using abline() and lm().

plot(
  mtcars$hp,
  mtcars$mpg,
  xlab = "Horsepower",
  ylab = "Miles Per Gallon",
  main = "Relationship Between Horsepower and MPG"
)

abline(lm(mtcars$mpg ~ mtcars$hp))