############################################################
# PSY 300 - IN-CLASS PRACTICE: TWO-WAY FACTORIAL ANOVA
############################################################

# RESEARCH CONTEXT
# The ToothGrowth dataset comes with R. It contains tooth-growth
# measurements from 60 guinea pigs given vitamin C at one of three
# dose levels, delivered as either orange juice (OJ) or ascorbic
# acid (VC). Each guinea pig is measured once.
#
# Research question: Do vitamin C dose and supplement type relate
# to tooth growth? Does the effect of dose depend on supplement type?
#
# Outcome: len (tooth growth)
# Factor 1: supp (OJ or VC)
# Factor 2: dose (0.5, 1, or 2 mg/day)
#
# This is a REGULAR two-way factorial ANOVA, NOT a mixed ANOVA:
# both factors are between-subjects.

# 0. SET UP -------------------------------------------------

library(psych)
library(effectsize)

# Built into R: no CSV file needed!
data("ToothGrowth")
dat <- ToothGrowth

str(dat)
head(dat)

# Dose is recorded as a number, but represents 3 distinct groups.
dat$dose <- as.factor(dat$dose)

# Q1. How many levels does each factor have? How many cells
# (combinations of groups) are there in the factorial design?
levels(dat$supp)
levels(dat$dose)
table(dat$supp, dat$dose)


# 1. DESCRIPTIVE STATISTICS ---------------------------------

# Q2. Look at mean tooth growth in each of the six cells.
# Which combination has the highest average tooth growth?
# Which has the lowest?
aggregate(len ~ supp + dose, data = dat, FUN = mean)

# Q3. Find the standard deviation in each cell.
# (Hint: change FUN = mean to FUN = sd.)



# 2. VISUALIZE THE INTERACTION ------------------------------

# Q4. Before running the ANOVA, inspect the interaction plot.
# Do the lines appear parallel? What does the plot suggest?
interaction.plot(dat$dose, dat$supp, dat$len,
                 xlab = "Vitamin C dose (mg/day)",
                 ylab = "Mean tooth growth",
                 trace.label = "Supplement",
                 main = "Tooth growth by dose and supplement")


# 3. CHECK ASSUMPTIONS -------------------------------------

# Independence: each animal contributes only one observation.
# Check homogeneity of variance across the SIX cells.

# Q5. Find the variance in each cell.
cell_vars <- tapply(dat$len, list(dat$supp, dat$dose), var)
cell_vars

# Q6. Calculate largest cell variance / smallest cell variance.
# We used a rough classroom guideline of a ratio below 3.
# What is your conclusion? This is a rule of thumb, not a test.


# Q7. Check normality - inspect the normality in each cell using histograms
# Here is one for a dose of 0.5 mg and orange juice
hist(dat$len[dat$dose == 0.5 & dat$supp == "OJ"])

# run the five other histograms.
# What is your conclusion about the normality in these cells?

# 4. RUN THE TWO-WAY ANOVA ----------------------------------

# Q8. Fill in the model formula below and run it.
# Remove the hashtag.
# Include BOTH main effects and their interaction.
# Hint: response ~ factor1 * factor2

# twoway.mod <- aov(______________________, data = dat)

# Q8. Check normality with the model's Q-Q plot.
# plot(twoway.mod, which = 2)
# Does the plot look approximately reasonable?

# Q9. Print the ANOVA table.
# summary(twoway.mod)
# Record the conclusions for:
#  - Main effect of supplement:
#  - Main effect of dose:
#  - Supplement x dose interaction:


# 5. EFFECT SIZES -------------------------------------------

# Q10. Calculate eta-squared for the two main effects and
# the interaction. Which effect accounts for the most variance?
# eta_squared(twoway.mod)


# 6. FOLLOW-UP COMPARISONS ---------------------------------

# Q11. If there is an interaction, a useful follow-up is to
# compare the SIX supplement-by-dose cells.
# Run Tukey-adjusted pairwise comparisons for the interaction.
# Hint: use TukeyHSD(twoway.mod, which = "supp:dose")



# 7. PUT IT IN WORDS ----------------------------------------

# Q12. In 3-5 sentences, explain the overall pattern in the
# data. Include what the interaction says about the effects
# of dose and supplement type. Be careful: a significant
# interaction does not tell you that EVERY pair differs.
#
# Answer:
#
#
#
