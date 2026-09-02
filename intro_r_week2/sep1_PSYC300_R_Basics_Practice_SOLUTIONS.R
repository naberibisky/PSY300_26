# PSYC 300
# R Basics Practice - SOLUTIONS
############################################################


# 1. CREATE SOME OBJECTS

# Imagine that you are keeping track of participants in a small study.
#
# Create an object called "original_sample" that stores the number 24.

original_sample <- 24


# Your study recruits 6 additional participants.
# Create an object called "new_sample" by adding 6 to original_sample.

new_sample <- original_sample + 6


# Check the value of both objects by typing their names below.

original_sample
new_sample



############################################################
# 2. CREATE DIFFERENT TYPES OF OBJECTS
############################################################

# Create a character object called "study_topic" that contains:
# "Sleep and Memory"

study_topic <- "Sleep and Memory"


# Create a logical object called "data_collected" and set it equal to TRUE.

data_collected <- TRUE


# Use class() to check the type of each object.

class(study_topic)
class(data_collected)



############################################################
# 3. CREATE A VECTOR
############################################################

# Five participants completed a short memory task.
# Their scores were:
#
# 7, 9, 6, 10, 8
#
# Store these values in an object called "memory_scores"
# using c().

memory_scores <- c(7, 9, 6, 10, 8)


# Print memory_scores to make sure it worked.

memory_scores



############################################################
# 4. USE FUNCTIONS
############################################################

# Use the appropriate functions to find:
#
# - the mean memory score
# - the standard deviation of the memory scores
# - the number of scores in the vector

mean(memory_scores)
sd(memory_scores)
length(memory_scores)


# Now save the mean in an object called "mean_memory".

mean_memory <- mean(memory_scores)


# Print mean_memory.

mean_memory



############################################################
# 5. ADD A USEFUL COMMENT
############################################################

# We calculate the standard deviation to understand how spread out
# the memory scores are around the mean.

sd(memory_scores)



############################################################
# 6. DEBUGGING: WHAT WENT WRONG?
############################################################

# Each piece of code below contains a mistake.
# Run it, look at the error, and then FIX the code.


# ERROR 1

# favorite_analysis <- ttest

# What was wrong?
#
# "ttest" is text, so it needs quotation marks.
# Without quotation marks, R interprets ttest as the name of an object.

# Corrected code:

favorite_analysis <- "ttest"
favorite_analysis


# ERROR 2

# mean(memory_score)

# What was wrong?
#
# The object we created is called "memory_scores" (plural),
# not "memory_score" (singular).
# R requires object names to match exactly.

# Corrected code:

mean(memory_scores)



############################################################
# 7. USING A PACKAGE
############################################################

# Load the psych package.

library(psych)


# Use describe() to get a more detailed summary of memory_scores.

describe(memory_scores)



############################################################
# 8. QUICK REFLECTION
############################################################

# Answer these questions using comments (#) in your R script.

# 1. What is the difference between creating an object and using a function?
#
# Example answer:
# Creating an object stores information under a name so that we can
# use it later. A function performs an operation or calculation on
# information that we give it.


# 2. Which error in this exercise do you think would be easiest
#    to accidentally make when working in R?
#
# Example answer:
# Accidentally using the wrong object name would be very easy because
# R requires spelling, capitalization, and singular/plural names to
# match exactly.


############################################################
# YOU'RE DONE!
############################################################
