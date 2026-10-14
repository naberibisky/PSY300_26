# PSY 300 - Mixed Factorial ANOVA Reference Script

# Example research question:
# Do two therapy groups show different patterns of change over time?
#
# Between-subjects factor: therapy
# Within-subjects factor: time
# Outcome: anxiety
# Participant identifier: ID
#
# IMPORTANT:
# The data should be in LONG format.
# Each participant should have one row for each time point.

library(psych)
library(car)
library(effectsize)
library(ez)


# 1. Load and inspect the data

dat <- read.csv("therapy_data.csv")

str(dat)
head(dat)

# Make sure categorical variables are factors
dat$ID <- as.factor(dat$ID)
dat$therapy <- as.factor(dat$therapy)
dat$time <- as.factor(dat$time)

# Check the levels
levels(dat$therapy)
levels(dat$time)

# Check that each participant has the expected number of observations
table(dat$ID)


# 2. Descriptive statistics

# Descriptives for each therapy x time cell
describeBy(dat$anxiety,
           list(dat$therapy, dat$time))

# Cell means
aggregate(anxiety ~ therapy + time,
          data = dat,
          FUN = mean)

# Cell standard deviations
aggregate(anxiety ~ therapy + time,
          data = dat,
          FUN = sd)


# 3. Visualize the pattern

interaction.plot(dat$time,
                 dat$therapy,
                 dat$anxiety,
                 xlab = "Time",
                 ylab = "Mean Anxiety",
                 trace.label = "Therapy",
                 main = "Therapy x Time Interaction")

# Ask:
# Do both groups change similarly over time?
# Are the lines roughly parallel?
# Does one therapy appear to improve more quickly?


# 4. Check assumptions

# BETWEEN-SUBJECTS:
# Independence is primarily a design issue.
# Participants should be independent of one another.

# Homogeneity of variance can be considered at each time point.
leveneTest(anxiety ~ therapy * time, data = dat) # if you need to use Levene's test


aggregate(anxiety ~ therapy + time,
            data = dat,
            FUN = var)

# Variance ratio = largest variance / smallest variance
9.92/7.41 # numbers from line 84

# WITHIN-SUBJECTS:
# Repeated scores must be correctly linked using the participant ID.
#
# If time has 3 or more levels, we also need to consider sphericity.
# ezANOVA will provide Mauchly's test and corrections when appropriate.


# 5. Run the mixed factorial ANOVA

mixed_results <- ezANOVA(
  data = dat,
  dv = anxiety,
  wid = ID,
  between = therapy,
  within = time,
  detailed = TRUE,
  type = 3)

mixed_results


# Important pieces of output include:
#
# $ANOVA
# Main effect of therapy
# Main effect of time
# Therapy x time interaction
#
# $Mauchly's Test for Sphericity
# Tests the sphericity assumption when the within-subjects
# factor has more than two levels.
#
# $Sphericity Corrections
# Gives Greenhouse-Geisser and Huynh-Feldt corrected results.


# Look specifically at the ANOVA table
mixed_results$ANOVA


# If sphericity is violated:
mixed_results$`Mauchly's Test for Sphericity`
mixed_results$`Sphericity Corrections`

# If Mauchly's test is significant, report a corrected result,
# usually Greenhouse-Geisser.
#
# With only TWO time points, sphericity is automatically satisfied.


# 6. Effect sizes

# ezANOVA reports generalized eta squared in the ANOVA table.
# Look for the column labelled ges.

mixed_results$ANOVA


# 7. Follow up a significant therapy x time interaction

# A significant interaction tells us that change over time
# depends on therapy group.
#
# There are two natural ways to decompose the interaction.


# OPTION A:
# Compare the therapy groups at each time point

baseline <- subset(dat, time == "baseline")
week6 <- subset(dat, time == "week6")
week12 <- subset(dat, time == "week12")

t.test(anxiety ~ therapy,
       data = baseline,
       var.equal = TRUE)

t.test(anxiety ~ therapy,
       data = week6,
       var.equal = TRUE)

t.test(anxiety ~ therapy,
       data = week12,
       var.equal = TRUE)


# Save the p-values and adjust for multiple comparisons if needed
p_values <- c(
  t.test(anxiety ~ therapy,
         data = baseline,
         var.equal = TRUE)$p.value,
  
  t.test(anxiety ~ therapy,
         data = week6,
         var.equal = TRUE)$p.value,
  
  t.test(anxiety ~ therapy,
         data = week12,
         var.equal = TRUE)$p.value
)

p.adjust(p_values, method = "BH") #Benjamini-Hochberg here


# OPTION B:
# Examine change over time separately within each therapy group

therapy_A <- subset(dat, therapy == "CBT")
therapy_B <- subset(dat, therapy == "Mindfulness")

# Because the SAME participants are measured repeatedly,
# comparisons across time are paired.

pairwise.t.test(therapy_A$anxiety,
                therapy_A$time,
                paired = TRUE,
                p.adjust.method = "BH")

pairwise.t.test(therapy_B$anxiety,
                therapy_B$time,
                paired = TRUE,
                p.adjust.method = "BH")


# 8. Interpretation

# Main effect of therapy:
# Averaging across time, do the therapy groups differ?

# Main effect of time:
# Averaging across therapies, does anxiety change over time?

# Therapy x time interaction:
# Does anxiety change differently over time depending on therapy?

# If the interaction is significant, use the graph,
# descriptive statistics, and targeted follow-up tests
# to explain the pattern.