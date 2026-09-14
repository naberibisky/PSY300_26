# Paired samples t-test
# Participants complete a stress scale before and after a short breathing exercise.
# The researcher tests whether stress scores changed after the exercise.

#-----
# Import and examine the data
#-----

# Upload paired_stress_data.csv into the same
# JupyterHub folder as this notebook.

stress_data <- read.csv("paired_stress_data.csv")

# View the first 6 rows
head(stress_data)

# Check the variable names
names(stress_data)

# Check the number of participants
nrow(stress_data)


#-----
# Describe the scores
#-----

# Calculate the mean before the breathing exercise
mean(stress_data$stress_before)

# Calculate the mean after the breathing exercise
mean(stress_data$stress_after)

# Calculate the standard deviations
sd(stress_data$stress_before)
sd(stress_data$stress_after)


#-----
# Create difference scores
#-----

# A paired t-test analyzes the difference between
# each participant's two scores.

stress_data$difference <- stress_data$stress_before -
  stress_data$stress_after

# Positive values mean stress decreased.
head(stress_data)


#-----
# Check normality
#-----

# For a paired t-test, check the distribution
# of the difference scores.

hist(stress_data$difference,
     main = "Distribution of Difference Scores",
     xlab = "Before Score Minus After Score")


#-----
# Run the paired-samples t-test
#-----

# paired = TRUE tells R that the two scores
# came from the same participants.

t_test_result <- t.test(stress_data$stress_before,
                        stress_data$stress_after,
                        paired = TRUE)

# Display the results
t_test_result


#-----
# Calculate Cohen's d
#-----

# For paired data, Cohen's d uses the mean and
# standard deviation of the difference scores.

cohens_d <- mean(stress_data$difference) /
  sd(stress_data$difference)

cohens_d

# unstandardized is in output (4.87 points)

# A paired samples t-test was conducted to compare the stress scores before and after
# a breathing exercise. Stress was lower after the exercise (M = XX, SD = XX) than before
# (M = XX, SD = XX). This difference was statistically significant t(29) = 9.24, p < .001,
# 95% CI [3.79, 5.94], Cohen's d = 1.69.