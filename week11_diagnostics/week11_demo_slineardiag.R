############################################################
# PSY 300 - Simple Linear Regression Diagnostics
# Dataset: gradgpa.csv
# Outcome: Grad GPA
# Predictor: Undergraduate GPA

############################################################

# We are going to fit the same model as last week and
# do some diagnostics
#-----------------------------------------------------------
# 0. Setup: load packages and data
#-----------------------------------------------------------

library(psych)
library(car)

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

# Undergraduate GPA
describe(dat$UndergradGPA)
multi.hist(dat$UndergradGPA, main="Univariate distribution of Undergraduate GPA")
boxplot(dat$UndergradGPA)

# Graduate GPA
describe(dat$GradGPA)
multi.hist(dat$GradGPA, main="Univariate distribution of Graduate GPA")
boxplot(dat$GradGPA)

# Their association
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


############################################################
# 3. Diagnostics
############################################################
# Linearity

# Basic scatterplot
plot(dat$UndergradGPA, dat$GradGPA,
     xlab = "Undergraduate GPA",
     ylab = "Graduate GPA",
     main = "Graduate GPA vs Undergraduate GPA",
     pch = 19,
     col = "grey50")

# Add regression line 
abline(mod, col = "blue", lwd = 2) # note the use of mod here
# note you have to run the plot above or else this
# line and the LOWESS line will not work

# Add LOWESS smoother
lines(lowess(dat$UndergradGPA, dat$GradGPA),
      col = "red", lwd = 2, lty = 2)

# Optional legend
legend("topleft",
       legend = c("OLS regression line", "LOWESS curve"),
       col = c("blue", "red"),
       lty = c(1, 2),
       lwd = 2,
       bty = "n")

# Can also do
scatterplot(dat$GradGPA ~ dat$UndergradGPA, 
            boxplots=F, smooth=T)

# Normality of Errors
# First pull out residuals from your model like so
residuals <- resid(mod)

# then plot
multi.hist(residuals, main = '
Histogram of Residuals
from Graduate GPA onto Undergraduate GPA')

# can get descriptives
describe(residuals)

# Homoscedasticity
scatterplot(resid(mod) ~dat$UndergradGPA, boxplots=F, ylab
            ='Residuals', xlab="Undergraduate GPA") # but small sample

plot(dat$UndergradGPA, residuals,
     pch = 1,
     xlab = "X",
     ylab = "Residuals")
abline(h = 0, lty = 2)

# ----------------------------------------------------------
# Regression diagnostics
# ----------------------------------------------------------

# Regression assumptions were evaluated using visual diagnostics
# and descriptive statistics.
# Scatterplots with an overlaid OLS regression line and a LOWESS curve
# suggested that the linearity assumption was reasonably met.

# Examination of the residuals indicated that they were approximately
# normally distributed. The residuals had a standard deviation of 0.23,
# minimal skew (−0.32), and low kurtosis (−0.26), A histogram of
# the residuals did not suggest any deviations from non-normality.
#
# Plots of residuals against undergraduate GPA showed no severe
# departures from homoscedasticity. Although the LOWESS smoother
# suggested some mild variation in residual spread across values of
# undergraduate GPA, this pattern was anticipated given the small
# sample size (N = 20).

# Overall, the diagnostic plots did not reveal substantial violations
# of regression assumptions that would undermine the interpretation
# of the regression results.
