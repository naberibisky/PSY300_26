############################################################
# PSY 300 - Simple Linear Regression Diagnostics Practice
# Dataset: sat.act (psych package)
# Outcome: SAT Verbal (SATV)
# Predictor: ACT score (ACT)
############################################################

# Research question: Do ACT scores predict SAT Verbal scores?
# Use the gradgpa.csv demonstration script as a reference.

############################################################
# 0. Setup
############################################################

# Load the psych and car packages.


# Load the sat.act dataset from psych.


# Keep only ACT and SATV observations with no missing values, run the following.
dat <- na.omit(sat.act[, c("ACT", "SATV")])


# Inspect the dataset using head(), View(), and str().


############################################################
# 1. Descriptive statistics
############################################################

# 1a. Obtain descriptive statistics for ACT scores.


# 1b. Examine ACT scores using multi.hist() and boxplot().


# 1c. Obtain descriptive statistics for SAT Verbal scores.


# 1d. Examine SAT Verbal scores using multi.hist() and boxplot().


# 1e. Create a scatterplot with ACT on the horizontal axis
# and SAT Verbal on the vertical axis.


############################################################
# 2. Simple linear regression
############################################################

# 2a. Fit a regression predicting SAT Verbal from ACT.
# Save the model as mod.


# 2b. Display the model summary.


# Questions:
# 1. Write the regression equation.
#
# 2. Interpret the slope in context.
#
# 3. What proportion of variability in SAT Verbal scores
#    is explained by ACT scores?
#
# 4. Is ACT a statistically significant predictor of SAT Verbal?
#

############################################################
# 3. Regression diagnostics
############################################################

# LINEARITY
# 3a. Plot ACT against SAT Verbal, then add the fitted
# regression line and a LOWESS curve.


# Question: Does the relationship appear approximately linear?
# Explain using the plot.
#

# NORMALITY OF ERRORS
# 3b. Save the model residuals as residuals.


# 3c. Examine the residual distribution using multi.hist().


# 3d. Obtain descriptive statistics for residuals.


# Question: Do the residuals appear approximately normal?
# Support your conclusion with the histogram and descriptives.
#

# HOMOSCEDASTICITY
# 3e. Plot residuals against ACT scores and add a
# horizontal reference line at zero.


# Question: Is the spread of residuals approximately constant
# across ACT scores?
#

############################################################
# 4. Overall interpretation
############################################################

# Write a short paragraph assessing linearity, normality of
# errors, and homoscedasticity. Cite evidence from your plots
# and descriptive statistics; acknowledge any uncertainty.
#
#
#
