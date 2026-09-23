############################################################
# One Way ANOVA demo in R
# Dataset: clinicaltrial.Rdata (load in)
# Outcome: mood.gain 
# Grouping variable: drug (placebo, anxifree, joyzepam)
############################################################

#-----------------------------------------------------------
# 0. Setup: load packages and data
#-----------------------------------------------------------

library(psych)
library(effectsize) 
library(rstatix)
library(ggplot2)
library(car)

# Load clinicaltrial.Rdata data
load("clinicaltrial.Rdata")
str(clin.trial)


# Quick peek
head(clin.trial)
table(clin.trial$drug)

############################################################
# 1. Descriptive statistics
############################################################

# Overall descriptives for mood.gain
describe(clin.trial$mood.gain)

# Descriptives by drug
describeBy(clin.trial$mood.gain,
           group = clin.trial$drug)


############################################################
# 2. Check homogeneity of variance in each group (rough check)
############################################################

# Compute variance in each group
group_vars <- tapply(clin.trial$mood.gain,
                     clin.trial$drug,
                     var)
group_vars

# but this also works
var(clin.trial$mood.gain[clin.trial$drug == "placebo"])
var(clin.trial$mood.gain[clin.trial$drug == "anxifree"])
var(clin.trial$mood.gain[clin.trial$drug == "joyzepam"])

# Levene's test
leveneTest(mood.gain ~ drug, data = clin.trial)

# Simple rule of thumb:
# largest variance / smallest variance < 3
var_ratio <- max(group_vars) / min(group_vars)
var_ratio

# Interestingly - Levene's test is not sensitive in small
# samples (we have six per group), the variance ratio
# tells us we may have some heterogeneity, Levene's
# test did not alert us to this


############################################################
# 3. Check normality (visually + Shapiro–Wilk)
############################################################

# We'll make histograms and Q-Q plots for each group.
par(mfrow = c(2, 3))  # 2x3 plotting layout

# Histograms by group
hist(clin.trial$mood.gain[clin.trial$drug == "placebo"],
     main = "Histogram of mood gain (placebo)",
     xlab = "Mood Gain",
     col = "lightblue",
     border = "white")

hist(clin.trial$mood.gain[clin.trial$drug == "anxifree"],
     main = "Histogram of mood gain (anxifree)",
     xlab = "Mood Gain",
     col = "lightgreen",
     border = "white")

hist(clin.trial$mood.gain[clin.trial$drug == "joyzepam"],
     main = "Histogram of mood gain (joyzepam)",
     xlab = "Mood Gain",
     col = "orange",
     border = "white")

# Q-Q plots by group (we may skip depending on time)
qqnorm(clin.trial$mood.gain[clin.trial$drug == "placebo"],
       main = "Q-Q Plot (VC)")
qqline(clin.trial$mood.gain[clin.trial$drug == "placebo"])

qqnorm(clin.trial$mood.gain[clin.trial$drug == "anxifree"],
       main = "Q-Q Plot (OJ)")
qqline(clin.trial$mood.gain[clin.trial$drug == "anxifree"])

qqnorm(clin.trial$mood.gain[clin.trial$drug == "joyzepam"],
       main = "Q-Q Plot (OJ)")
qqline(clin.trial$mood.gain[clin.trial$drug == "joyzepam"])

# Reset plotting layout
par(mfrow = c(1, 1))

# Shapiro–Wilk test
shapiro.test(clin.trial$mood.gain[clin.trial$drug == "placebo"])
shapiro.test(clin.trial$mood.gain[clin.trial$drug == "anxifree"])
shapiro.test(clin.trial$mood.gain[clin.trial$drug == "joyzepam"])

# IMPORTANT NOTE::
# Shapiro–Wilk has low power with small samples (often misses real non-normality,
# and I would argue this is the case here actually...)
# and very high power with large samples (flags tiny, unimportant deviations).
# Use it as a rough check, but *rely more on visual inspection* of histograms and
# QQ-plots

############################################################
# 4. Run the one-way ANOVA
############################################################

# even though we have some non-normality and heterogeneity
# of variance I will show you how to run all the tests.
# here's our basic one-way anova
oneway.mod <- aov(mood.gain ~ drug, data = clin.trial)
                
plot(oneway.mod, which = 2) # here's how we can check normality (Q-Q plot)
                            # at the model level
                            # you can interpret this like you
                            # would at the group level - this isn't so bad.

summary(oneway.mod) # here's our summary table

# effect size: eta squared
eta_squared(oneway.mod) # FYI this is MASSIVE
    
# Our homogeneity of variance assumption was a little questionable...
# here's the Welch's correction
oneway.test(mood.gain ~ drug, data = clin.trial)

# If data was non-normal but all the groups were similar in shape
# (e.g., all positively skewed, all negatively skewed, etc...)
kruskal.test(mood.gain ~ drug, data = clin.trial) # we will have a class
                                                  # on this later in the
                                                  # term

############################################################
# 5. Post Hocs
############################################################
# use ?pairwise.t.test... so many!

#### Family Wise Error Rate ####
# Bonferroni
pairwise.t.test(clin.trial$mood.gain,
                clin.trial$drug,
                p.adjust.method = "bonferroni")

# Holm - we didn't talk about this one in class, but also popular
pairwise.t.test(clin.trial$mood.gain,
                clin.trial$drug,
                p.adjust.method = "holm")

# Tukey - little different code
TukeyHSD(oneway.mod)

# Ditto with Games Howell, code slightly different
games_howell_test(clin.trial, mood.gain ~ drug)


# False Discovery Rate ####

#Benjamini–Hochberg 
pairwise.t.test(clin.trial$mood.gain,
                clin.trial$drug,
                p.adjust.method = "BH")

# if we used kruskal-wallis appropriate follow up is
pairwise.wilcox.test(clin.trial$mood.gain, clin.trial$drug,
                     p.adjust.method = "BH") # you can change the p.adjust.method
# warning here is not a problem

#Benjamini–Yekutieli 
pairwise.t.test(clin.trial$mood.gain,
                clin.trial$drug,
                p.adjust.method = "BY")

#### Visualize your results
# simple:
boxplot(clin.trial$mood.gain ~ clin.trial$drug, col = c("orange","blue4", "green4"))

# little more involved:
clin.trial$drug <- factor(clin.trial$drug, levels = c("placebo", "anxifree", "joyzepam"))

ggplot(clin.trial, aes(x = drug, y = mood.gain, fill = drug)) +
  geom_boxplot(width = 0.55, outlier.shape = NA, alpha = 0.7) +
  geom_jitter(aes(color = drug), width = 0.10, alpha = 0.45, size = 2, show.legend = FALSE) +
  scale_fill_brewer(palette = "Set2") +
  scale_color_brewer(palette = "Set2") +
  labs(
    title = "Mood gain by treatment",
    x = NULL,
    y = "Mood gain"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "none")



############################################################
# 6. Sample Write-Up (APA-style)
############################################################

# Sample Methods section (this is super short)

# A one-way analysis of variance (ANOVA) was conducted to examine whether
# mood gain differed across three drug conditions: placebo, anxifree,
# and joyzepam. Assumptions of normality and
# homogeneity of variance were evaluated using visual inspection of
# histograms and Q–Q plots, along with inspection of the variances
# . Effect size was quantified using generalized eta squared (η²).

# ----------------------------------------------------------

# Sample Results section

# Descriptive statistics indicated differences in mean mood gain across
# drug conditions. WRITE MEANS AND SDS HERE.

# Write outcomes of assumption checks here... reference some figures.

# A Welch's one-way ANOVA revealed a statistically significant effect of drug
# condition on mood gain, F(2, 15) = XX.XX, p = .XXX.
# The effect size was large, η² = .XX, indicating that a substantial
# proportion of variability in mood gain was attributable to drug condition.

# **note choice of howell here because variances differ
# Follow-up post-hoc comparisons were conducted to identify which drug
# conditions differed from one another. Using the Games–Howell procedure,
# mood gain in the joyzepam group (MEAN HERE) was significantly higher than in the
# placebo group MEAN HERE) with (p = .XXX). The difference between anxifree (MEAN HERE)
# and placebo  was [significant / not significant], and the difference 
# between anxifree  and joyzepam was [significant / not significant].


