############################################################
# PSY 300 - TWO-WAY FACTORIAL ANOVA: SOLUTIONS
# Instructor version - ToothGrowth (built into R)
############################################################

library(psych)
library(effectsize)

data("ToothGrowth")
dat <- ToothGrowth
dat$dose <- as.factor(dat$dose)

str(dat)
head(dat)

# Q1. Two supplement levels (OJ, VC) and three dose levels
# (0.5, 1, 2). 2 x 3 = 6 cells, with 10 animals per cell.
levels(dat$supp)
levels(dat$dose)
table(dat$supp, dat$dose)


# Q2. Cell means
aggregate(len ~ supp + dose, data = dat, FUN = mean)
# Largest: OJ at dose 2 (mean 26.06)
# Smallest: VC at dose 0.5 (mean 7.98)

# Q3. Cell standard deviations
aggregate(len ~ supp + dose, data = dat, FUN = sd)


# Q4. Interaction plot
interaction.plot(dat$dose, dat$supp, dat$len,
                 xlab = "Vitamin C dose (mg/day)",
                 ylab = "Mean tooth growth",
                 trace.label = "Supplement",
                 main = "Tooth growth by dose and supplement")
# The lines are not parallel. OJ tends to produce greater
# tooth growth at the lower doses, but the groups are much
# closer at the highest dose. This suggests an interaction.


# Q5. Variance in each of the SIX cells
cell_vars <- tapply(dat$len, list(dat$supp, dat$dose), var)
cell_vars

# Q6. Largest / smallest cell variance
max(cell_vars) / min(cell_vars)
# Compare the result with the rough classroom guideline (< 3).
# This is only a descriptive check of variance heterogeneity;
# do not treat 3 as a formal significance cutoff.

# Q7. Normality
hist(dat$len[dat$supp == "OJ" & dat$dose == 0.5])
hist(dat$len[dat$supp == "VC" & dat$dose == 0.5])

hist(dat$len[dat$supp == "OJ" & dat$dose == 1])
hist(dat$len[dat$supp == "VC" & dat$dose == 1])

hist(dat$len[dat$supp == "OJ" & dat$dose == 2])
hist(dat$len[dat$supp == "VC" & dat$dose == 2])

# Q7. Two-way ANOVA
# The * includes both main effects AND their interaction.
twoway.mod <- aov(len ~ supp * dose, data = dat)

# Q8. Normal Q-Q plot of model residuals
plot(twoway.mod, which = 2)
# Most points should be reasonably close to the reference line.
# Look for striking curvature or extreme departures.

# Q9. ANOVA table
summary(twoway.mod)
# Expected pattern for this dataset:
# - Significant main effect of supplement type.
# - Significant main effect of dose.
# - Significant supplement x dose interaction.
# Because the interaction is significant, do not interpret
# the main effects without considering how the effects vary
# across the levels of the other factor.


# Q10. Eta squared
eta_squared(twoway.mod)
# Dose has the largest eta-squared (of the terms in the model).
# Note: the default output from eta_squared() is partial
# eta-squared. Read the output label carefully.


# Q11. Tukey-adjusted comparisons of the six cells
TukeyHSD(twoway.mod, which = "supp:dose")
# Compare the adjusted p-values and confidence intervals.
# Not every pair of conditions differs significantly.


# Q12. SAMPLE INTERPRETATION
# Tooth growth differed by both vitamin C dose and supplement
# type, and there was also an interaction between them.
# In particular, the difference between orange juice (OJ)
# and ascorbic acid (VC) was more pronounced at lower doses,
# whereas the two delivery methods yielded similar mean tooth
# growth at the highest dose. This means the association of
# supplement type with tooth growth depends on dose.
# Tukey comparisons help identify which specific combinations
# differ; the interaction alone does not establish all pairs.

# TEACHING NOTE:
# This is a built-in teaching dataset; it is not a study of
# human psychological outcomes. It works well because the
# structure is clean and students can focus on two-way ANOVA.
