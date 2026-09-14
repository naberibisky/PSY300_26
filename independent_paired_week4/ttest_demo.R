#-----
# Import and examine the data
#-----

# Upload music_memory_ttest.csv into the same JupyterHub
# folder as this notebook.

memory_data <- read.csv("music_memory_ttest.csv")

# View the first 6 rows
head(memory_data)

# Check the variable names
names(memory_data)

# Check the groups and sample sizes
table(memory_data$group)


#-----
# Describe the groups
#-----

library(psych)

# Display descriptive statistics for each group
describeBy(memory_data$memory_score,
           group = memory_data$group)


#-----
# Check normality
#-----

# Create a histogram for the Silence group.
# Look for a roughly symmetric distribution without extreme values.

hist(memory_data$memory_score[memory_data$group == "Silence"],
     main = "Memory Scores: Silence Group",
     xlab = "Memory Score")

# Create a histogram for the Music group.

hist(memory_data$memory_score[memory_data$group == "Music"],
     main = "Memory Scores: Music Group",
     xlab = "Memory Score")


#-----
# Check homogeneity of variance
#-----

# Calculate the variance for the Silence group
silence_variance <- var(
  memory_data$memory_score[memory_data$group == "Silence"]
)

# Calculate the variance for the Music group
music_variance <- var(
  memory_data$memory_score[memory_data$group == "Music"]
)

# Display both variances
silence_variance
music_variance

# Divide the larger variance by the smaller variance.
# A ratio below approximately 3 suggests similar variances.

variance_ratio <- max(silence_variance, music_variance) /
  min(silence_variance, music_variance)

variance_ratio


#-----
# Run the independent-samples t-test
#-----

# by default we run a Welch's t-test in R, if for whatever reason you
# want to run student's t, just use an optional argument
# var.equal = TRUE in the function (but remember lecture - 
# you really shouldn't)

t_test_result <- t.test(memory_score ~ group,
                        data = memory_data)

# Display the results
t_test_result


#-----
# Calculate Cohen's d
#-----

# Install effectsize only if it is not already available.
# install.packages("effectsize")

library(effectsize)

cohens_d(memory_score ~ group,
         data = memory_data,
         pooled_sd = TRUE)
