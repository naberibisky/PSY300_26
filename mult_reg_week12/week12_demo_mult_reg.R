############################################################
# PSY 300 - Multiple Linear Regression & Diagnostics
# Dataset: gradgpa.csv
# Outcome: Grad GPA
# Predictors: Undergraduate GPA, GRE Verbal + Quant, Interview

############################################################

# We are going to fit a regression model (just like last week)
# but expand it to include other predictors
#-----------------------------------------------------------
# 0. Setup: load packages and data
#-----------------------------------------------------------

library(psych)
library(car)
library(lm.beta) # you will have to install this one

# Load data
dat <- read.csv("gradgpa.csv")



# Quick peek
head(dat)
View(dat)
str(dat)

############################################################
# 1. Descriptive statistics
############################################################

# Overall descriptives for the dataset

cor(dat) # correlations
round(cor(dat), 2) # rounding them so cleaner

cor.plot(dat) # kind of nice
describe(dat)


hist(dat$GradGPA)
hist(dat$UndergradGPA)
hist(dat$GREVerbal)
hist(dat$GREQuant)
hist(dat$Interview)

# remember we aren't looking for these to be normal
# we are just exploring the data

############################################################
# 2. Regression Model
############################################################

# note the dependent variable on the left side of ~ and independent/predictor
# variable on the right
mod <- lm(formula = GradGPA ~ UndergradGPA + GREVerbal + GREQuant + Interview , data = dat)
summary(mod) # can see R^2, F statistic, unstandardized coefficients

# confidence intervals for the coefficients
confint(mod)

# standardized coefficients
lm.beta(mod)

############################################################
# 3. Diagnostics
############################################################
# Normality
multi.hist(rstudent(mod), main="Histogram of residuals", dlty=c("dotted",
                                                                 "blank"))
# There is some negative skew, but nothing to suggest that normality
# violation is severe

# Linearity and heteroscedasticity
# We can look at this by each predictor or with the predicted values...
# let's do both!

# By predictor:
# Undergraduate GPA
scatterplot(rstudent(mod)~dat$UndergradGPA, boxplots=FALSE, xlab='Undergraduate GPA',
            smooth = FALSE, # I took this away because we only have a few data points... worried about overfit
            ylab='Studentized residuals')

# Verbal GRE
scatterplot(rstudent(mod)~dat$GREVerbal, boxplots=FALSE, xlab='Verbal GRE Score',
            smooth = FALSE, # I took this away because we only have a few data points... worried about overfit
            ylab='Studentized residuals')

# Quant GRE
scatterplot(rstudent(mod)~dat$GREQuant, boxplots=FALSE, xlab='Quantitative GRE Score',
            smooth = FALSE, # I took this away because we only have a few data points... worried about overfit
            ylab='Studentized residuals')

# Interview
scatterplot(rstudent(mod)~dat$Interview, boxplots=FALSE, xlab='Quantitative GRE Score',
            smooth = FALSE, # I took this away because we only have a few data points... worried about overfit
            ylab='Studentized residuals')

# By predicted values:
scatterplot(rstudent(mod)~fitted(mod), ylab='Studentized residuals',
            xlab='Predicted values', boxplots=FALSE, smooth = FALSE)

# There's nothing here that screams violation to me. We may have some range narrowing
# in the middle but with so few observations, I don't think we have enough evidence to
# say this. 

# Variance Inflation Factor
vif(mod) # we are climbing up here... these values should be close to 1.
# by all guidelines this is okay, but this is kind of high.

# I would probably think about respecifying the model (alongside theory)
# Maybe verbal GRE scores aren't as big of a factor in graduate school performance?


# ----------------------------------------------------------
# 4. Outliers
# ----------------------------------------------------------
# Leverage (plot hat values)
plot(hatvalues(mod), ylab='Hat values', ylim=c(0, 1))
 
# Discrepancy (plot studentized residuals)
plot(rstudent(mod), ylab='Studentized residuals') # nothing unusually large.. but maybe some are close

# Influence (plot cook's distance)
plot(cooks.distance(mod), ylab='Cooks distance') # around 1 or greater influential

# If you want to see these values
dat$hatvals <- hatvalues(mod)
dat$rstudent <- rstudent(mod)
dat$cooks_dist <- cooks.distance(mod)

View(dat) # now you can see that the most discrepant case does not have high influence
          # for example


# ----------------------------------------------------------
# Sample Write up
# ----------------------------------------------------------

# A multiple linear regression was conducted to examine whether 
# undergraduate GPA, GRE verbal scores, GRE quantitative scores,
# and interview ratings predicted graduate GPA. 
# The set of predictors explained a non-zero proportion of variance in 
# graduate GPA. The model accounted for a substantial proportion of 
# variability in graduate GPA, R^2 = .88, F(4, 15) = 28.79, p < .001.

# Undergraduate GPA was a significant positive predictor of graduate
# GPA, b = 0.54, t(15) = 2.41, p = .029, 95% CI [0.06, 1.02], 
# such that a one-point increase in undergraduate GPA was associated
# with a 0.54-point increase in graduate GPA, holding all other predictors 
#constant. GRE verbal scores were also a significant positive predictor, 
# b = 0.003, t(15) = 3.33, p = .005, 95% CI [0.001, 0.005].
# Although the unstandardized coefficient is small due to the scale of GRE
# scores, this result suggests that higher verbal GRE performance is 
# associated with higher graduate GPA when other variables are controlled. 
# (Note: Ideally you would rescale this)

# Interview ratings significantly predicted graduate GPA as well, b = 0.02,
# t(15) = 2.62, p = .019, 95% CI [0.00, 0.03], indicating that stronger 
# interview performance was associated with higher graduate GPA. 
# GRE quantitative scores were not a significant predictor, b = 0.00,
# t(15) = −0.78, p = .450, 95% CI [0.00, 0.00].

# Regression assumptions were evaluated using visual diagnostics and 
# descriptive statistics. Scatterplots with overlaid ordinary least 
# squares regression lines suggested that the assumption of linearity
# was reasonably met for all predictors. Examination of studentized 
# residuals indicated that residuals were approximately normally distributed,
# with a standard deviation of 0.23, minimal skew (−0.32), and low kurtosis (−0.26).
# Visual inspection of the residual histogram did not suggest substantial
# departures from normality.

# Plots of studentized residuals against each predictor and against 
# fitted values showed no severe departures from homoscedasticity.
# Although some mild variation in residual spread was visible,
# particularly in the mid-range of predicted values, this 
# pattern was anticipated given the small sample size (N = 20). 
# Variance inflation factors ranged from 2.09 to 2.93. A survey of 
# each case's leverage, discrepancy and influence did not reveal any
# outliers.

# Overall, the diagnostic analyses did not reveal substantial violations
# of regression assumptions that would undermine the interpretation of 
# the regression results.





