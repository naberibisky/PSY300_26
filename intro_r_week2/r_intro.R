# PSYC 300
# Programming Basics in R: Objects, Comments, Functions, Packages



# R AS A CALCULATOR (JUST TO WARM UP)
# R can act like a calculator:

2 + 3
10 - 4
5 * 6
21 / 3

# R will follow normal order of operations:
2 + 3 * 4        # Multiplication happens first: 3*4 = 12, then + 2 = 14
(2 + 3) * 4      # Parentheses change the order: (2+3) = 5, then * 4 = 20


# 1. OBJECTS AND ASSIGNMENT
# In R, we store things in "objects".
# The arrow "<-" is the assignment operator: it stores a value in a name.

# Creating a simple object:
x <- 5           # "x" now holds the value 5

# To see what x is, just type its name:
x

# We can use x in other expressions:
x + 3            # 5 + 3 = 8

# We can reassign an object:
x <- 10          # x is now 10, not 5 anymore
x

# A slightly more descriptive example:
# Number of participants in our study:
n_participants <- 25

# We can create a new object using an existing one:
# Adding 5 more participants:
total_participants <- n_participants + 5

n_participants
total_participants

# 1a. A COMMON ERROR: USING AN OBJECT THAT DOESN'T EXIST
# Let's try to use an object that we never created:

study_name

# This will give an error like:
# Error: object 'study_name' not found
#
# Why? Because R has no idea what "study_name" is yet.

# FIX:
# We need to create (assign) the object first:

study_name <- "Memory Experiment"
study_name


# 2. COMMENTS IN R

# Comments are notes we write for ourselves (and future us!).
# R ignores lines that start with # when running code.

# This is a comment. R does not run it.

# Creating an object called "avg_score" to store the average test score:
avg_score <- 82

avg_score   # R will run this line, but ignore the comment above and at the
# end of this line.

# Accordingly, you can also put comments at the end of a line:
max_score <- 100   # maximum possible score on the test

# Good comments explain WHY we’re doing something, not just what:
# We want to know how far our average is from the maximum score:
distance_from_max <- max_score - avg_score



# 2a. COMMENTING EXAMPLE WITH MULTIPLE OBJECTS

# Number of items on a questionnaire:
n_items <- 10

# Total number of responses we collected (participants * items):
total_responses <- total_participants * n_items

total_responses


# 3. BASIC TYPES AND VECTORS

# Different kinds of objects have different "types":
# - numeric
# - character (text)
# - logical (TRUE/FALSE)
# - vectors (collections of values)

# A numeric object:
age <- 21

# A character object (needs quotes):
student_name <- "Alex"

# A logical object:
passed_exam <- TRUE

# A vector: a collection of values under one name:
exam_scores <- c(78, 85, 92, 74, 88)  # c() "combines" values into a vector

exam_scores

# We can ask R what type an object is:
class(age)
class(student_name)
class(passed_exam)
class(exam_scores)


# 3a. A COMMON ERROR: FORGETTING QUOTES AROUND TEXT


# Let's cause a problem on purpose:
favorite_course <- stats      # No quotes!

# R will either complain that 'stats' is not found, or may interpret it
# as something else (e.g., the stats package), which is NOT what we meant.

# FIX:
# Put quotation marks around text to make it a character object:

favorite_course <- "stats"
favorite_course


# 4. FUNCTIONS: WHAT THEY ARE AND HOW THEY WORK

# A function is a reusable piece of code that does something for us.
# Examples: mean(), sum(), sd(), length(), etc.

# Let's start with mean(). It calculates the average of a numeric vector.
exam_scores
mean(exam_scores)    # mean of the exam scores

# We can also use other functions:
sum(exam_scores)     # total of all scores
length(exam_scores)  # how many values in the vector?


# 4a. ARGUMENTS: GIVING FUNCTIONS THE INFORMATION THEY NEED

# Functions often need "arguments" (inputs).
# mean(x = exam_scores): x is the first argument

mean(exam_scores)         # We didn't name the argument, but R knows exam_scores is x
mean(x = exam_scores)     # Same thing, just more explicit

# Let's see what happens if we forget to give mean() any data:

mean()

# This will give an error like:
# Error in mean.default() : argument "x" is missing, with no default
#
# Why? Because x is a required argument.

# FIX:
mean(exam_scores)    # Now it works, because we told R what data to use.



# 4b. OPTIONAL ARGUMENTS (WITH DEFAULTS)

# Some arguments are optional. For example, mean() has an optional argument
# called "trim" that lets us trim a proportion of data from each end.

# Regular mean:
mean(exam_scores)

# Trimmed mean (removing 10% from each tail):
mean(exam_scores, trim = 0.10)

# Here, "trim" is optional. If we don’t specify it, R assumes trim = 0.


# 4c. A COMMON ARGUMENT ERROR: MIS-SPELLING NAMES

# Let's mis-spell "trim":

mean(exam_scores, trimm = 0.10)

# This will either be ignored or cause a warning/error, depending on the function,
# because "trimm" is not a recognized argument name.

# FIX:
mean(exam_scores, trim = 0.10)



# 5. PACKAGES: INSTALLING AND LOADING

# Packages are collections of functions and data built by other people.
# Example: the "psych" package provides many helpful functions for psychology.

# Step 1: Install a package (you only need to do this once per computer):
# (Note: you might NOT want to actually run this in class if it's already installed.)

# install.packages("psych")

# Step 2: Load the package EVERY TIME you start a new R session:

library(psych)

# If the package is installed, this should load with no error.


############################################################
# 5a. COMMON PACKAGE ERROR: CALLING A FUNCTION WITHOUT LOADING THE PACKAGE
############################################################

# Let's pretend we never loaded psych and try to use describe():

# First, restart R or imagine a new session where psych isn't loaded.
# Then:

describe(exam_scores)

# Likely error:
# Error in describe(exam_scores) : could not find function "describe"

# FIX:
# We need to load the package that contains describe():

library(psych)
describe(exam_scores)



# 5b. A COMMON INSTALLATION ERROR: TYPING A PACKAGE NAME WRONG


# Let's mis-type the package name on purpose:
# (Don't actually run this if you don't want the error in your console.)

# install.packages("psyc")   # <- wrong name

# This will lead to an error because there is no package called "psyc".

# FIX:
# Check the spelling and try again:
# install.packages("psych")   # correct


# 6. HELP FILES IN R

# You can ask R for help on a function by using ?function_name:

?mean          # Opens the help page for mean()
?describe      # Help for describe() (psych must be loaded)

# Note: If nothing happens, make sure:
# 1) The package is installed
# 2) The package is loaded
# 3) You spelled the function name correctly


# 7. PUTTING IT ALL TOGETHER: A MINI WORKED EXAMPLE

# Let's imagine we collected exam scores for 5 students.
# Step 1: Store the scores in a vector:

exam_scores <- c(78, 85, 92, 74, 88)

# Step 2: Comment why we're doing things:

# We want to summarize the exam scores to understand overall performance.

# Mean (average) score:
mean_exam <- mean(exam_scores)

# Standard deviation (spread of scores):
sd_exam <- sd(exam_scores)

# Number of students:
n_exam <- length(exam_scores)

# Print them out:
mean_exam
sd_exam
n_exam

# Step 3: Use a package function for a more detailed summary:

library(psych)
describe(exam_scores)

# Step 4: A *deliberate* mistake to talk about:

# Oops, let's try to use "exam_score" (singular) instead of "exam_scores":

mean(exam_score)

# Error: object 'exam_score' not found
# Why? Because we called the object by the wrong name.
# R is very literal. It will NOT guess what we meant.

# FIX:
mean(exam_scores)

