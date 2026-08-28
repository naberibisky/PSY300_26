# PSYC 300
# R Basics Practice
#
# This exercise is designed to give you a little practice with the
# R skills we just reviewed. Work through the steps below in order.
#
# Don't worry if you get an error! Read the error message and see
# whether you can figure out what R is telling you.
#------------------------------------


# 1. CREATE SOME OBJECTS

# Imagine that you are keeping track of participants in a small study.
#
# Create an object called "original_sample" that stores the number 24.



# Your study recruits 6 additional participants.
# Create an object called "new_sample" by adding 6 to original_sample.



# Check the value of both objects by typing their names below.





#----------------------------------------------------------------
# 2. CREATE DIFFERENT TYPES OF OBJECTS


# Create a character object called "study_topic" that contains:
# "Sleep and Memory"



# Create a logical object called "data_collected" and set it equal to TRUE.



# Use class() to check the type of each object.





#----------------------------------------------------------------
# 3. CREATE A VECTOR
#----------------------------------------------------------------

# Five participants completed a short memory task.
# Their scores were:
#
# 7, 9, 6, 10, 8
#
# Store these values in an object called "memory_scores"
# using c().



# Print memory_scores to make sure it worked.



#----------------------------------------------------------------
# 4. USE FUNCTIONS
#----------------------------------------------------------------

# Use the appropriate functions to find:
#
# - the mean memory score

# - the standard deviation of the memory scores

# - the number of scores in the vector



# Now save the mean in an object called "mean_memory".



# Print mean_memory.



#----------------------------------------------------------------
# 5. ADD A USEFUL COMMENT
#----------------------------------------------------------------
# Above the line below, write a comment explaining WHY we might
# calculate the standard deviation of the memory scores.



sd(memory_scores)


#----------------------------------------------------------------
# 6. DEBUGGING: WHAT WENT WRONG?
#----------------------------------------------------------------

# Each piece of code below contains a mistake.
# Run it, look at the error, and then FIX the code.


# ERROR 1

favorite_analysis <- ttest

# What was wrong?
#



# Corrected code:



# ERROR 2

mean(memory_score)

# What was wrong?
#



# Corrected code:



#----------------------------------------------------------------
# 7. USING A PACKAGE
#----------------------------------------------------------------

# Load the psych package.



# Use describe() to get a more detailed summary of memory_scores.



#----------------------------------------------------------------
# 8. QUICK REFLECTION
#----------------------------------------------------------------

# Answer these questions using comments (#) in your R script.

# 1. What is the difference between creating an object and using a function?
#
#


# 2. Which error in this exercise do you think would be easiest
#    to accidentally make when working in R?
#
#


#----------------------------------------------------------------
# YOU'RE DONE!
#----------------------------------------------------------------
