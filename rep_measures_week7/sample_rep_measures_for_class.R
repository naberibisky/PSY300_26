############################################################
# PSY 300 - Stroop Repeated-Measures Activity
#
# Dataset: psy300_response - Form Responses 1.csv
#
# Outcome:
#   Mean response time in milliseconds
#
# Within-subjects variable:
#   Stroop condition
#   - Congruent
#   - Neutral
#   - Incongruent
#
# Each participant completed trials from all three conditions.
# Although the trials were intermixed, each participant ultimately
# has one mean response time for each condition.
############################################################


#-----------------------------------------------------------
# 0. Setup: load packages and data
#-----------------------------------------------------------

library(tidyr)
library(psych)
library(rstatix)
library(ez)
library(ggplot2)


# Import the Google Form data
#
# We import the first two columns as text.
# This prevents an ID such as 0192 from becoming 192.

dat <- read.csv("psy300_stroop_fake_data.csv", # change me!!
                check.names = FALSE,
                colClasses = c(
    "character",  # Timestamp
    "character",  # Participant ID
    "numeric",    # Congruent
    "numeric",    # Neutral
    "numeric"     # Incongruent
  ))


# Give the columns short, manageable names
names(dat) <- c("Timestamp","ID","Congruent","Neutral","Incongruent")


# We do not need the timestamp for this analysis
dat$Timestamp <- NULL


# Make participant ID a factor
dat$ID <- factor(dat$ID)


# Quick look at the data
head(dat)
str(dat)


# Check the number of responses from each participant ID
table(dat$ID)


# Check for missing values
colSums(is.na(dat))


############################################################
# 1. Examine the wide-format data
############################################################

# At the moment, each participant has one row.
#
# Their three condition scores are stored in three columns:
# Congruent, Neutral, and Incongruent.

head(dat)


# Descriptive statistics for the three conditions
describe(dat[, c("Congruent", "Neutral", "Incongruent")])


# Initial boxplot
boxplot(
  dat$Congruent,
  dat$Neutral,
  dat$Incongruent,
  names = c("Congruent", "Neutral", "Incongruent"),
  main = "Response Times Across Stroop Conditions",
  xlab = "Stroop Condition",
  ylab = "Mean Response Time in Milliseconds")


############################################################
# 2. Convert the data from wide format to long format
############################################################

# For the repeated-measures ANOVA, we want each participant
# to appear three times:
#
# once for Congruent
# once for Neutral
# once for Incongruent

dat_long <- pivot_longer(
  data = dat,
  cols = c(Congruent, Neutral, Incongruent),
  names_to = "Condition",
  values_to = "Response_Time")


# Make Condition an ordered factor
dat_long$Condition <- factor(
  dat_long$Condition,
  levels = c("Congruent", "Neutral", "Incongruent"))


# Look at the long-format data
head(dat_long, 9)


# Each ID should ordinarily appear three times
table(dat_long$ID)


# Descriptive statistics by condition
describeBy(
  dat_long$Response_Time,
  dat_long$Condition)


############################################################
# 3. Visualize the repeated-measures data
############################################################

# This graph shows each participant's pattern across conditions.
#
# Each line represents one participant.
# This makes the repeated-measures structure visible.

ggplot(
  dat_long,
  aes(
    x = Condition,
    y = Response_Time,
    group = ID
  )
) +
  geom_line(alpha = .35) +
  geom_point(alpha = .55) +
  stat_summary(
    aes(group = 1),
    fun = mean,
    geom = "line",
    linewidth = 1.5
  ) +
  stat_summary(
    aes(group = 1),
    fun = mean,
    geom = "point",
    size = 4
  ) +
  labs(
    title = "Response Time Across Stroop Conditions",
    subtitle = "Thin lines represent individual participants",
    x = "Stroop Condition",
    y = "Mean Response Time in Milliseconds"
  ) +
  theme_minimal(base_size = 14)


# A simpler graph showing only the condition means

ggplot(
  dat_long,
  aes(
    x = Condition,
    y = Response_Time,
    group = 1
  )
) +
  stat_summary(
    fun = mean,
    geom = "line",
    linewidth = 1.2
  ) +
  stat_summary(
    fun = mean,
    geom = "point",
    size = 3
  ) +
  labs(
    title = "Mean Response Time Across Stroop Conditions",
    x = "Stroop Condition",
    y = "Mean Response Time in Milliseconds"
  ) +
  theme_minimal(base_size = 16)


############################################################
# 4. Check normality visually
############################################################

# Reaction-time data are often somewhat positively skewed.
# We are looking for serious skew, unusual distributions,
# and extreme observations—not perfect normality.

par(mfrow = c(1, 3))


hist(
  dat_long$Response_Time[
    dat_long$Condition == "Congruent"
  ],
  main = "Congruent",
  xlab = "Mean Response Time",
  breaks = 8)


hist(
  dat_long$Response_Time[
    dat_long$Condition == "Neutral"
  ],
  main = "Neutral",
  xlab = "Mean Response Time",
  breaks = 8)


hist(
  dat_long$Response_Time[
    dat_long$Condition == "Incongruent"
  ],
  main = "Incongruent",
  xlab = "Mean Response Time",
  breaks = 8)


# Reset plotting layout
par(mfrow = c(1, 1))


# Optional Shapiro-Wilk tests
#
# Remember: these tests can be sensitive to sample size.
# Interpret them alongside the graphs.

shapiro.test(
  dat_long$Response_Time[
    dat_long$Condition == "Congruent"])

shapiro.test(
  dat_long$Response_Time[
    dat_long$Condition == "Neutral"])

shapiro.test(
  dat_long$Response_Time[
    dat_long$Condition == "Incongruent"])


############################################################
# 5. Run the repeated-measures ANOVA
############################################################

ANOVA_results <- ezANOVA(
  data = dat_long,
  wid = ID,
  within = Condition,
  dv = Response_Time,
  detailed = TRUE)


# Main ANOVA table
ANOVA_results$ANOVA


# Mauchly's test of sphericity
ANOVA_results$`Mauchly's Test for Sphericity`


# Greenhouse-Geisser and Huynh-Feldt corrections
ANOVA_results$`Sphericity Corrections`


# Generalized eta squared
#
# In the ezANOVA table, generalized eta squared is listed as ges.

ANOVA_results$ANOVA$ges # we only care about the second one - this
# first one is for our intercept - who cares that it is not very 
# different than zero?! The second one is our effect of condition,

# Condition accounted for about 26.3% of the variability in response times,
# as measured by generalized eta-squared.


############################################################
# 6. Selecting the appropriate ANOVA result
############################################################

# If Mauchly's test is not significant:
#
# p > .05
#
# Sphericity does not appear to be violated.
# Interpret the ordinary ANOVA result.


# If Mauchly's test is significant:
#
# p < .05
#
# Sphericity appears to be violated.
# Interpret a corrected result.



# The lecture decision rule:
#
# epsilon <= .75:
# use Greenhouse-Geisser
#
# epsilon > .75:
# Huynh-Feldt may be used

ANOVA_results$`Sphericity Corrections` # epsilons are GGe and HFe, check GGe first
# but dont bother checking either if Mauchly's test is not violated

############################################################
# 7. Pairwise comparisons
############################################################

# These are paired comparisons because the same participants
# completed both conditions in every comparison.

pairwise_results <- pairwise_t_test(
  data = dat_long,
  formula = Response_Time ~ Condition,
  paired = TRUE,
  p.adjust.method = "bonferroni",
  detailed = TRUE)


pairwise_results


############################################################
# 8. Optional nonparametric alternative
############################################################

# The Friedman test is a nonparametric alternative to the
# one-way repeated-measures ANOVA.
#
# It may be considered when the distributions contain serious
# problems and the repeated-measures ANOVA is inappropriate.

friedman.test(
  Response_Time ~ Condition | ID,
  data = dat_long)


############################################################
# 9. Useful descriptive differences
############################################################

# Calculate each participant's overall Stroop effect:
#
# Incongruent response time minus congruent response time

dat$Stroop_Effect <- dat$Incongruent - dat$Congruent


# Positive values mean that the participant was slower during
# incongruent trials than during congruent trials.

describe(dat$Stroop_Effect)


# Facilitation:
#
# Neutral minus congruent
#
# Positive values mean congruent trials were faster than neutral trials.

dat$Facilitation <- dat$Neutral - dat$Congruent
describe(dat$Facilitation)

# Interference:
#
# Incongruent minus neutral
#
# Positive values mean incongruent trials were slower than neutral trials.

dat$Interference <- dat$Incongruent - dat$Neutral
describe(dat$Interference)


describe(
  dat[, c(
    "Stroop_Effect",
    "Facilitation",
    "Interference"
  )])


############################################################
# 10. Sample results section
############################################################

# Descriptive statistics were calculated for mean response time
# in the congruent, neutral, and incongruent Stroop conditions.
#
# Participants responded most quickly in the __________ condition
# (M = _____, SD = _____), followed by the __________ condition
# (M = _____, SD = _____). Response times were highest in the
# __________ condition (M = _____, SD = _____).


# The assumptions of the repeated-measures ANOVA were examined
# before conducting the analysis. Normality was evaluated through
# visual inspection of the response-time distributions for each
# condition and, optionally, Shapiro-Wilk tests. Sphericity was
# evaluated using Mauchly's test.
#
# [Describe the normality results.]
#
# [Report whether Mauchly's test was significant.]
#
# [State whether an uncorrected, Greenhouse-Geisser-corrected,
# or Huynh-Feldt-corrected result was interpreted.]


# A one-way repeated-measures ANOVA was conducted to examine
# whether mean response time differed across the congruent,
# neutral, and incongruent Stroop conditions.
#
# The analysis revealed that the effect of Stroop condition was
# [statistically significant / not statistically significant],
# F(df_condition, df_error) = XX.XX, p = .XXX,
# generalized eta squared = .XX.


# Bonferroni-adjusted paired-samples comparisons were conducted
# to examine differences between individual conditions.
#
# Response times were [higher/lower] in the incongruent condition
# than in the congruent condition, p = _____.
#
# Response times were [higher/lower] in the incongruent condition
# than in the neutral condition, p = _____.
#
# Response times were [higher/lower] in the neutral condition
# than in the congruent condition, p = _____.


# Overall, these results [supported / did not support] the expected
# Stroop pattern. Participants were expected to respond most quickly
# during congruent trials and most slowly during incongruent trials.