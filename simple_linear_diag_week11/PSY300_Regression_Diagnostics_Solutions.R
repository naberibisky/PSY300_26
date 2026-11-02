############################################################
# PSY 300: Simple Linear Regression Diagnostics SOLUTIONS
# Dataset: sat.act (psych package)
# Outcome: SAT Verbal (SATV); Predictor: ACT score (ACT)
############################################################

library(psych)
library(car)
data("sat.act", package = "psych")
dat <- na.omit(sat.act[, c("ACT", "SATV")])
head(dat)

str(dat)
nrow(dat)

############################################################
# 1. Descriptive statistics
############################################################

describe(dat$ACT)
multi.hist(dat$ACT, main = "Distribution of ACT scores")
boxplot(dat$ACT, main = "ACT scores", ylab = "ACT")

describe(dat$SATV)
multi.hist(dat$SATV, main = "Distribution of SAT Verbal scores")
boxplot(dat$SATV, main = "SAT Verbal scores", ylab = "SATV")

plot(dat$ACT, dat$SATV,
     xlab = "ACT score", ylab = "SAT Verbal score",
     main = "SAT Verbal vs. ACT")

############################################################
# 2. Regression model
############################################################

mod <- lm(SATV ~ ACT, data = dat)
summary(mod)

# Answers:

# 1. What is the regression equation?
# Predicted SATV = 237.34 + 13.13(ACT)
# The intercept is 237.34, and the slope is 13.13.


# 2. Interpret the slope in the context of this study.
# For every 1-point increase in ACT score, predicted SAT
# Verbal score increases by approximately 13.13 points,
# on average.


# 3. What proportion of variance in SATV is explained
#    by ACT scores?
# R-squared = 0.3148
# Approximately 31.48% of the variance in SAT Verbal
# scores is explained by ACT scores.


# 4. Is ACT score a statistically significant predictor
#    of SAT Verbal scores?
# Yes. ACT score is a statistically significant positive
# predictor of SAT Verbal scores,
# b = 13.13, t(698) = 17.91, p < .001.
# This indicates that higher ACT scores are associated
# with significantly higher SAT Verbal scores.


############################################################
# 3. Diagnostics
############################################################

# Linearity: compare the straight OLS line with LOWESS.
plot(dat$ACT, dat$SATV,
     xlab = "ACT score", ylab = "SAT Verbal score",
     main = "Linearity diagnostic", pch = 19, col = "grey50")
abline(mod, col = "blue", lwd = 2)
lines(lowess(dat$ACT, dat$SATV), col = "red", lwd = 2, lty = 2)
legend("topleft", legend = c("OLS line", "LOWESS curve"),
       col = c("blue", "red"), lty = c(1, 2), lwd = 2, bty = "n")

# LINEARITY
# The assumption of linearity appears reasonably satisfied.
# The scatterplot suggests a positive, approximately linear
# relationship between ACT scores and SAT Verbal scores.
# Although the LOWESS curve shows some flattening at higher
# ACT scores, there is no substantial departure from linearity.
# Overall, a linear model appears reasonable for these data.

# Normality of errors
residuals <- resid(mod)
multi.hist(residuals, main = "Distribution of regression residuals")
describe(residuals)

# NORMALITY OF ERRORS
# The residuals appear approximately bell-shaped but
# exhibit noticeable negative skew.
# Most residuals are concentrated around zero, but the
# distribution has a longer left tail, including several
# unusually large negative residuals.
# Therefore, the assumption of normality of errors
# appears somewhat questionable.

# Homoscedasticity
plot(dat$ACT, residuals, pch = 1,
     xlab = "ACT score", ylab = "Residuals",
     main = "Residuals vs. ACT")
abline(h = 0, lty = 2)

# HOMOSCEDASTICITY
# The assumption of homoscedasticity appears reasonably
# satisfied.
# The residual plot does not show a clear funnel shape
# or systematic change in variability across ACT scores.
# Although there are some unusually large residuals,
# these do not necessarily indicate heteroscedasticity.
# Overall, the spread of residuals appears reasonably
# consistent across values of ACT scores.

############################################################
# 4. Sample interpretation framework
############################################################

# Regression assumptions were evaluated using visual
# diagnostics and descriptive statistics.

# The scatterplot suggested an approximately linear
# relationship between ACT scores and SAT Verbal scores.
# Although the LOWESS curve showed some flattening at
# higher ACT scores, there were no substantial departures
# from linearity.

# Examination of the residuals indicated that the
# distribution was approximately bell-shaped but exhibited
# some negative skew and several unusually large negative
# residuals. Therefore, the assumption of normality of
# errors was somewhat questionable.

# The residuals-versus-ACT plot showed no clear funnel
# shape or systematic change in variability, suggesting
# that the assumption of homoscedasticity was reasonably
# satisfied.

# Overall, the diagnostics suggested that linearity and
# homoscedasticity were reasonably satisfied, although
# some departures from normality were observed.

# Note: Independence of observations is also an assumption,
# but it cannot be established from these diagnostic plots.