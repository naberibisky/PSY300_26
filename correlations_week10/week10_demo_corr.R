############################################################
# PSYC 300 - Correlations
# Dataset: sat.act

############################################################

#-----------------------------------------------------------
# 0. Setup: load packages and data
#-----------------------------------------------------------

library(psych)
library(car)

# Load data
data(sat.act)



# Quick peek
head(sat.act)

# let's make a data frame of just test scores
test <- subset(x = sat.act, select = c("ACT","SATQ", "SATV"))
head(test)


############################################################
# 1. Descriptive statistics
############################################################

# Overall descriptives for quality
describe(test)
scatterplotMatrix(test)

cor(test) # we are missing some quantitative scores so we get NAs for any quantitative
          # correlations

cor(test, use = "pairwise") # pairwise deletion
cor(test, use = "complete.obs") # listwise deletion

# easier to read
round(cor(test, use = "complete.obs"), 2) # listwise deletion

# Note: With pairwise deletion, each correlation may be based on a different
# subset of participants. Listwise deletion uses the same (complete) cases
# for all correlations, which is why values can differ across methods.

# Let's stick to listwise for remainder of this script

# can get other kinds of correlations
cor(test, use = "complete.obs", method = "kendall")
cor(test, use = "complete.obs", method = "spearman")


############################################################
# 2. Inferential tests
############################################################

# let's use complete data only
dat_complete <- na.omit(test[, c("SATQ", "SATV", "ACT")])


# First check that association is linear to make sure you
# can model it with pearson's correlation (or at least monotonic)
scatterplotMatrix(dat_complete) # here i'm not seeing anything too different than a line
                        # although maybe we have a restricted range issue

# any outliers?
plot(dat_complete$SATV, dat_complete$SATQ) # i don't see any

# all these are doing listwise deletion
cor.test(dat_complete$SATV, dat_complete$SATQ, method = "pearson") #default
cor.test(dat_complete$SATV, dat_complete$SATQ, method = "spearman")
cor.test(dat_complete$SATV, dat_complete$SATQ, method = "kendall")

# i would stick with Pearson here.


# ----------------------------------------------------------
# Sample Results section (Correlation)
# ----------------------------------------------------------

# Pearson correlations were computed to examine the association between 
# SAT Verbal scores (SATV) and SAT Quantitative scores (SATQ). Results 
# indicated a strong positive relationship between SATV and SATQ, r = .64,
# t(685) = 22.05,  p < .001, 95% CI [.60, .69], such that higher SAT Verbal
# scores were associated with higher SAT Quantitative scores.

# NOTE WHETHER THIS IS A MEANINGFUL ASSOCIATION IN THE CONTEXT OF YOUR 
# RESEARCH

