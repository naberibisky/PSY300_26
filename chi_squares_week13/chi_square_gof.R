# PSY 300
# Chi-Square Goodness-of-Fit Test
# Thanksgiving Pie Preferences

# Research Question:
# Are all Thanksgiving pie types equally preferred?

# A national survey conducted on November 21, 2025,
# with 7,259 U.S. adults reported the following
# Thanksgiving pie preferences:

# Pumpkin:       30%
# Pecan:         15%
# Apple:         20%
# Sweet potato:   9%
# Chocolate:      8%

# We will use these results to create a fictional
# sample of 100 adults who selected one of these
# five pie types.

# We want to test whether all five pie types
# are equally preferred.

# Significance level: alpha = .05
library(lsr)

# -----------------------------------------
# Step 1: State the Hypotheses
# -----------------------------------------

# H0: P = (.20, .20, .20, .20, .20)
# All five pie types are equally preferred.

# H1: P != (.20, .20, .20, .20, .20)
# At least one pie type has a different
# population preference proportion.


# -----------------------------------------
# Step 2: Determine the Critical Region
# -----------------------------------------

alpha <- .05

# Degrees of freedom = number of categories - 1
df <- 5 - 1

# Find the critical chi-square value
qchisq(alpha, df = df, lower.tail = FALSE)


# -----------------------------------------
# Step 3: Establish Decision Rules
# -----------------------------------------

# Using the p-value:
# If p <= alpha, reject H0
# If p > alpha, fail to reject H0

# Using the chi-square statistic:
# If chi-square >= critical value, reject H0
# If chi-square < critical value, fail to reject H0


# -----------------------------------------
# Step 4: Calculate the Test Statistic
# -----------------------------------------

# Fictional observed frequencies from 100 adults
# Approximately reflecting the national survey
# among respondents choosing one of these five pies.

piepref <- c(rep("Pumpkin", 37),
             rep("Pecan", 18),
             rep("Apple", 24),
             rep("Sweet potato", 11),
             rep("Chocolate", 10))

# Create a frequency table
piepreftab <- table(piepref)
piepreftab

# IMPORTANT:
# R orders categories alphabetically.
# Our table is ordered:
# Apple, Chocolate, Pecan, Pumpkin, Sweet potato

# Under H0, all five categories are equally preferred.

expected_proportions <- c(.20, .20, .20, .20, .20)

# Calculate expected frequencies
(expected <- expected_proportions * length(piepref))

# Conduct the chi-square goodness-of-fit test
chisq.test(piepreftab, p = expected_proportions)


# -----------------------------------------
# Step 5: Draw a Conclusion
# -----------------------------------------

# Compare the p-value to alpha = .05

# If p <= .05:
# Reject H0.
# There is statistically significant evidence
# that the five pie types are not equally preferred.

# If p > .05:
# Fail to reject H0.
# There is insufficient evidence to conclude
# that pie preferences differ from equal proportions.

# IMPORTANT:
# A significant chi-square test tells us that
# the overall distribution differs from expectations.
# It does not tell us which specific categories
# are responsible for the difference.


# -----------------------------------------
# Step 6: Examine Differences and Effect Size
# -----------------------------------------

# Compare observed and expected frequencies

piepreftab
expected

# Observed minus expected
piepreftab - expected

# Extract expected frequencies directly
# from the chi-square test

test <- chisq.test(piepreftab, p = expected_proportions)

test$observed
test$expected

test$observed - test$expected



cramersV(piepreftab)

# -----------------------------------------
# Optional: Visualize the Results
# -----------------------------------------

barplot(rbind(test$observed, test$expected),
  beside = TRUE,
  legend.text = c("Observed", "Expected"), col = c("orange", "brown"),
  xlab = "Thanksgiving Pie Preference",
  ylab = "Frequency",
  main = "Observed vs. Expected Thanksgiving Pie Preferences",
  las = 2)
