# One sample t-test

# A standardized memory task has an established population average of 70. 
# A researcher gives the task to 30 students after they use a new study strategy.
# The researcher tests whether their average memory score differs from 70.

#-----
# Import and examine the data
#-----

# Upload one_sample_memory_data.csv into the same
# JupyterHub folder as this notebook.

memory_data <- read.csv("one_sample_memory_data.csv")

# View the first 6 rows
head(memory_data)

# Check the variable names
names(memory_data)

# Check the number of participants
nrow(memory_data)


#-----
# Describe the scores
#-----

# Install psych only if it is not already available.
# install.packages("psych")

library(psych)

# Display descriptive statistics
describe(memory_data$memory_score)

# Calculate the sample mean
mean(memory_data$memory_score)

# Calculate the sample standard deviation
sd(memory_data$memory_score)


#-----
# Check the assumptions
#-----

# Independence is determined by the study design.
# Each participant should contribute only one score.

# Check whether the scores are approximately normally distributed.
# Look for a roughly symmetric shape without extreme values.

hist(memory_data$memory_score,
     main = "Distribution of Memory Scores",
     xlab = "Memory Score")


#-----
# Run the one-sample t-test
#-----

# The known comparison value is 70.
# mu tells R the value used in the null hypothesis.

t_test_result <- t.test(memory_data$memory_score,
                        mu = 70)

# Display the results
t_test_result


#-----
# Calculate Cohen's d
#-----

# Cohen's d shows the size of the difference between
# the sample mean and the comparison value.

cohens_d <- (mean(memory_data$memory_score) - 70) /
  sd(memory_data$memory_score)

cohens_d

# unstandardized effect size
75.83333-70
