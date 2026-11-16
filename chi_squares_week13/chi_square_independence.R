# PSY 300
# Chi-Square Test of Independence
# Thanksgiving Pie Preferences Across the United States
library(lsr)
# Research Question:
# Is there a relationship between geographic region
# and Thanksgiving pie preference?

# A national survey conducted on November 21, 2025,
# with 7,259 U.S. adults examined Thanksgiving
# pie preferences across four geographic regions:
#
# Northeast, Midwest, South, and West.
#
# The survey reported different percentages
# for each region.
#
# We will use these percentages to construct
# a FICTIONAL dataset with 100 adults per region.
#
# Note: These are illustrative frequencies based
# on the survey percentages, NOT the original
# survey's raw data.

# Significance level: alpha = .05


# -----------------------------------------
# Enter the Data
# -----------------------------------------

# We can enter the observed frequencies directly
# using a contingency table.

# To keep expected frequencies sufficiently large,
# we combine less common responses into "Other".
#
# Other includes:
# Cherry, other pie types, people who do not
# like pie, and respondents who were unsure.

# Rows = Geographic regions
# Columns = Thanksgiving pie preferences

tabdat <- matrix(
  c(# Pumpkin, Pecan, Apple, Sweet Potato, Chocolate, Other
    
    26, 10, 27,  9, 11, 17,  # Northeast
    37, 15, 17,  6,  8, 17,  # Midwest
    25, 19, 17, 12,  7, 20,  # South
    37, 12, 22,  5,  5, 19   # West
  ),
  
  nrow = 4,
  ncol = 6,
  byrow = TRUE,
  
  dimnames = list(
    c("Northeast", "Midwest", "South", "West"),
    c("Pumpkin", "Pecan", "Apple",
      "Sweet potato", "Chocolate", "Other")
  ))

# View the contingency table
tabdat

# Check row and column totals
rowSums(tabdat)
colSums(tabdat)

# Total sample size
sum(tabdat)


# -----------------------------------------
# Step 1: State the Hypotheses
# -----------------------------------------

# H0: There is no relationship between
# geographic region and Thanksgiving pie preference.
#
# Pie preference and geographic region
# are independent.

# H1: There is a relationship between
# geographic region and Thanksgiving pie preference.
#
# Pie preference and geographic region
# are not independent.


# -----------------------------------------
# Step 2: Determine the Critical Value
# -----------------------------------------

alpha <- .05

# Degrees of freedom:
# (number of rows - 1) * (number of columns - 1)

degf <- (nrow(tabdat) - 1) * (ncol(tabdat) - 1)
degf

# Find the critical chi-square value
qchisq(p = alpha, df = degf, lower.tail = FALSE)


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

# Conduct the chi-square test of independence
chisq.test(tabdat)

# We can also request the observed
# and expected frequencies

chisq.test(tabdat)$observed

chisq.test(tabdat)$expected

# Check whether expected frequencies
# are sufficiently large

min(chisq.test(tabdat)$expected)


# -----------------------------------------
# Step 5: Make a Decision
# -----------------------------------------

# Compare the p-value to alpha = .05

# If p <= .05:
# Reject H0.
# There is a statistically significant
# relationship between geographic region
# and Thanksgiving pie preference.

# If p > .05:
# Fail to reject H0.
# There is insufficient evidence to conclude
# that geographic region and Thanksgiving
# pie preference are associated.


# -----------------------------------------
# Step 6: Examine Differences and Effect Size
# -----------------------------------------

# Unstandardized differences:
# Observed frequencies - Expected frequencies

chisq.test(tabdat)$observed -
  chisq.test(tabdat)$expected


# Standardized effect size: Cramer's V
cramersV(tabdat)



# -----------------------------------------
# Conclusion
# -----------------------------------------

# Based on the results, determine whether
# Thanksgiving pie preference is associated
# with geographic region.

# Remember:
# A statistically significant chi-square test
# indicates an association between the variables.
#
# It does not establish which specific regions
# or pie preferences account for the association.