############################################################
# Two-Way ANOVA demo in R
# Dataset: message_quality.csv (load in)
# Outcome: quality
# Grouping variables: authoritarianism (high/low); message quality (threatening/rewarding)
############################################################
# Research context: 
# Taken from Tokunaga, H. T. (2016). 
# Fundamental statistics for the behavioural sciences. 
# Los Angeles, CA: Sage Publications
# and adapted from Dr. Monique Herbert

# Lavine et al. (1999) examined how different persuasive messages influence
# voters’ perceptions of message quality. Participants were exposed to either
# a threatening message (emphasizing negative consequences of not voting) or
# a rewarding message (emphasizing positive outcomes of voting).
#
# The researchers hypothesized that message effectiveness would depend on
# individuals’ level of authoritarianism, defined as the tendency to perceive
# the world as dangerous and threatening.
#
# Specifically:
# - High-authoritarianism individuals were expected to find threatening
#   messages more persuasive than rewarding messages.
# - Low-authoritarianism individuals were expected to find rewarding messages
#   more persuasive than threatening messages.
#
# Message effectiveness was operationalized as perceived message quality,
# measured on a continuous scale from 1 to 7, with higher values indicating
# higher perceived quality.
#
# This setup represents a factorial design in which the effect of message type
# is expected to depend on authoritarianism (i.e., an interaction).
#-----------------------------------------------------------
# Setup: load packages and data
#-----------------------------------------------------------

library(car)        # Levene's test
library(psych)      # descriptive statistics
library(effectsize) # effect sizes
library(effects)    # estimated means and confidence intervals
library(ez)         # heteroscedasticity correction
library(WRS2)       # robust ANOVA



dat <- read.csv("message_quality.csv")
str(dat) # notice that message type and authoritarianism are not factors
        # we will need to change this
dat$message_type <- as.factor(dat$message_type)
dat$authoritarianism <- as.factor(dat$authoritarianism)

# Quick peek
head(dat)
table(dat$message_type)
table(dat$authoritarianism)

############################################################
# 1. Descriptive statistics
############################################################

# Overall descriptives for quality
describe(dat$quality)

# Descriptives by both factors
describeBy(dat$quality,
           group = dat$message_type)

describeBy(dat$quality,
           group = dat$authoritarianism)

# View each cell/condition for interactions
describeBy(dat$quality, 
           list(dat$message_type, dat$authoritarianism))

############################################################
# 2. Check homogeneity of variance in each group (rough check)
############################################################

# Compute variance in each group
group_vars <- tapply(dat$quality,
                     list(dat$message_type, dat$authoritarianism),
                     var)
group_vars


# Levene's test (note how we are entering it is a little different than before)
leveneTest(quality ~ message_type * authoritarianism, data = dat) 

# Simple rule of thumb:
# largest variance / smallest variance < 3
var_ratio <- max(group_vars) / min(group_vars)
var_ratio



############################################################
# 3. Check normality (visually + Shapiro–Wilk)
############################################################

# We'll make histograms and Q-Q plots for each group.
# note we could do violin plots or boxplots too, these are just options
par(mfrow = c(2, 4))  # 2x4 plotting layout

# Histograms by group
hist(dat$quality[dat$message_type == "reward" & dat$authoritarianism == "low"],
     main = "Histogram of quality (reward & low)",
     xlab = "Quality",
     col = "lightblue",
     border = "white")

hist(dat$quality[dat$message_type == "reward" & dat$authoritarianism == "high"],
     main = "Histogram of quality (reward & high)",
     xlab = "Quality",
     col = "lightgreen",
     border = "white")

hist(dat$quality[dat$message_type == "threat" & dat$authoritarianism == "low"],
     main = "Histogram of quality (threat & low)",
     xlab = "Quality",
     col = "pink",
     border = "white")

hist(dat$quality[dat$message_type == "threat" & dat$authoritarianism == "high"],
     main = "Histogram of quality (threat & high)",
     xlab = "Quality",
     col = "orange",
     border = "white")

# Q-Q plots by group
qqnorm(dat$quality[dat$message_type == "reward" & dat$authoritarianism == "low"],
       main = "Q-Q Plot (VC)")
qqline(dat$quality[dat$message_type == "reward" & dat$authoritarianism == "low"])

qqnorm(dat$quality[dat$message_type == "reward" & dat$authoritarianism == "high"],
       main = "Q-Q Plot (OJ)")
qqline(dat$quality[dat$message_type == "reward" & dat$authoritarianism == "high"])

qqnorm(dat$quality[dat$message_type == "threat" & dat$authoritarianism == "low"],
       main = "Q-Q Plot (OJ)")
qqline(dat$quality[dat$message_type == "threat" & dat$authoritarianism == "low"])

qqnorm(dat$quality[dat$message_type == "threat" & dat$authoritarianism == "high"],
       main = "Q-Q Plot (OJ)")
qqline(dat$quality[dat$message_type == "threat" & dat$authoritarianism == "high"])

# Reset plotting layout
par(mfrow = c(1, 1))


# normality looks to be a problem
############################################################
# 4. Run the two-way ANOVA
############################################################

# Even though we have some non-normality
# I will show you how to run all the ANOVA types.

# here's our basic two-way anova (both lines are the same when there's 
# an interaction)
twoway.mod <- aov(quality ~ message_type + authoritarianism + 
                    message_type*authoritarianism, data = dat)
twoway.mod <- aov(quality ~ message_type*authoritarianism, data = dat)
                
plot(twoway.mod, which = 2) # here's how we can check normality (Q-Q plot)
                            # at the model level
                            # you can interpret this like you
                            # would at the group level - this isn't so bad.
                            # I would actually lean to keeping the regular ANOVA

summary(twoway.mod) # here's our summary table

# effect size: generalized eta squared
eta_squared(twoway.mod) # one per factor and interaction - interaction
                        # is really doing a lot of work here.


# look at mean differences and confidence intervals
summary(effect("message_type*authoritarianism", twoway.mod))

# interaction plots
interaction.plot(dat$message_type, 
                 dat$authoritarianism, 
                 dat$quality,
                 xlab = "Message Type",
                 ylab = "Quality",
                 trace.label  = "Authoritarianism",
                 main = "Interactive Effects of Message Type x Authoritarianism on Quality")

# we can swap this
interaction.plot(dat$authoritarianism, 
                 dat$message_type, 
                 dat$quality,
                 xlab = "Authoritarianism",
                 ylab = "Quality",
                 trace.label  = "Message Type",
                 main = "Interactive Effects of Message Type x Authoritarianism on Quality")


# If homogeneity of variance assumption was not met
ANOVA_results_hetvar <- ezANOVA(data = dat,
                         wid = ID, # wid is a variable with a unique subject id for each subject 
                         between = c("message_type","authoritarianism"), # for interaction,
                         dv = quality,
                         white.adjust = TRUE) # for variance heterogeneity

# to see the results
ANOVA_results_hetvar$ANOVA

# If data was non-normal and variance homogeneity violated
t2way(quality ~ message_type*authoritarianism, data = dat, trim = 0.1)
############################################################
# 5. Probe interaction
############################################################
# there are many ways we can do this but I will show you 
# a strategy that's generalizable beyond the 2x2 design we have here

# first, we create two subsets using the levels of authoritarianism.
# (we could have done this with message type - it just depends on
# what you are interested in looking at)

# Create subsets based on authoritarianism level
data_low_auth  <- subset(dat, authoritarianism == "low")
data_high_auth <- subset(dat, authoritarianism == "high")

# next, create two ANOVA objects (one way anovas)
low_auth_model  <- aov(quality ~ message_type,
                       data = data_low_auth)
high_auth_model <- aov(quality ~ message_type,
                       data = data_high_auth)

# we don't need the summary function for our 2x2 but if you had a 3 different message
# types you would run the summary function first
summary(low_auth_model)
summary(high_auth_model)

# then you can use any pairwise comparison:
#e.g. Tukey
TukeyHSD(x = low_auth_model) # low
TukeyHSD(x = high_auth_model) #high

# e.g., BH
# Low
pairwise.t.test(data_low_auth$quality,
                data_low_auth$message_type,
                p.adjust.method = "BH")

# High
pairwise.t.test(data_high_auth$quality,
                data_high_auth$message_type,
                p.adjust.method = "BH")

# ----------------------------------------------------------
# Sample Results section (Two-way ANOVA: message_type × authoritarianism)
# ----------------------------------------------------------

# Descriptive statistics were computed for perceived message quality across
# message type (threatening vs rewarding) and authoritarianism level (low vs high).
# Means and standard deviations for each condition are reported below.
# [Insert the relevant cell means and standard deviations here,
# using your describeBy output or something else]

# Assumptions of the two-way ANOVA were evaluated using visual inspection of
# histograms and Q–Q plots at the cell level, as well as a Q–Q plot of the model
# residuals. Homogeneity of variance was assessed using Levene’s test and
# inspection of group variances.
# [Briefly summarize the results of these checks here.]

# A two-way analysis of variance (ANOVA) was conducted with perceived message
# quality as the dependent variable and message type (threatening vs rewarding)
# and authoritarianism (high vs low) as between-subjects factors.

# The interaction between message type and authoritarianism was
# [significant / not significant], F(1, df_error) = XX.XX, p = .XXX.
# As can be seen from Figure X, the interaction results suggest that...
# describe results...
# The effect size for the interaction, quantified using generalized eta squared,
# was η^2= .XX. The full results can be seen in Table X.

# Because the interaction was of primary interest, follow-up analyses examined
# the effect of message type separately within each level of authoritarianism.
# Among low-authoritarianism participants, perceived message quality was
# [higher / lower] for the [rewarding / threatening] message than for the
# [threatening / rewarding] message, p = .XXX.
# Among high-authoritarianism participants, perceived message quality was
# [higher / lower] for the [threatening / rewarding] message than for the
# [rewarding / threatening] message, p = .XXX. Note error control use.

# This pattern of results [supports / does not support] the presence of an
# interaction between message type and authoritarianism.


