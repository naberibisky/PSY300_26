############################################################
# PSYC 3031 - Simple Linear Regression - Week 9
# Dataset: gradgpa.csv
# Outcome: Grad GPA
# Predictor: Undergraduate GPA

############################################################

#-----------------------------------------------------------
# 0. Setup: load packages and data
#-----------------------------------------------------------

library(psych)
library(car)
library(QuantPsyc) # standardized coefficient

# Load data
dat <- read.csv("gradgpa.csv")



# Quick peek
head(dat)
View(dat)
str(dat)

############################################################
# 1. Descriptive statistics
############################################################

# Overall descriptives for quality
describe(dat)
plot(dat$UndergradGPA, dat$GradGPA, main = "Association between Graduate and Undergraduate GPA",
     ylab = "Graduate GPA", xlab = "Undergraduate GPA")

cor(dat$UndergradGPA, dat$GradGPA)


############################################################
# 2. Regression Model
############################################################

# note the dependent variable on the left side of ~ and independent/predictor
# variable on the right
mod <- lm(formula = GradGPA ~ UndergradGPA , data = dat)
summary(mod)

# generate confidence intervals
confint(mod)

# generate standardized coefficient
lm.beta(mod) # compare this to the correlation

# ----------------------------------------------------------
# Sample Results section (Correlation)
# ----------------------------------------------------------

# MODEL FIRST:
# A simple linear regression was conducted to examine whether
# undergraduate GPA predicted graduate GPA. 
# The overall model was statistically significant, F(1, 18) = 48.72, p < .001,
# and explained a substantial proportion of variance in graduate GPA, R² = .73.


# THEN INDIVIDUAL PREDICTORS:
# Undergraduate GPA was a statistically significant predictor of graduate GPA,
# t(18) = 6.98, p < .001. The unstandardized regression coefficient 
# indicated that for each one-point increase in undergraduate GPA, 
# graduate GPA increased by an estimated 1.28 points, b = 1.28, 95% CI [0.89, 1.66].


# The intercept was not statistically significant, t(18) = −1.66, p = .12, 
# indicating that the predicted graduate GPA when undergraduate GPA equals zero
# is not meaningfully different from zero in this model.

# you don't technically need to separately comment on the intercept - I just wanted
# to show you how it was reported.
# You could also put all of this info into a table.

# NOTE WE ARE MISSING A DISCUSSION OF ASSUMPTIONS

