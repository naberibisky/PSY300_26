############################################################
# PSY 300
# In-Class Practice: Exploring Data in R
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




# 2. Look at the first six rows of the dataset.




# 3. Look at the last six rows of the dataset.




# 4. How many observations (rows) are in the dataset?
# Write the R code below.




# 5. How many variables (columns) are in the dataset?
# Write the R code below.




# 6. What are the names of the variables?
# Write the R code below.




############################################################
# PART 2: FIGURE OUT WHAT THE VARIABLES MEAN ####

# We should NEVER assume that we know what variables mean
# just because we recognize their names!

# 7. Open the help file for mtcars.




# Using the documentation, answer these questions:

# What does mpg measure?
# ANSWER:


# What does hp measure?
# ANSWER:


# What does cyl measure?
# ANSWER:



############################################################
# PART 3: SUMMARIZE THE DATA ####

# 8. Use summary() to summarize the entire dataset.




# 9. Find the mean miles per gallon (mpg).
# Hint: use the $ operator to access mpg.




# 10. Find the mean horsepower (hp).




# 11. Use table() to determine how many cars have
# 4, 6, and 8 cylinders.




# QUESTION:
# Which number of cylinders is most common in this dataset?
# ANSWER:



############################################################
# PART 4: VISUALIZE THE DATA ####

# 12. Create a histogram of miles per gallon (mpg).
# Give your graph:
#   - an informative title
#   - an x-axis label
#   - a y-axis label




# QUESTION:
# What do you notice about the distribution of mpg?
# ANSWER:



# 13. Create a bar plot showing the number of cars
# with 4, 6, and 8 cylinders.

# Hint: First save the table as an object!




############################################################
# PART 5: LOOK AT TWO VARIABLES TOGETHER ####

# Before running any code:
#
# Do you predict that cars with more horsepower will
# generally have higher or lower miles per gallon?
#
# PREDICTION:


# 14. Create a scatterplot with:
#     horsepower (hp) on the x-axis
#     miles per gallon (mpg) on the y-axis




# 15. Calculate the correlation between hp and mpg.




# QUESTION:
# Based on the scatterplot and correlation, how would you
# describe the relationship between horsepower and MPG?
#
# ANSWER:


############################################################
# BONUS: ADD A LINE ####

# If you finish early, add a regression line to your
# scatterplot using abline() and lm().