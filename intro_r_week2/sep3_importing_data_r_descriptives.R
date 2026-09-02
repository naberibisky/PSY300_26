# Working with Data (Data in a Package)
############################################################

# There are three types of ways we can access data in R.
# We can type it out manually/"by hand" -- this is really rare (1)
# We can get it from a package (2) OR
# We can import it (3) 

# Let's ignore the first one and talk about (2) for now, we will get to (3) later in
# the course

# To import data from a package we first have to install and load the package
# Then we have access to all of the content inside.

##########################################################
# ACCESSING DATA THAT LIVES IN A PACKAGE ####

# a) make sure you have the package installed
# remove the hashtag from the next line and run it if you don't have the psych package installed yet
# install.packages("psych")

# b) load the package
library(psych)

# c) call (request) the data in the package
data(sat.act) # take a look at your environment - the data has appeared along with
# <Promise> which is basically a placeholder - it will load it into
# memory once we actually use it

# d) explore!
# The head() function
head(sat.act) # take a look in your environment now - now we actually see some information
# about the data. We have 700 observations of 6 variables.
# The head() function will show us the first six rows of our data.
# I ALWAYS use the head function for new data I am exploring because
# I want to make sure that everything looks as it should - I am seeing
# numbers where numbers should be, characters where characters should be, etc.
# by default head() displays the first six entries, but you could change this 
# using the n argument
head(sat.act, n = 20)

# The tail() function - same as head() but displays the last six rows of the data
tail(sat.act)

# Take a look at at these columns - education is entered in using numbers, with higher numbers
# probably corresponding to higher levels of education, gender also has numeric codes.
# To see what the numbers mean we can ask to get some additional information on the dataset using
?sat.act # this only works because our dataset has come from a package. We couldn't do this
# on a dataset we have imported.

# From the help file we can see that the dataset has coded education ranging from high school = 1 to
# Graduate work = 5
# What about the rest of the labels? We see the ranges for SATV (SAT verbal), SATQ (Sat Quantitative), ACT
# gender appears to be dichotomously coded here with males = 1, females = 2
# The amount of detail on these datasets in R (just like R functions), will definitely vary with the package
# some help files are going to be INCREDIBLE while other ones will be a little more sparse.

# Let's do some more exploring
# The str() function
str(sat.act) # all of these variables are integers - meaning they are whole numbers
# note then that if we wanted R to treat something like education as a categorical
# variable (e.g., high school, grad school, etc) we would probably need to do some
# fiddling

# What if you want to see the entire dataset?
# Two options:
# click the mini spreadsheet icon beside your data in the environment OR
# the View() function
View(sat.act) # this will allow you to view the entire dataset in another tab
# in my opinion, R isn't fantastic for viewing data like this...

# what if I wanted to see the column names? Here we only have six columns but we might have
# hundreds!
# The colnames() function
colnames(sat.act) # See the quotation marks around the variable names? This is exactly how the
# variables are stored internally in R. This is a *really important* detail.
# Sometimes, especially when you import data from CSVs or Excel, variables will
# have unexpected characters — extra spaces, stray punctuation, uppercase/lowercase
# differences, or underscores you didn’t expect.

# For example:
# "education  "  is *not* the same as  "education"
# There are two extra spaces in the first one!
# R needs the variable name to match *exactly*, down to every letter, space,
# and symbol. If the name is even slightly off, R won’t recognize it.
# This is very common when working with real data and can be a pain.
# The good news is: you can always rename variables to something clean and simple.

# We can see how many rows there are using nrow()
nrow(sat.act) # 700 observations - which is what we see in our environment.

# we can do the same thing with columns using ncol()
ncol(sat.act)

# there are also summary functions to summarize our data
summary(sat.act) # ranges, means, medians
describe(sat.act) # I love this function from the psych package! We will be using it a lot
# What do you notice about the SATQ variable?


# What if we want to access a variable in a dataset?
# We use the $ operator!
# The text to the left of the dollar sign is the data frame, the text the right is the column
# we would like to see
sat.act$education # this is all of the education data
sat.act$ACT # this is all of the ACT data

# The $ operator is really useful and we will be relying on it A LOT.
# We can use the $ in tandem with other functions.
# For example:
# We can get means:
mean(sat.act$ACT)

# We can plot data with it
hist(sat.act$SATQ, col = "rosybrown1")

# Make it nicer
hist(
  sat.act$SATQ,
  breaks = 20,                              # more bins = smoother shape
  col = "rosybrown1",                          # soft rose color
  border = "#8B5E5E",                       # darker border for contrast
  main = "Distribution of SATQ Scores",     # clean, centered title
  xlab = "SATQ Score",                      # labeled x-axis
  ylab = "Frequency",                       # labeled y-axis
  cex.main = 1.4,                           # slightly larger title
  cex.lab = 1.2,                            # larger axis labels
  cex.axis = 1.1,                           # larger axis tick labels
  las = 1                                   # horizontal y-axis labels
)


# For variables like education it may not be as useful to see statistics means and medians
# (remember we have categories)
# so the describe function may not be as useful
describe(sat.act)
describe(sat.act$education) # this is just for education - same thing but cleaner
table(sat.act$education) # table will do a better job to see the spread

education_table <- table(sat.act$education) # you can save this table, notice the 0, range is 1-5
barplot(education_table, col = "lightblue") # and create a bar graph to visualize the spread!


# we can see how related verbal and quantitative SAT scores are

# we can do this with a scatterplot
plot(sat.act$SATV, sat.act$SATQ, xlab = "Verbal SAT Score",
                                 ylab = "Quantitative SAT Score")


# we can add a line that summarizes the association
abline(lm(sat.act$SATV ~ sat.act$SATQ), data = sat.act)

# we can calculate the correlation
cor(sat.act$SATV, sat.act$SATQ, use = "complete.obs") # the use complete means that we will only use pairs
                                                      # where nothing is missing
