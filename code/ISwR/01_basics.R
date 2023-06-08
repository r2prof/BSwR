########### Introductory Statistics with R #####################
# 
# Chapter - 01 - Basics

#***********************Feb16-2020*****************************

library(ISwR)

# Test
plot(rnorm(1000))

# e raise to the power of -2
exp(-2)

# Assignments

x <- 2
x
x <- 3
x

# Vectorized arithmetic

weight <- c(60, 72, 57, 90, 95, 72)
weight

height <- c(1.75, 1.80, 1.65, 1.90, 1.74, 1.91)
bmi <- weight/height^2
bmi

sum(weight)
sum(weight)/length(weight)

xbar <- sum(weight)/length(weight)
weight - xbar
(weight - xbar)^2
sum((weight - xbar)^2)
sqrt(sum((weight - xbar)^2)/(length(weight) - 1))

mean(weight)

sd(weight)

# As a slightly more complicated example of what R can do, consider the
# following: The rule of thumb is that the BMI for a normal-weight individual
# should be between 20 and 25, and we want to know if our data
# deviate systematically from that. You might use a one-sample t test to assess
# whether the six persons' BMI can be assumed to have mean 22.5 given
# that they come from a normal distribution. To this end, you can use the
# function t.test. (You might not know the theory of the t test yet. The
# example is included here mainly to give some indication of what "real"
# statistical output looks like. A thorough description of t.test is given in
# Chapter 5.)

t.test(bmi, mu=22.5)

# Graphics
height
weight
plot(height,weight)

# The idea behind the BMI calculation is that this value should be independent
# of the person's height, thus giving you a single number as an
# indication of whether someone is overweight and by how much. Since
# a normal BMI should be about 22.5, you would expect that weight = 
# 22.5 × height^2. Accordingly, you can superimpose a curve of expected
# weights at BMI 22.5 on the figure:

hh <- c(1.65, 1.70, 1.75, 1.80, 1.85, 1.90)
hh
lines(hh, 22.5 * hh^2)

plot(height, weight, pch=2)

plot(y=weight,x=height) 

# Get the same plot as with

plot(x=height,y=weight)

# Vectors
# We have already seen numeric vectors. There are two further types,
# character vectors and logical vectors.
# A character vector is a vector of text strings, whose elements are specified
# and printed in quotes:

c("Huey","Dewey","Louie")

c(T,T,F,T)

bmi
bmi > 25

# If you dont want the "" quotes then use cat command

cat(c("Huey","Dewey","Louie"))

cat("What is \"R\"?\n")

x <- c(1, 2, 3)
y <- c(10, 20)
z <- c(x, y, 5)
z
x <- c(red="Huey", blue="Dewey", green="Louie")
x
names(x)

# Sequence Function

seq(4,9)

# Yields, as shown, the integers from 4 to 9. 
# If you want a sequence in jumps of 2, write

seq(4,10,2)


# Replicate Function
# rep ("replicate")

oops <- c(7,9,13)
rep(oops,3)

rep(oops,1:3)

# The second call has the number 3 replaced by a vector with the
# three values (1, 2, 3); these values correspond to the elements of the oops
# vector, indicating that 7 should be repeated once, 9 twice, and 13 three
# times.

# The rep function is often used for things such as group codes: If it
# is known that the first 10 observations are men and the last 15 are women,
# you can use

rep(1:2,c(10,15))

# to form a vector that for each observation indicates whether it is from a
# man or a woman.

# The special case where there are equally many replications of each value
# can be obtained using the each argument. E.g., rep(1:2,each=10) is
# the same as rep(1:2,c(10,10)).

rep(1:2,each=10) 

rep(1:2,c(10,10))

# Metrices and Arrays

x <- 1:12
dim(x) <- c(3,4)
x

# A convenient way to create matrices is to use the matrix function:

matrix(1:12,nrow=3,byrow=T)

x <- matrix(1:12,nrow=3,byrow=T)
rownames(x) <- LETTERS[1:3]
x

# Transpose

t(x)

# cbind and rbind

cbind(A=1:4,B=5:8,C=9:12)
rbind(A=1:4,B=5:8,C=9:12)


#***********************Feb 18-2020*****************************
# Factors
# The terminology is that a factor has a set of levels-say four levels for concreteness.
# Internally, a four-level factor consists of two items: (a) a vector of
# integers between 1 and 4 and (b) a character vector of length 4 containing
# strings describing what the four levels are. Let us look at an example: 

pain <- c(0,3,2,2,1)
fpain <- factor(pain,levels=0:3)
fpain
levels(fpain) <- c("none","mild","medium","severe")
fpain
as.numeric(fpain)

# Lists
# It is sometimes useful to combine a collection of objects into a larger
# composite object. This can be done using lists.
# You can construct a list from its components with the function list.
# As an example, consider a set of data from Altman (1991, p. 183) concerning
# pre- and postmenstrual energy intake in a group of women. We can
# place these data in two vectors as follows:

intake.pre <- c(5260,5470,5640,6180,6390,
                    + 6515,6805,7515,7515,8230,8770)

intake.post <- c(3910,4220,3885,5160,5645,
                   + 4680,5265,5975,6790,6900,7335)
intake.pre
intake.post

# To combine these individual vectors into a list, you can say
mylist <- list(before=intake.pre,after=intake.post)
mylist

# The components of the list are named according to the argument names
# used in list. Named components may be extracted like this:

mylist$before
mylist$after


# Data frames
# A data frame corresponds to what other statistical packages call a "data
# matrix" or a "data set". It is a list of vectors and/or factors of the same
# length that are related "across" such that data in the same position come
# from the same experimental unit (subject, animal, etc.). In addition, it has
# a unique set of row names.
# You can create data frames from preexisting variables:

d <- data.frame(intake.pre,intake.post)
d

# As with lists, components (i.e., individual variables) can be accessed using
# the $ notation:

d$intake.pre

# Indexing
# If you need a particular element in a vector, for instance the premenstrual
# energy intake for woman no. 5, you can do

intake.pre[5]
 
# If you want a subvector consisting of data for more than one woman, for
# instance nos. 3, 5, and 7, you can index with a vector:

intake.pre[c(3,5,7)]

# Note that it is necessary to use the c(...)-construction to define the vector
# consisting of the three numbers 3, 5, and 7. intake.pre[3,5,7]
# would mean something completely different. It would specify indexing
# into a three-dimensional array.

# Of course, indexing with a vector also works if the index vector is stored
# in a variable. This is useful when you need to index several variables in
# the same way.

v <- c(3,5,7)
intake.pre[v]

# It is also worth noting that to get a sequence of elements, for instance the
# first five, you can use the a:b notation:

intake.pre[1:5]

# A neat feature of R is the possibility of negative indexing. You can get all
# observations except nos. 3, 5, and 7 by writing

intake.pre[-c(3,5,7)]

# It is not possible to mix positive and negative indices. That would be
# highly ambiguous.

# Conditional selection
# We saw in Section 1.2.11 how to extract data using one or several indices.
# In practice, you often need to extract data that satisfy certain criteria, such
# as data from the males or the prepubertal or those with chronic diseases,
# etc. This can be done simply by inserting a relational expression instead
# of the index,

intake.post[intake.pre > 7000]

# Yielding the postmenstrual energy intake for the four women who had an
# energy intake above 7000 kJ premenstrually.


# For instance, we find the postmenstrual intake for women with a premenstrual intake between
# 7000 and 8000 kJ with

intake.post[intake.pre > 7000 & intake.pre <= 8000]

# There are also && and ||, which are used for flow control in R
# programming. However, their use is beyond what we discuss here.
# It may be worth taking a closer look at what actually happens when you
# use a logical expression as an index. The result of the logical expression is
# a logical vector as described in Section 1.2.3:

intake.pre > 7000 & intake.pre <= 8000

# Indexing with a logical vector implies that you pick out the values where
# the logical vector is TRUE, so in the preceding example we got the 8th and
# 9th values in intake.post.

# In addition to the relational and logical operators, there are a series of
# functions that return a logical value. A particularly important one is
# is.na(x), which is used to find out which elements of x are recorded
# as missing (NA).

# Notice that there is a real need for is.na because you cannot make
# comparisons of the form x==NA. That simply gives NA as the result for
# any value of x. The result of a comparison with an unknown value is
# unknown!

# Indexing of data frames
# We have already seen how it is possible to extract variables from a
# data frame by typing, for example, d$intake.post. However, it is also
# possible to use a notation that uses the matrix-like structure directly:

d <- data.frame(intake.pre,intake.post)
d
d[5,1]

#Above command gives fifth row, first column (that is, the "pre" measurement for woman
# no. 5), and

d[5,]

# Gives all measurements for woman no. 5. Notice that the comma in d[5,]
# is required; without the comma, for example d[2], you get the data frame
d[2]

# consisting of the second column of d (that is, more like d[,2], which is the
# column itself).

d[,2]

# Other indexing techniques also apply. In particular, it can be useful to extract
# all data for cases that satisfy some criterion, such as women with a
# premenstrual intake above 7000 kJ:

d[d$intake.pre > 7000,]

# If you want to understand the details of this, it may be a little easier if it is
# divided into smaller steps. It could also have been done like this:

sel <- d$intake.pre>7000
sel

d[sel,]

# What happens is that sel (select) becomes a logical vector with the value
# TRUE for to the four women consuming more than 7000 kJ premenstrually.
# Indexing as d[sel,] yields data from the rows where sel is TRUE and
# from all columns because of the empty field after the comma.
# 
# It is often convenient to look at the first few cases in a data set. This can be
# done with indexing, like this:

d[1:2,]

# This is such a frequent occurrence that a convenience function called head
# exists. By default, it shows the first six lines.

head(d)
tail(d)

# Grouped data and data frames
# The natural way of storing grouped data in a data frame is to have the data
# themselves in one vector and parallel to that have a factor telling which
# data are from which group. Consider, for instance, the following data set
# on energy expenditure for lean and obese women.

library(ISwR)

# Then attach the data

energy

# This is a convenient format since it generalizes easily to data classified
# by multiple criteria. However, sometimes it is desirable to have data in a
# separate vector for each group. Fortunately, it is easy to extract these from
# the data frame:

exp.lean <- energy$expend[energy$stature=="lean"]
exp.lean
exp.obese <- energy$expend[energy$stature=="obese"]
exp.obese

# Alternatively, you can use the split function, which generates a list of
# vectors according to a grouping.

l <- split(energy$expend, energy$stature)
l


# A common application of loops is to apply a function to each element of
# a set of values or vectors and collect the results in a single structure. In
# R this is abstracted by the functions lapply and sapply. The former
# always returns a list (hence the 'l'), whereas the latter tries to simplify
# (hence the 's') the result to a vector or a matrix if possible. So, to compute
# the mean of each variable in a data frame of numeric vectors, you can do
# the following:

lapply(thuesen, mean, na.rm=T)

sapply(thuesen, mean, na.rm=T)

# Notice how both forms attach meaningful names to the result, which
# is another good reason to prefer to use these functions rather than explicit
# loops. The second argument to lapply/sapply is the function that
# should be applied, here mean. Any further arguments are passed on to the
# function; in this case we pass na.rm=T to request that missing values be
# removed

# Sometimes you just want to repeat something a number of times but still
# collect the results as a vector. Obviously, this makes sense only when the
# repeated computations actually give different results, the common case
# being simulation studies. This can be done using sapply, but there is a
# simplified version called replicate, in which you just have to give a
# count and the expression to evaluate:

replicate(10,mean(rexp(20)))

# A similar function, apply, allows you to apply a function to the rows
# or columns of a matrix (or over indices of a multidimensional array in
# general) as in
m <- matrix(rnorm(12),4)
m

apply(m, 2, min)

# The second argument is the index (or vector of indices) that defines what
# the function is applied to; in this case we get the columnwise minima.
# Also, the function tapply allows you to create tables (hence the 't') of the
# value of a function on subgroups defined by its second argument, which
# can be a factor or a list of factors. In the latter case a cross-classified table
# is generated. (The grouping can also be defined by ordinary vectors. They
# will be converted to factors internally.)

tapply(energy$expend, energy$stature, median)

# Sorting
# It is trivial to sort a vector. Just use the sort function. (We use the builtin
# data set intake here; it contains the same data that were used in
# Section 1.2.9.)

intake$post
sort(intake$post)

# However, sorting a single vector is not always what is required. Often
# you need to sort a series of variables according to the values of some other
# variables - blood pressures sorted by sex and age, for instance. For this
# purpose, there is a construction that may look somewhat abstract at first
# but is really very powerful. You first compute an ordering of a variable.

order(intake$post)

# The result is the numbers 1 to 11 (or whatever the length of the vector
# is), sorted according to the size of the argument to order (here
# intake$post). Interpreting the result of order is a bit tricky-it should
# be read as follows: You sort intake$post by placing its values in the
# order no. 3, no. 1, no. 2, no. 6, etc.

# The point is that, by indexing with this vector, other variables can be
# sorted by the same criterion. Note that indexing with a vector containing
# the numbers from 1 to the number of elements exactly once corresponds
# to a reordering of the elements.

o <- order(intake$post)
o

intake$post[o]

intake$pre[o]

# What has happened here is that intake$post has been sorted - just as
# in sort(intake$post) - while intake$pre has been sorted by the
# size of the corresponding intake$post.
# It is of course also possible to sort the entire data frame intake

intake.sorted <- intake[o,]
intake.sorted

# Sorting by several criteria is done simply by having several arguments to
# order; for instance, order(sex,age) will give a main division into men
# and women, and within each sex an ordering by age. The second variable
# is used when the order cannot be decided from the first variable. Sorting
# in reverse order can be handled by, for example, changing the sign of the
# variable.

